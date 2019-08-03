fs=96000
f=12345
%n=fs*f/(gcd(fs,f)^2);
n=256;

t=(0:n-1);
so=1*(cos(2*pi*f*t/fs)+i*sin(2*pi*f*t/fs));



figure(1)
plot_fft(so, fs);

an=(0:0.1:4.5);
snr=zeros(1,numel(an));
error=zeros(100,numel(an));
for jj=(1:size(error,1))
for index=(1:numel(an));
  
  noise = an(index) * (2*(rand(1, numel(so))-0.5) + 2*i*(rand(1, numel(so))-0.5));
  s = so + noise;

  %Hann
  %gh=(1-cos(2*pi*t/n))/2;
  %gh=(1-cos(2*pi*t/n))/2;

  %figure(2)
  %fft_edf(s.*gh,fs)

  k=(0:n-1);
  S = fft(s);
  SS=(1-exp(i*2*pi*f*n/fs))./((1-exp(i*2*pi*f/fs).*exp(i*2*pi*k*(-1/n))));
  %k0=13;
  [W IW] = max(abs(S));
  k0 = IW-1;

  s_1=S(k0+1-1);
  s0=S(k0+1);
  s1=S(k0+1+1);

  alpha=exp(i*2*pi*f/fs);
  beta=exp(-i*2*pi*k0/n);
  gamma=exp(i*2*pi/n);

  alpha1 = (s1-s0)*gamma/(beta*(s1-s0*gamma));
  alpha2 = (s0-s_1)/(beta*(s0-s_1*gamma));

  iii=(-2:2);
  v = zeros(1,numel(ii)-1);
  jndex=1;
  for ii=iii
    if (ii != 0)
      %aa = (S(k0+1+ii)-S(k0+ii))*(gamma^ii)/((S(k0+1+ii)-S(k0+ii)*gamma)*beta);
      aa = (S(k0+1+ii)-S(k0+1))*(gamma^(ii+k0))/((S(k0+1+ii)-S(k0+1)*(gamma^ii)));
      v(jndex) = arg(aa)*fs/(2*pi);
      %v(jndex) = aa;
      jndex=jndex+1;
    end
  end
  %error(index)=abs(f - arg(mean(v))*fs/(2*pi));
  error(jj,index)=abs(f - mean(v));
  snr(index) = 20*log10(sum(abs(so))) - 20*log10(sum(abs(noise)));
end
end

figure(2)
plot(snr, mean(error), '*')
