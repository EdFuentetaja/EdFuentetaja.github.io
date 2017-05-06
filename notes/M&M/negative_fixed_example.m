fileID=fopen('D:/ed/AIS/samples/segment_ot_50000__67.raw');
A=fread(fileID,'int16');
T=[
3.5
8.7926
13.991
19.2218
24.4453
29.6436
34.8894
40.1174
45.2901
50.4759
55.7135
60.9664
66.2011
71.4029
76.5814
81.792
86.9928
92.1854
97.3963
102.597
107.797
112.971
118.112
123.283
128.51
133.714
138.896
144.054
149.285
154.451
159.588
164.741
169.936
175.152
180.351
185.503
190.662
195.838
201.035
206.231
211.406
216.619
221.811
226.972
232.161
237.373
242.541
247.723
252.925
258.154
263.284
268.499
273.664
278.779
283.915
289.099
294.318
299.544
304.725
309.936
315.155
320.31
325.491
330.673
335.819
340.964
346.137
351.31
356.519
361.708
366.955
372.133
377.415
382.486
387.642
392.855
398.077
403.309
408.52
413.717
418.984
424.098
429.313
434.502
439.61
444.78
449.951
455.147
460.341
465.566
470.741
475.965
481.17
486.387
491.582
496.773
502.02
507.222
512.396
517.629
522.85
528.087
533.328
538.555
543.862
548.981
554.211
559.4
564.63
569.871
575.111
580.339
585.558
590.763
595.953
601.207
606.399
611.559
616.769
622.006
627.21
632.472
637.628
642.891
648.07
653.255
];

%Exact
E = [
3.3108930587768555
8.51922607421875
13.727560043334961
18.935894012451172
24.144227981567383
29.352561950683594
34.560894012451172
39.76922607421875
44.977558135986328
50.185890197753906
55.394222259521484
60.602554321289063
65.810890197753906
71.01922607421875
76.227561950683594
81.435897827148438
86.644233703613281
91.852569580078125
97.060905456542969
102.26924133300781
107.47757720947266
112.6859130859375
117.89424896240234
123.10258483886719
128.3109130859375
133.51924133300781
138.72756958007812
143.93589782714844
149.14422607421875
154.35255432128906
159.56088256835937
164.76921081542969
169.9775390625
175.18586730957031
180.39419555664062
185.60252380371094
190.81085205078125
196.01918029785156
201.22750854492187
206.43583679199219
211.6441650390625
216.85249328613281
222.06082153320312
227.26914978027344
232.47747802734375
237.68580627441406
242.89413452148437
248.10246276855469
253.310791015625
258.51913452148437
263.72747802734375
268.93582153320312
274.1441650390625
279.35250854492188
284.56085205078125
289.76919555664062
294.9775390625
300.18588256835937
305.39422607421875
310.60256958007813
315.8109130859375
321.01925659179687
326.22760009765625
331.43594360351562
336.644287109375
341.85263061523437
347.06097412109375
352.26931762695312
357.4776611328125
362.68600463867187
367.89434814453125
373.10269165039062
378.31103515625
383.51937866210937
388.72772216796875
393.93606567382812
399.1444091796875
404.35275268554687
409.56109619140625
414.76943969726562
419.977783203125
425.18612670898437
430.39447021484375
435.60281372070312
440.8111572265625
446.01950073242187
451.22784423828125
456.43618774414062
461.64453125
466.85287475585937
472.06121826171875
477.26956176757812
482.4779052734375
487.68624877929687
492.89459228515625
498.10293579101562
503.311279296875
508.51962280273437
513.72796630859375
518.936279296875
524.14459228515625
529.3529052734375
534.56121826171875
539.76953125
544.97784423828125
550.1861572265625
555.39447021484375
560.602783203125
565.81109619140625
571.0194091796875
576.22772216796875
581.43603515625
586.64434814453125
591.8526611328125
597.06097412109375
602.269287109375
607.47760009765625
612.6859130859375
617.89422607421875
623.1025390625
628.31085205078125
633.5191650390625
638.72747802734375
643.935791015625
649.14410400390625
654.3524169921875
];
figure(5);
clf
plot([0:numel(A)-1], A, '.-');
xlim([0 numel(A)-1])
hold on;
plot([0 numel(A)], [0 0], 'k-');
vline(T, [0.6,0,0]);
vline(E, [0,0.6,0]);

figure(6)
plot(E-T)
