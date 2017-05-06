fileID=fopen('D:/ed/AIS/samples/segment_ot_50000__111.raw');
A=fread(fileID,'int16');
T=[
3.5
8.78759
13.9443
19.0955
24.2671
29.4614
34.6735
39.8939
45.1111
50.3002
55.4625
60.6371
65.8571
71.0529
76.2321
81.4135
86.6194
91.8297
97.0137
102.215
107.419
112.594
117.77
122.912
128.027
133.252
138.413
143.625
148.773
153.979
159.149
164.295
169.478
174.71
179.914
185.057
190.224
195.417
200.602
205.801
210.971
216.163
221.351
226.534
231.713
236.884
242.069
247.273
252.437
257.626
262.805
268.003
273.211
278.369
283.587
288.8
293.975
299.177
304.35
309.546
314.787
319.921
325.097
330.322
335.515
340.787
346.048
351.252
356.526
361.689
366.913
372.182
377.391
382.589
387.813
393.069
398.205
403.43
408.631
413.826
419.079
424.255
429.444
434.677
439.915
445.136
450.346
455.6
460.769
465.979
471.242
476.501
481.719
486.93
492.2
497.353
502.564
507.773
513.011
518.199
523.429
528.682
533.874
539.083
544.275
549.494
554.713
559.92
565.125
570.321
575.561
580.767
585.991
591.163
596.36
601.573
606.81
612.033
617.249
622.455
627.681
632.9
638.133
643.327
648.591
653.744
];

%Exact
E = [
3.236931324005127
8.4452648162841797
13.653598785400391
18.861932754516602
24.070266723632812
29.278600692749023
34.486934661865234
39.695266723632812
44.903598785400391
50.111930847167969
55.320262908935547
60.528594970703125
65.736930847167969
70.945266723632812
76.153602600097656
81.3619384765625
86.570274353027344
91.778610229492188
96.986946105957031
102.19528198242187
107.40361785888672
112.61195373535156
117.82028961181641
123.02862548828125
128.23695373535156
133.44528198242187
138.65361022949219
143.8619384765625
149.07026672363281
154.27859497070312
159.48692321777344
164.69525146484375
169.90357971191406
175.11190795898437
180.32023620605469
185.528564453125
190.73689270019531
195.94522094726562
201.15354919433594
206.36187744140625
211.57020568847656
216.77853393554687
221.98686218261719
227.1951904296875
232.40351867675781
237.61184692382812
242.82017517089844
248.02850341796875
253.23683166503906
258.44515991210937
263.65350341796875
268.86184692382812
274.0701904296875
279.27853393554687
284.48687744140625
289.69522094726562
294.903564453125
300.11190795898437
305.32025146484375
310.52859497070312
315.7369384765625
320.94528198242187
326.15362548828125
331.36196899414062
336.5703125
341.77865600585937
346.98699951171875
352.19534301757813
357.4036865234375
362.61203002929688
367.82037353515625
373.02871704101562
378.237060546875
383.44540405273438
388.65374755859375
393.86209106445312
399.0704345703125
404.27877807617187
409.48712158203125
414.69546508789063
419.90380859375
425.11215209960937
430.32049560546875
435.52883911132812
440.7371826171875
445.94552612304688
451.15386962890625
456.36221313476562
461.570556640625
466.77890014648437
471.98724365234375
477.19558715820312
482.4039306640625
487.61227416992187
492.82061767578125
498.02896118164062
503.2373046875
508.44564819335937
513.65399169921875
518.8623046875
524.07061767578125
529.2789306640625
534.48724365234375
539.695556640625
544.90386962890625
550.1121826171875
555.32049560546875
560.52880859375
565.73712158203125
570.9454345703125
576.15374755859375
581.362060546875
586.57037353515625
591.7786865234375
596.98699951171875
602.1953125
607.40362548828125
612.6119384765625
617.82025146484375
623.028564453125
628.23687744140625
633.4451904296875
638.65350341796875
643.86181640625
649.07012939453125
654.2784423828125
659.48675537109375
];

figure(3);
clf
plot([0:numel(A)-1], A, '.-');
xlim([0 numel(A)-1])
set(gca,'YTickLabel',[]);
hold on;
plot([0 numel(A)], [0 0], 'k-');
vline(T, 'b');
vline(E, 'g');

figure(4)
plot(E-T)
xlim([0 numel(E)])