nn = 1e3;
p_s = 3.0;
p_n = 7.0;

S=exp(1i*2*pi*(1:nn)/20000)*sqrt(p_s);
DS=[];
for ii=(1:1000)
    N=sqrt(p_n/2)*(randn(1,nn)+randn(1,nn)*1i);
    R=S+N;
    DS(end+1) = (abs(sum(R.*conj(S)))^2) / sum(abs(R).^2) / sum(abs(S).^2);
end
mean(DS)
figure(1)
hist(DS)

SNRs=(-10:25);
DS=[];
for snr_db=SNRs
    snr = 10^(snr_db/10);
    DS(end+1) = snr / (snr + 1);
end
figure(2)
plot(SNRs, DS, '.-');
grid on;
xlabel("SNR (dB)")
ylabel("Detection score")
ylim([0,1])

figure(3)
plot(10.^(SNRs/10), DS, '.-');
grid on;
xlabel("SNR (decimal scale)")
ylabel("Detection score")
ylim([0,1])

