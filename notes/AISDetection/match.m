IQ=[
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13309-20660i
4372-24183i
-4372-24183i
-13309-20660i
-20660-13309i
-24183-4372i
-24183+4372i
-20660+13309i
-13309+20660i
-4372+24183i
4372+24183i
13309+20660i
20660+13309i
24183+4372i
24183-4372i
20660-13309i
13309-20660i
4372-24183i
-4372-24183i
-13309-20660i
-20532-13505i
-23635-6730i
-23635-6730i
-20532-13505i
-13505-20532i
-6730-23635i
-6730-23635i
-13505-20532i
-20532-13505i
-23635-6730i
-23635-6730i
-20532-13505i
-13505-20532i
-6730-23635i
-6730-23635i
-13505-20532i
-20532-13505i
-23635-6730i
-23635-6730i
-20532-13505i
-13505-20532i
-6730-23635i
-6730-23635i
-13505-20532i
-20532-13505i
-23635-6730i
-23635-6730i
-20532-13505i
-13505-20532i
-6730-23635i
-6730-23635i
-13505-20532i
-20532-13505i
-23635-6730i
-23635-6730i
-20532-13505i
-13309-20660i
-4372-24183i
4372-24183i
13309-20660i
20532-13505i
23635-6730i
23635-6730i
20532-13505i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20532-13505i
23635-6730i
23635-6730i
20532-13505i
13505-20532i
6730-23635i
6730-23635i
13505-20532i
20660-13309i
24183-4372i
24183+4372i
20660+13309i
13505+20532i
6730+23635i
6730+23635i
13505+20532i
20532+13505i
23635+6730i
23635+6730i
20532+13505i
13309+20660i
4372+24183i
-4372+24183i
-13309+20660i
-20532+13505i
-23635+6730i
];
IQ=IQ(1:24*4).';    %'
figure(1)
plot(angle(IQ)*180/pi,'.-');
xlabel("Sample",'FontWeight','bold')
ylabel("Angle (°)",'FontWeight','bold')
yticks((-90:30:90));
ylim([-90,90]);

CA=get(gca,'colororder');

f=figure(2);
clf
plot3((1:96),real(IQ),imag(IQ),'.-')
f.CurrentAxes.YDir = 'Reverse';
set(gca,'DataAspectRatio',[1 600 600])
ylim([-30000,30000])
zlim([-30000,30000])
grid on
xlabel("Sample",'FontWeight','bold')
ylabel("Real",'FontWeight','bold')
zlabel("Imag",'FontWeight','bold')
yticks((-30000:10000:30000))

figure(3)
clf;
plot(IQ, '.-'); axis equal
xlim([-30000,30000])
ylim([-30000,30000])
xlabel("Real",'FontWeight','bold')
ylabel("Imag",'FontWeight','bold')

M = IQ;
M=M/sqrt(sum(M.*conj(M)));
fs = 9600*4;
P = [];
FD=[-1000:1:1000];
for fd=FD
    S = IQ.*exp(1i*2*pi*(0:numel(IQ)-1)*fd/fs);
    p = abs(sum(S.*conj(M)))/sqrt(sum(S.*conj(S)));
    P(end+1) = p^2;
end
figure(4)
clf;
plot(FD/1000,P);
xlabel("Frequency offset (kHz)",'FontWeight','bold')
ylabel("Detection score",'FontWeight','bold')
PN=[];
for ii=(1:100000)
    N=randn(1,numel(IQ))+randn(1,numel(IQ))*1i;
    p = abs(sum(N.*conj(M)))/sqrt(sum(N.*conj(N)));
    PN(end+1) = p^2;
end
the_pn_99 = prctile(PN, 99);
hold on;
xl=xlim;

% rectangle('Position', [xl(1), 0, xl(2)-xl(1), the_pn_99],'FaceColor',[CA(5,:),0.25], 'LineStyle','none');
% text(0.65,the_pn_99, "White noise 99 %ile", 'color', CA(5,:),'HorizontalAlignment', 'center','VerticalAlignment', 'bottom')
h=fill([xl(1), xl(2), xl(2), xl(1)], [0, 0, the_pn_99, the_pn_99],CA(5,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
ylim([0,1])
xticks([-1:0.2:1]);
legend("AIS preamble", "White noise, 99 %ile", 'Location', 'northeast');
P = [];
FD=[-1000:1:1000];
for fd=FD
    S = IQ.*exp(1i*2*pi*(0:numel(IQ)-1)*fd/fs);
    p = real(sum(S.*conj(M)))/sqrt(sum(S.*conj(S)));
    P(end+1)=p^2;
end
grid minor


figure(41)
clf;
plot(FD/1000,P);
xlabel("Frequency offset (kHz)",'FontWeight','bold')
ylabel("Detection score",'FontWeight','bold')
PN=[];
for ii=(1:100000)
    N=randn(1,numel(IQ))+randn(1,numel(IQ))*1i;
    p = real(sum(N.*conj(M)))/sqrt(sum(N.*conj(N)));
    PN(end+1) = p^2;
end
pn_99 = prctile(PN, 99);
hold on;
xl=xlim;
rectangle('Position', [xl(1), 0, xl(2)-xl(1), pn_99],'FaceColor',[CA(5,:),0.25], 'LineStyle','none');
text(0.65,pn_99, "White noise 99 %ile", 'color', CA(5,:),'HorizontalAlignment', 'center','VerticalAlignment', 'bottom')
ylim([0,1]);
xticks([-1:0.2:1]);


result_SNRs=[];
result_P=[];
result_P_std=[];
result_PC=[];
result_PC_pctl_a=[];
result_PC_pctl_b=[];
target_SNRs=(-6:1:19);
for target_snr=target_SNRs
    SNRs=[];
    P=[];
    PC=[];
    for trial=(1:10000)
        N=randn(1,numel(M))+randn(1,numel(M))*1i;
        N=N/sqrt(2*numel(M));
        % N is now unit energy
        nn = sqrt(1.0/(10^(target_snr/10)));
        N=N*nn;
        SNRs(end+1) = 1.0/sum(N.*conj(N));
        S=M+N;
        p = abs(sum(S.*conj(M)))/sqrt(sum(S.*conj(S)));
        pc = real(sum(S.*conj(M)))/sqrt(sum(S.*conj(S)));
        P(end+1)=p^2;
        PC(end+1)=pc^2;
    end
    result_SNRs(end+1) = median(SNRs);
    result_P(end+1) = mean(P);
    result_P_std(end+1) = std(P);
    result_PC(end+1) = mean(PC);
    result_PC_pctl_a(end+1) = prctile(PC, 1);
    result_PC_pctl_b(end+1) = prctile(PC, 99);
end
figure(5)
clf;
hold on
result_EsN0 = 10*log10(result_SNRs)+10*log10(4);
plot(result_EsN0, result_PC,'.-');
h=fill([result_EsN0, flip(result_EsN0)], [result_PC_pctl_a, flip(result_PC_pctl_b)],CA(1,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
xlabel("E_s/N_0 (dB)",'FontWeight','bold')
ylabel("Detection score",'FontWeight','bold')
xlim([min(result_EsN0),max(result_EsN0)]);
hold on;
xl=xlim;
h=fill([xl(1), xl(2), xl(2), xl(1)], [0, 0, the_pn_99, the_pn_99], CA(5,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
legend("Median", "[1,99] %ile", "White noise, 99 %ile", 'Location', 'east')
ylim([0,1]);
xlim([0,25]);
xticks(0:5:25);
grid minor

% Results from C++ implementation
% for ii in `seq 82 -1 56`; do test/unit_test_suite --gtest_filter=SECOND_ROUND.integrated -n=10000 --noise_power=$ii --signal_scaling=0.27 | grep ZZ; done
Z=[
82.5, 10000, -6.05794, -0.0373387, 1, 0.999394, 1, 3532.11, 3992, -7572, 11917
82, 10000, -5.55792, 0.462679, 1, 0.999394, 1, 4195.08, 4733, -7748, 12639
81, 10000, -4.55795, 1.46265, 1, 0.999394, 1, 5747.93, 6432, -8010, 14062
80, 10000, -3.55795, 2.46265, 1, 0.999394, 1, 7627.96, 8270, -7479, 15737
79, 10000, -2.55795, 3.46265, 0.9963, 0.99391, 0.997943, 9743.86, 10279, -5556, 17445
78, 10000, -1.55795, 4.46265, 0.9479, 0.940247, 0.954877, 12010.9, 12453, -1383, 19127
77, 10000, -0.557942, 5.46266, 0.7377, 0.72305, 0.751991, 14344.6, 14682, 3696, 20879
76, 10000, 0.442062, 6.46266, 0.3886, 0.37265, 0.404719, 16628.7, 16895, 7763, 22474
75, 10000, 1.44206, 7.46266, 0.1282, 0.117481, 0.13948, 18772.4, 19015, 11397, 23890
74, 10000, 2.44207, 8.46267, 0.0289, 0.0237384, 0.0347725, 20724.7, 20949, 14555, 24951
73, 10000, 3.44206, 9.46266, 0.0049, 0.00295921, 0.00758626, 22422.1, 22630, 17275, 25895
72, 10000, 4.44207, 10.4627, 0.0004, 4.85923e-05, 0.00148245, 23842.1, 24037, 19620, 26594
71, 10000, 5.44205, 11.4627, 0.0001, 7.63967e-07, 0.000886129, 24969.5, 25116, 21567, 27146
70, 10000, 6.44205, 12.4627, 0, 1.96345e-11, 0.000605585, 25834.2, 25952, 23070, 27606
69, 10000, 7.44206, 13.4627, 0, 1.96345e-11, 0.000605585, 26489.7, 26572, 24321, 27955
68, 10000, 8.44206, 14.4627, 0, 1.96345e-11, 0.000605585, 26979.8, 27046, 25278, 28188
67, 10000, 9.44206, 15.4627, 0, 1.96345e-11, 0.000605585, 27343.3, 27399, 25940, 28354
66, 10000, 10.4421, 16.4627, 0, 1.96345e-11, 0.000605585, 27615.1, 27658, 26444, 28496
65, 10000, 11.4421, 17.4627, 0, 1.96345e-11, 0.000605585, 27816, 27853, 26801, 28580
64, 10000, 12.4421, 18.4627, 0, 1.96345e-11, 0.000605585, 27960.9, 27991, 27096, 28635
63, 10000, 13.4421, 19.4627, 0, 1.96345e-11, 0.000605585, 28061.3, 28088, 27285, 28660
62, 10000, 14.4421, 20.4627, 0, 1.96345e-11, 0.000605585, 28126.7, 28153, 27435, 28668
61, 10000, 15.442, 21.4627, 0, 1.96345e-11, 0.000605585, 28162.7, 28183, 27533, 28660
60, 10000, 16.4421, 22.4627, 0, 1.96345e-11, 0.000605585, 28176, 28191, 27598, 28646
59, 10000, 17.442, 23.4626, 0, 1.96345e-11, 0.000605585, 28172.8, 28189, 27630, 28610
58, 10000, 18.4421, 24.4627, 0, 1.96345e-11, 0.000605585, 28157.3, 28171, 27655, 28583
57, 10000, 19.4421, 25.4627, 0, 1.96345e-11, 0.000605585, 28131.2, 28145, 27648, 28539
56, 10000, 20.4421, 26.4627, 0, 1.96345e-11, 0.000605585, 28099.8, 28111, 27627, 28496
];
% test/unit_test_suite --gtest_filter=SECOND_ROUND.integrated -n=10000 --noise_power=82.5 --signal_scaling=0.0 | grep ZZ
mine_pn_median = 0;
mine_pn_1 = -5910;
mine_pn_99 = 5910;
figure(6);
clf;
hold on
the_max=28750;
plot(Z(:,4), Z(:,9)/the_max,'.-','color',CA(2,:));
h=fill([Z(:,4)', flip(Z(:,4)')], [Z(:,10)', flip(Z(:,11)')]/the_max,CA(2,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
xlabel("E_s/N_0 (dB)",'FontWeight','bold')
ylabel("Detection score",'FontWeight','bold')
xlim([min(Z(:,1)),max(Z(:,1))]);
h=fill([Z(1,4), Z(end,4), Z(end,4), Z(1,4)], [mine_pn_1, mine_pn_1, mine_pn_99, mine_pn_99]/the_max, CA(5,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
legend("Median", "[1,99] %ile", "White noise, 99 %ile", 'Location', 'east')
xlim([0,25]);
xticks(0:5:25);
grid minor

figure(7)
clf;
hold on
result_EsN0 = 10*log10(result_SNRs)+10*log10(4);
plot(result_EsN0, result_PC,'.-');
h=fill([result_EsN0, flip(result_EsN0)], [result_PC_pctl_a, flip(result_PC_pctl_b)],CA(1,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
xlabel("E_s/N_0 (dB)",'FontWeight','bold')
ylabel("Detection score",'FontWeight','bold')
xlim([min(result_EsN0),max(result_EsN0)]);
hold on;
plot(Z(:,4), Z(:,9)/the_max,'.-');
h=fill([Z(:,4)', flip(Z(:,4)')], [Z(:,10)', flip(Z(:,11)')]/the_max,CA(2,:), 'LineStyle','none');
h.FaceAlpha = 0.25;
ylim([0,1]);
xlim([0,25]);
xticks(0:5:25);
grid minor
legend("Matched filter, median", "[1-99] %ile", "Proposed detector, median", "[1-99] %ile", 'Location', 'east');

