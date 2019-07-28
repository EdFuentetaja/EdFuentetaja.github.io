pkg load signal

path = '/home/edf/work/octave/';

function y = simple_interpolate(Y, x)
    x_i = floor(x);
    x_f = x - x_i;
    y_0 = Y(x_i);
    y_1 = Y(x_i+1);
    y = y_0*(1-x_f)+y_1*x_f;
end

% % ./mod_i_file.py -n 100 -i ~/work/IQ/pp_1.json -o ~/work/IQ/vvv_osr_10
filename = 'xxx_osr_10_cropped.phase_diff.bbiq'
phase_filename = 'xxx_osr_10_cropped.phase_diff'
t=10;
offset_to_add = 0;
E = [0 1 2 3 4 5 -4 -3 -2 -1]/5;
extact_clock_offset = 7 + offset_to_add;


% ./mod_i_file.py -n 100 -i ~/work/IQ/pp_1.json -o ~/work/IQ/vvv_osr_11
% filename = 'vvv_osr_11_cropped.phase_diff.bbiq'
% phase_filename = 'vvv_osr_11_cropped.phase_diff'
% t=11;
% offset_to_add = 2;
% E = [0 1 2 3 4 5 -5 -4 -3 -2 -1]/5;
% extact_clock_offset = 0 + offset_to_add;


fid = fopen([path filename]);
IQ = fread(fid, Inf, 'float', 0, 'ieee-le');
IQ = reshape(IQ, 2, numel(IQ)/2);
IQ = IQ(1,:) + i*IQ(2,:);
fclose(fid);

IQ = [repmat(IQ(1), 1, offset_to_add) IQ];
IQ=IQ(1:floor(numel(IQ)/t)*t);

power_IQ = sum(IQ.*conj(IQ))/numel(IQ)

% Add noise
noise_gain = 1
noise = (rand(1,numel(IQ))-0.5)*2*noise_gain * max(abs(real(IQ))) + ...
        i*(rand(1,numel(IQ))-0.5)*2*noise_gain * max(abs(imag(IQ)));
power_noise = sum(noise.*conj(noise))/numel(noise)

snr=10*log10(power_IQ/(power_noise+power_IQ))

IQ = IQ + noise;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter
b_input_filter = fir1(60,0.15);
IQ = filter(b_input_filter, 1, [IQ zeros(1, (numel(b_input_filter)-1)/2)]);
IQ = IQ((numel(b_input_filter)+1)/2:end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fid = fopen([path phase_filename]);
phase_diff_2 = fread(fid, Inf, 'float', 0, 'ieee-le')';
fclose(fid);
phase_diff_2 = [zeros(1, offset_to_add) phase_diff_2];
phase_diff_2 = phase_diff_2(1:floor(numel(phase_diff_2)/t)*t);

% calculate phase
iq_next_1 = [IQ(2:end) IQ(numel(IQ))];
iq_prev_1 = [IQ(1) IQ(1:end-1)];

phase_diff = arg(iq_next_1 .* conj(iq_prev_1))/2;
% No need to adjust with offset_to_add since it's coming from IQ which is already adjusted

fid = fopen([path 'phase_diff'], 'w');
fwrite(fid, phase_diff, 'float');
fclose(fid);

figure(1)
clf;
plot([0:numel(phase_diff)-1], phase_diff/max(abs(phase_diff)), '-*');


% IQ = IQ(580:580+80);  % 101010
% IQ = IQ(400:480+30);  % 000000


% fs = 758272/8;
fs = 768000/8;
fft_order = 16;

figure(16);
specgram_edf(IQ, fft_order, fs);

k=1;
ee = 2;

% Normalize IQ
IQ = IQ ./ abs(IQ);

R1=IQ(t*k+1:end);
R2=IQ(1:end-t*k);
% X=(R1.^ee).*conj(R2).^ee;
X=(R1.*conj(R2)).^ee;

% X0 = [X zeros(1,2*t)];
% X1 = [zeros(1,t) X zeros(1,t)];
% X2 = [zeros(1,2*t) X];
% X = (X0 + X1 + X2)(1:numel(X));


Z=real(diff(X/max(abs(X)),2));
Z=(-(-1)^k)*Z;
Z = [0 Z 0];
% Z=[Z(3:end) 0 0 0 0];

% Z=[zeros(1,t/2-1) Z];
% Z=Z(1:numel(X));

% Z = Z(10:end-10);

fid = fopen([path 'clock'], 'w');
fwrite(fid, Z, 'float');
fclose(fid);

figure(2)
FZ=abs(fft([Z zeros(1,fs-numel(Z))]));
FZ=FZ(1:(numel(FZ))/2);
plot(linspace(0,fs/2,numel(FZ)),20*log10(FZ));
xlim([0 fs/2])
set(gca, "fontsize", 16)
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Half pass band Filter design
ntaps= 19;
N= ntaps-1;
% n= -N/2:N/2;
% sinc= sin(n*pi/2)./(n*pi+eps);      % truncated impulse response; eps= 2E-16
% sinc(N/2 +1)= 1/2;                  % value for n --> 0
% win= kaiser(ntaps,6);               % window function
% b= sinc.*win';
b = fir2(N, [0 0.2 0.4 1], [0 1 0 0]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Z = filter(b,1,Z);
% Z = [Z(N/2+1:end) zeros(1,N/2)];


figure(22)
FF=abs(fft([Z zeros(1,fs-numel(Z))]));
FF=fftshift(FF);
plot(linspace(-fs/2,fs/2,numel(FF)),20*log10(FF));
xlim([-fs/2 fs/2]);
set(gca, "fontsize", 16)
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
grid on;

s=floor(numel(Z)/t);
ZZ=reshape(Z(1:s*t),t,s)';
SZZ = mean(ZZ);
    SZZ = interp(SZZ,2);
    % advance (t/4)*2
    % offset_szz=t/4+10-extact_clock_offset-1;
    offset_szz=10-extact_clock_offset-1;
    SZZ = [SZZ(offset_szz*2+1:end) SZZ(1:offset_szz*2)];
    SZZ = downsample(SZZ,2);
figure(3)
clf;
plot(linspace(-0.5,0.5,t+1), [SZZ SZZ(1)], '-*');
%ylim([-max(abs(SZZ)) max(abs(SZZ))]);
ylim([-0.1 0.1]);
xlim([-0.5 0.5]);
set(gca, "fontsize", 16)
xlabel('Normalized timing error');
h = findobj(gca, 'type', 'line');
set(h, 'LineWidth', 2)
grid on;


s=floor(numel(X)/t);
XX=reshape(X(1:s*t),t,s)';
SXX = mean(real(XX));
figure(33)
hold on;
plot(SXX, '-*');

figure(1)
hold on;
NSZZ=SZZ/max(abs(SZZ));

% plot([0:numel(phase_diff)-1], repmat(SZZ/max(abs(SZZ)),1,num_bits), '-*');
grid on;

figure(4)
clf
hold on
for ii=[1:size(ZZ,1)]
    plot(ZZ(ii,:));
end
title('ZZ');
grid on;

figure(5)
clf
hold on
for ii=[1:size(XX,1)]
    plot(real(XX(ii,:)));
end
title('real(XX)');
grid on;

figure(55)
clf
hold on
for ii=[1:size(XX,1)]
    plot(real(XX(ii,:)), imag(XX(ii,:)));
end
grid on;

num_bits = numel(X)/t;

E = repmat(E,1,num_bits);
E = [zeros(1,extact_clock_offset) E];

SI=zeros(1,numel(X));
EI=zeros(1,numel(X));

symbol_offset = 1+t;
clock_gain = 10;
NZ = (Z/max(abs(Z)))*t/2;
CD = zeros(1,1000);
index = 1;
error = zeros(1,1000);
bias = -t/4;
while symbol_offset < numel(X)
    SI(floor(symbol_offset+bias)) = symbol_offset+bias - floor(symbol_offset+bias);
    eee = simple_interpolate(E, symbol_offset + bias);
    error(index) = eee;
    EI(floor(symbol_offset+bias)) = eee;

    clock_delay = simple_interpolate(Z, symbol_offset);
    symbol_offset = symbol_offset  + t - clock_delay * clock_gain;
    CD(index)=clock_delay * clock_gain;
    index = index + 1;
end
CD = CD(1:index-1);
error = error(1:index-1);


figure(1)
hold on;
% plot(SI);
% plot(E, '-o');
% plot(EI, '-o');
% plot(real(X)/max(abs(real(X))), '-o');
plot([0:numel(Z)-1], Z/max(abs(Z)), '-o');


figure(7)
plot(error)
ylim([-1 1])
grid on
set(gca, 'ytick', [-1:0.2:1])
meansq_error=meansq(error)

function AA = calculate_VV(X, t, offset_r_t, ll)
  r_t=[0+offset_r_t:t-1+offset_r_t];
  R=cos(2*pi*r_t/t)-i*sin(2*pi*r_t/t);
  num_bits=numel(X)/t;
  R = repmat(R, 1, num_bits);
  V=R.*real(X);
  VV=zeros(1,numel(X));
  L=2;
  for ii=[1:numel(X)-t*L+1]
    vv=V(ii:ii+t*L-1);
    VV(ii)=sum(vv);
  end

  if (ll > 1)
    for ii=[1:numel(VV)-ll+1]
      vv=VV(ii:ii+ll-1);
      AA(ii)=mean(vv);
    end
  else
    AA=VV;
  end
end

figure(1);
hold on;
% plot(calculate_VV(X,t,1,1), '-*');

%lll_legend=zeros(2+10,100);
%lll_legend(1,:)='mean(ZZ)';
%lll_legend(2,:)='mean(real(XX))';
lll_legend = {};
figure(6)
clf;
min_offset_r_t = -1;
min_phase_r_t = 100;
_SV=zeros(t,num_bits);
for offset_r_t = [0:t-1]
  r_t=[0+offset_r_t:t-1+offset_r_t];
  R=cos(2*pi*r_t/t)-i*sin(2*pi*r_t/t);
  num_bits = numel(X)/t;
  R = repmat(R, 1, num_bits);
  V=X.*R;
  VV=reshape(V(1:s*t),t,s);
  SV=sum(VV);
  _SV(offset_r_t+1,:) = SV;
  SSV=sum(SV);
  figure(6)
  hold on
  plot([0 real(SSV)], [0 imag(SSV)], '-*');
  lll_legend{offset_r_t+1} = ["offset " num2str(offset_r_t)];
  pause(0.1)
  if (abs(arg(SSV)) < min_phase_r_t)
    min_phase_r_t = abs(arg(SSV));
    min_offset_r_t = offset_r_t;
  end
end
legend(lll_legend);
min_phase_r_t
min_offset_r_t

figure(101)
clf;
hold on
window_size=12;
for offset_r_t = [0:t-1]
  aa=_SV(offset_r_t+1,:);
  plot(arg(filter(ones(1,window_size)/window_size, 1, aa)))
end
