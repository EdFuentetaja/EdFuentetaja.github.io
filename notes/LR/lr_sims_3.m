
sigma_s_2=20;

n=90;
fn=0.0;
snr = 3.0;
theta_0=30*180/pi;
trials = 1e5;



rho = 10^(snr/10);
fprintf("SNR: %f dB, fn: %f\n", snr, fn);

S=sqrt(sigma_s_2)*exp(1i*(2*pi*(0:n-1)*fn + theta_0));

signal_power = mean(S.*conj(S));
sigma_n_2=sigma_s_2 / rho;

%RMS_LR_errors = zeros(n-2,n-1);
load("RMS_LR_errors_3_db.mat");

Ops = zeros(n-2,n-1);

for m1 = (1:n-2)
    for m2 = (m1+1:n-1)
      LR_errors = zeros(1,trials);
      total_ops = 0;
      for ii=(1:trials)
        N=sqrt(sigma_n_2/2)*randn(1,n) + 1i* sqrt(sigma_n_2/2)*randn(1,n);
        SN = S+N;
        sum_R = 0;
        for kk=(m1:m2)
          [rr, ops] = the_r(SN, kk);
          sum_R = sum_R + rr;
          if (ii == 1)
              total_ops = total_ops + ops;
          end
        end
        lr_error = fn - angle(sum_R)/(pi*(m1+m2+1));
        LR_errors(ii) = lr_error;
      end
      rms_lr = rms(LR_errors);
      RMS_LR_errors(m1, m2) = rms_lr;
      Ops(m1, m2) = total_ops;

      fprintf("%d, %d, %e\n", m1, m2, rms_lr);

      figure(1)
      clf;
      cm0 = colormap;
      cm0;
      cm(1,:) = 0;
      colormap(cm);
      imagesc(RMS_LR_errors);
      set(gca,'YDir','normal')
      axis image;
      grid on;
      colorbar;
      xlabel("m2");
      ylabel("m1");
      figure(3)
      clf
      H = RMS_LR_errors;
      H(RMS_LR_errors==0)=nan;
      contour(H, log(exp(3.1e-4):2e-6:exp(0.0023)));
      % contour(H, horzcat((3.2e-4:2e-6:3.3e-4), log(exp(3.3e-4):1e-5:exp(0.0023))));
      axis image;
      colorbar;
      xlabel("m2");
      ylabel("m1");
      grid on;
      figure(4)
      clf;
      HO = Ops;
      HO(Ops == 0) = -inf;
      imagesc(HO);
      colormap(cm0);
      set(gca,'YDir','normal');
      axis image;
      grid on;
      xlabel("m2");
      ylabel("m1");
      colorbar;
      pause(0.01);
    end
end


function [result, ops] = the_r(S, k)
  Sk = S(k+1:end  );
  S0 = S(1  :end-k);
  result = mean(Sk.*conj(S0));
  ops = numel(Sk);
end
