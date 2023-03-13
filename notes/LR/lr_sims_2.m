
sigma_s_2=20;

n=90;
m1=1;
m2=41;
fn=0.0;
snr = 3.0;
theta_0=30*180/pi;
trials = 5e4;
SNR_dbs = (0:1:12);
Fns = (-0.1:0.001:0.1);

%X = SNR_dbs;
X = Fns;

All_CRLBs = zeros(1,numel(X));
RMS_LR_errors = zeros(1,numel(X));
Mean_LR_errors = zeros(1,numel(X));
Max_abs_LR_errors = zeros(1,numel(X));


for jj = (1:numel(X))
  %snr = SNR_dbs(jj);
  fn = X(jj);

  rho = 10^(snr/10);
  fprintf("SNR: %f dB, fn: %f\n", snr, fn);

  S=sqrt(sigma_s_2)*exp(1i*(2*pi*(0:n-1)*fn + theta_0));
  signal_power = mean(S.*conj(S));
  sigma_n_2=sigma_s_2 / rho;

  LR_errors = [];
  for ii=(1:trials)
    N=sqrt(sigma_n_2/2)*randn(1,n) + 1i* sqrt(sigma_n_2/2)*randn(1,n);
    SN = S+N;
    sum_R = 0;
    for kk=(m1:m2)
      sum_R = sum_R + the_r(SN, kk);
    end
    lr_error = fn - angle(sum_R)/(pi*(m1+m2+1));
    LR_errors(end+1) = lr_error;
    if mod(ii,10000) == 0
        fprintf("%d\n",ii);
    end
  end
  All_CRLBs(jj) = sqrt(3/(2*pi*pi*rho*n*(n*n-1)));
  RMS_LR_errors(jj) = rms(LR_errors);
  Mean_LR_errors(jj) = mean(LR_errors);
  Max_abs_LR_errors(jj) = max(abs(LR_errors));
  fprintf("%f, %e, %e\n", X(jj), RMS_LR_errors(jj), Mean_LR_errors(jj));
  figure(1)
  clf;
  subplot(2,1,2)
  plot(X, Mean_LR_errors, '.-');
  hold on
  plot(X, Max_abs_LR_errors, '.-');
  legend("mean", "max abs");
  grid on;
  subplot(2,1,1)
  semilogy(X, All_CRLBs, '.-');
  hold on
  semilogy(X, RMS_LR_errors, '.-');
  legend("CRLB", "L&R");
  grid on;
  figure(2)
  plot(X, RMS_LR_errors - All_CRLBs);
  grid on;
  pause(0.01);
end

function result = the_r(S, k)
  Sk = S(k+1:end  );
  S0 = S(1  :end-k);
  result = mean(Sk.*conj(S0));
end
