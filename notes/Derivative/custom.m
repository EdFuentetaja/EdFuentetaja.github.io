
pkg load signal;

K=(0:255);
KL=(0:1024);
fs=96000;
f1=4800;
N=21;
df=f1/((N-1)/2);
SS=zeros(1, numel(K));
SSL=zeros(1, numel(KL));
for ii=(0:N-1)
  SS=SS+exp(j*2*pi*K*(-f1+df*ii)/fs);
  SSL=SSL+exp(j*2*pi*KL*(-f1+df*ii)/fs);
end

figure(1);
plot_fft(SS, fs);

figure(2);
clf;
plot(real(SS));
grid on;
xlim([0,numel(SS)]);
xlabel("Time");
ylabel("Amplitude");

SS2=SS(3:end);
SS0=SS(1:end-2);
DSS=[0 (SS2-SS0)/2];

figure(3);
clf;
plot(real(SS));
hold on;
plot(real(DSS));
grid on;
xlim([0,numel(SS)]);
xlabel("Time");
ylabel("Amplitude");
h = legend("Original signal", "Central-difference", "location", "northwest");

figure(4);
plot_fft(DSS, fs);

rand ("seed", 0)

mm=max(abs(SS));
WN=(rand(1,numel(SSL))*2-1)*mm/4;

WSS=SS+WN(1:numel(SS));
WSSL=SSL+WN;

figure(5);
clf;
plot(real(WSS));
grid on;
xlim([0,numel(SS)]);

WSS2=WSS(3:end);
WSS0=WSS(1:end-2);
DWSS=[0 (WSS2-WSS0)/2];



figure(6);
clf;
plot(real(WSS));
hold on;
plot(real(DWSS));
grid on;
xlim([0,numel(SS)]);
xlabel("Time");
ylabel("Amplitude");
legend("Original signal", "Central-difference", "location", "northwest");

figure(61);
clf;
plot(real(DSS), 'LineWidth', 4);
hold on;
plot(real(DWSS));
grid on;
xlim([0,numel(SS)]);
ylim([-5,5]);
xlabel("Time");
ylabel("Amplitude");
legend("Central-difference, no noise", "Central-difference, white noise", "location", "northwest");

figure(7);
plot_fft(WSS, fs);

B=remez(60,
       [0 0.13 0.14 1],
    pi*[0 0.13 0.0 0],
       [1 1]);

figure(8);
clf;
B=B.*hamming(numel(B));

[H W]=freqz(B);
hold on;
plot([0 1], [0 pi]);
plot([0 0.1 0.1000001 1], [0 0.1*pi 0 0], ":",'LineWidth', 4);
plot(W/pi, abs(H));
grid on;
xlim([0,0.3]);
ylim([0,1]);
ylabel('Amplitude');
xlabel('Normalized Frequency (x\pi rad/sample)');
legend("Ideal derivative", "Ideal ad-hoc derivative filter", "Actual ad-hoc derivative filter", "location", "northwest");

figure(9);
plot(B);
grid on;

DWSS2 = filter(B,1,WSSL);

figure(10);
clf;
hold on;
plot(real(DSS));
plot(real(DWSS2((numel(B)-1)/2+7:end)));
grid on;
xlim([0,numel(SS)]);
ylim([-5,5]);
xlabel("Time");
ylabel("Amplitude");
legend("Central-difference, no noise", "Ad-hoc derivative filter, white noise", "location", "northwest");
