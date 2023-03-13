
pkg load signal

sigma_s_2=20;

n=90;
m=41;
fn=0.0001;
theta_0=30*180/pi;

S=sqrt(sigma_s_2)*exp(1i*(2*pi*(0:n-1)*fn + theta_0));
signal_power = mean(S.*conj(S))

function result = the_r(S, k)
  Sk = S(k+1:end  );
  S0 = S(1  :end-k);
  result = sum(Sk.*conj(S0))/(numel(S)-k);
end

RR=[]
for k=(1:m)
  RR(k)=the_r(S,k);
end

H1 = [sum(imag(RR)), 2*m*arg(sum(RR))]
H2 = [sum((1:m).*real(RR)), m*(m+1)/2]
H1./H2(1)/(2*pi)

arg(sum(RR))/(m+1)/pi



function v = calculate_var_k(n, k, rho)
  x = 1/(4*pi*pi*k*k*(n-k)*rho);
  if k<=n/2
    v = x*(k/(n-k) + 1/(2*rho));
  else
    v = x*(1 + 1/(2*rho));
  end
end

function VV = calculate_var_all(n, rho)
  VV=[];
  for kk=(1:n/2)
    x = 1/(4*pi*pi*kk*kk*(n-kk)*rho);
    v = x*(kk/(n-kk) + 1/(2*rho));
    VV(end+1) = v;
  end
  for kk=(n/2+1:n-1)
    x = 1/(4*pi*pi*kk*kk*(n-kk)*rho);
    v = x*(1 + 1/(2*rho));
    VV(end+1) = v;
  end
end

trials = 1e5;


SNR_dbs = (3:3);
All_CRLBs = zeros(1,numel(SNR_dbs));
All_LR_errors = zeros(1,numel(SNR_dbs));
All_MLA_errors = zeros(1,numel(SNR_dbs));
All_LR2_errors = zeros(1,numel(SNR_dbs));
Mean_LR_errors = zeros(1,numel(SNR_dbs));
Mean_MLA_errors = zeros(1,numel(SNR_dbs));
Mean_LR2_errors = zeros(1,numel(SNR_dbs));

W1 = (1:n-1).*(n-(1:n-1));
W1 = W1 / sum(W1);

RR = [];

for jj = (1:numel(SNR_dbs))
  snr = SNR_dbs(jj)
  rho = 10^(snr/10);

  VV = calculate_var_all(n, rho);
  NVV = (1/sum(1./VV))*(1./VV);

  sigma_n_2=sigma_s_2 / rho;
  N=sqrt(sigma_n_2/2)*randn(trials,n) + 1i* sqrt(sigma_n_2/2)*randn(trials,n);

  LR_errors = [];
  MLA_errors = [];
  LR2_errors = [];
  for ii=(1:trials)
    SN = S+N(ii,:);
    R = zeros(1,n-1);
    for kk=(1:n-1)
      R(kk) = the_r(SN, kk);
    end
    lr_error = fn - arg(sum(R(1:m)))/(pi*(m+1));
    RR = vertcat(RR, fn - arg(R)./(1:n-1)/(2*pi));
    LR_errors(end+1) = lr_error;
    K = (1:n-1);
    mla_error = fn - sum(W1.*arg(R)./(1:n-1)) / (2*pi);
    MLA_errors(end+1) = mla_error;
    a = 22;
    lr2_error = fn - arg(sum(R(n/2-a:n/2+a)))/(pi*n);
    LR2_errors(end+1) = lr2_error;
    if mod(ii,1000) == 0
      fprintf("%d\n", ii);
    end
  end
  All_CRLBs(jj) = sqrt(3/(2*pi*pi*rho*n*(n*n-1)));
  All_LR_errors(jj) = std(LR_errors);
  All_MLA_errors(jj) = std(MLA_errors);
  All_LR2_errors(jj) = std(LR2_errors);
  Mean_LR_errors(jj) = mean(LR_errors);
  Mean_MLA_errors(jj) = mean(MLA_errors);
  Mean_LR2_errors(jj) = mean(LR2_errors);
  figure(1)
  clf;
  subplot(2,1,1)
  hold on
  semilogy(SNR_dbs, All_CRLBs, '.-');
  semilogy(SNR_dbs, All_LR_errors, '.-');
  semilogy(SNR_dbs, All_MLA_errors, '.-');
  semilogy(SNR_dbs, All_LR2_errors, '.-');
  legend("CRLB", "L&R", "ML approx", "LR 2");
  grid on;
  subplot(2,1,2)
  hold on
  semilogy(SNR_dbs, abs(Mean_LR_errors), '.-');
  semilogy(SNR_dbs, abs(Mean_MLA_errors), '.-');
  semilogy(SNR_dbs, abs(Mean_LR2_errors), '.-');
  legend("L&R", "ML approx", "LR 2");
  grid on;
  pause(0.01);
  
  figure(2);
  clf;hold on;semilogy(VV);plot(var(RR))
  grid on
  legend("formula", "simulation")
  xlabel("k")
  ylabel("var estimated frequency error")
 
end

A=RR-mean(RR);
CV=(A')*A;
figure(10)
imagesc(20*log10(abs(CV))); axis equal;
axis image
%colorbar
xlabel("k")
ylabel("k")
set(gca,'YDir','normal')
