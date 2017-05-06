A=[
5.158781
5.219823
5.1679282
5.1144068
5.130463
5.185865
5.18492
5.133062
5.138769
5.186433
5.174844
5.124082
5.126986
5.178415
5.179014
5.1327023
5.1410687
5.173449
5.162706
5.134584
5.150445
5.187163
5.176581
5.144209
5.152079
5.195209
5.141408
5.173271
5.188295
5.186241
5.162725
5.196213
5.167867
5.1948047
5.1777003
5.186345
5.207331
5.155438
5.183504
5.204761
5.165486
5.173249
5.195463
5.171182
5.1853848
5.1755452
5.196752
5.173616
5.210095
5.1733807764
5.1859872236
5.186305
5.188802
5.183485
5.191777
5.192503
5.204665
5.169132
5.210117
5.221475
5.218929
5.198919
5.171295
5.1972
5.203936
5.226637
5.194214
5.208015
5.21154
5.173961
5.226306
5.175968
5.203549
5.179769
5.210139
5.19747
5.210861
5.186896
5.190182
5.20777
5.212438
5.222834
5.213125
5.183563
5.20263
5.194015
5.204299
5.192044
5.197571
5.187001
5.208219
5.19091
5.201295
5.217732
5.216644
5.211636
5.194598
5.197537
5.184603
5.223854
5.222612
5.194919
5.231052
5.20438
5.1848482
5.2211348
5.210865
5.216877
5.234064
5.203803
5.23061
5.235188
5.260197
5.2368055
5.2197695
5.250754
5.245825
5.22181955
5.23994345
5.235583
5.226533
5.212913
5.212757
5.238865
5.224935
5.223991
5.2221082
5.2292818
5.24534
5.21095
5.242205
5.232171
5.231103
5.224653
5.230237
5.219482
5.229121
5.236577
5.225009
5.2201828
5.2409832
5.207675
5.210441
5.216962
5.246398
5.19294
5.22848
5.220365
5.2235555
5.2090335
5.236055
5.201964
5.226214
5.239437
5.210329
5.238664
5.201726
5.2392511
5.1963639
5.24128
5.195686
5.236075
5.230558
5.226938
5.205473
5.232857
5.214221
5.187399
5.217193
5.22314
5.207583
5.2377481
5.2040339
5.194997
5.223933
5.215104
5.226459
5.214747
5.209193
5.199613
5.25429246
5.19113454
5.245708
5.182814
5.238551
5.1958968
5.2365322
5.200433
5.247236
5.194331
5.236959
5.197111
5.245792
5.193522
5.2333586
5.1948234
5.243723
5.19492
5.229335
5.206209
5.234579
5.200475
5.238826
5.190212
5.230385
5.206934
5.232555
5.214331
5.1938377
5.1661643
5.205905
5.191725
5.231117
5.2422629
5.2171741
5.182302
5.186755
5.245186
5.183321
5.222821
5.230622
5.198677
5.216914
5.215926
5.205447
5.208087
];
A=A'

figure(1)
clf
plot(A,'-')
hold on
grid on
xlim([1 numel(A)])
s=20;
MAA=filter(ones(s,1)/s,1,A)
plot((s:numel(A)),MAA(s:numel(A)),'-')
sps=50000/9600;
plot([0 numel(A)],[sps sps]);
legend('estimated T','moving average','T')