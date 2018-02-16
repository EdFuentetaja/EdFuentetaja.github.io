CC = [0.810349
4.88926
0.209177
1.02978
0.459366
0.432163
4.38728
1.09111
4.52923
4.72828
4.71446
4.73302
0.305069
0.517227
0.724884
0.235687
1.27307
0.602448
0.611176
4.99451
0.843811
4.74619
0.485886
4.42918
0.752243
4.57082
0.584641
0.190338
0.100494
4.62949
0.295654
0.383972
4.6731
4.60416
0.987488
0.766632
1.15234
4.80643
4.97665
4.65262
1.01572
0.197144
4.91098
4.73489
0.661469
4.75125
0.568909
0.165405
4.39255
4.44058
0.266296
4.83484
0.783112
0.227234
0.77002
4.80139
1.00681
0.245697
0.336792
0.263306
0.516144
0.521423
1.37982
0.346863
1.24701
0.0339966
4.91724];

sps = 5.0;

figure(1);
clf;
plot(CC, zeros(numel(CC),1), 'xb');
set(gca,'YTick',[0]);
grid on;

figure(2);
AA = CC*2*pi/sps;
polar_edf(AA, ones(numel(AA),1), 'xb');
grid off;