fileID=fopen('D:/ed/AIS/samples/segment_ot_50000__206.raw');
A=fread(fileID,'int16');
T=[
3.5
8.64585
13.8438
19.0083
24.2001
29.4303
34.6294
39.8035
45.0067
50.2251
55.4208
60.5999
65.8017
71.0233
76.2153
81.3946
86.6119
91.8355
97.0186
102.191
107.403
112.635
117.837
123.023
128.236
133.446
138.641
143.844
149.051
154.226
159.438
164.635
169.844
175.071
180.274
185.474
190.695
195.896
201.103
206.298
211.527
216.708
221.919
227.144
232.341
237.564
242.783
247.985
253.177
258.402
263.607
268.803
274.008
279.245
284.45
289.648
294.852
300.049
305.262
310.473
315.715
320.894
326.099
331.318
336.551
341.762
346.965
352.191
357.408
362.64
367.852
373.071
378.271
383.492
388.694
393.909
399.115
404.335
409.542
414.761
419.965
425.189
430.391
435.614
440.814
446.037
451.243
456.466
461.672
466.89
472.096
477.319
482.516
487.737
492.943
498.168
503.38
508.6
513.8
519.01
524.216
529.441
534.647
539.859
545.078
550.292
555.52
560.708
565.935
571.138
576.359
581.557
586.77
591.99
597.199
602.43
607.627
612.838
618.038
623.241
628.455
633.672
638.878
644.086
649.285
654.496
659.711
664.909
670.153
675.327
680.548
685.74
690.975
696.174
701.389
706.574
711.779
716.985
722.193
727.394
732.604
737.812
743.018
748.216
753.416
758.634
763.833
769.043
774.256
779.444
784.649
789.852
795.064
800.266
805.477
810.675
815.902
821.097
826.318
831.543
836.766
841.968
847.176
852.383
857.598
862.801
868.016
873.22
878.438
883.632
888.845
894.054
899.299
904.463
909.647
914.861
920.095
925.295
930.518
935.708
940.916
946.145
951.314
956.51
961.71
966.922
972.125
977.348
982.542
987.765
992.936
998.137
1003.38
1008.57
1013.77
1018.98
1024.18
1029.4
1034.6
1039.81
1044.99
1050.2
1055.43
1060.63
1065.85
1071.08
1076.3
1081.52
1086.72
1091.94
1097.14
1102.37
1107.55
1112.78
1117.96
1123.16
1128.4
1133.59
1138.81
1144.03
1149.24
1154.46
1159.66
1164.89
1170.08
1175.31
1180.56
1185.76
1190.97
1196.19
1201.4
1206.63
1211.83
1217.06
1222.27
1227.49
1232.69
1237.92
1243.1
1248.32
1253.56
1258.78
1263.98
1269.2
1274.44
1279.66
1284.88
1290.09
1295.29
1300.49
1305.71
1310.93
1316.12
1321.34
1326.56
1331.77
1337
1342.21
1347.42
1352.64
1357.86
1363.07
1368.27
1373.47
1378.68
1383.9
1389.12
1394.32
1399.54
1404.75
1409.96
1415.16
1420.36
1425.58
1430.77
1435.98
1441.17
1446.4
1451.6
1456.82
1462.02
1467.21
1472.4
1477.59
1482.78
1488
1493.2
1498.41
1503.6
1508.81
1514
1519.2
1524.42
1529.62
1534.83
1540.02
1545.23
1550.41
1555.62
1560.81
1566.04
1571.23
1576.41
1581.61
1586.82
1592.01
1597.22
1602.42
1607.63
1612.82
1618.03
1623.21
1628.41
1633.64
1638.83
1644.03
1649.21
1654.43
1659.61
1664.82
1670.02
1675.23
1680.43
1685.64
1690.83
1696.03
1701.25
1706.45
1711.66
1716.86
1722.04
1727.25
1732.47
1737.65
1742.87
1748.06
1753.27
1758.45
1763.66
1768.85
1774.07
1779.3
1784.5
1789.71
1794.91
1800.15
1805.34
1810.57
1815.79
1820.99
1826.19
1831.42
1836.62
1841.85
1847.09
1852.3
1857.5
1862.72
1867.93
1873.16
1878.36
1883.59
1888.81
1894.06
1899.26
1904.48
1909.69
1914.92
1920.14
1925.36
1930.6
1935.81
1941.02
1946.26
1951.46
1956.67
1961.91
1967.1
1972.32
1977.56
1982.76
1987.98
1993.22
1998.43
2003.65
2008.89
2014.09
2019.32
2024.52
2029.74
2034.96
2040.16
2045.39
2050.61
2055.83
2061.03
2066.24
2071.47
2076.68
2081.9
2087.11
2092.31
2097.51
2102.73
2107.94
2113.15
2118.37
2123.57
2128.79
2133.99
2139.22
2144.38
2149.59
2154.8
2160.01
2165.21
2170.44
2175.62
2180.83
2186.02
2191.22
2196.43
2201.63
2206.82
2212.01
2217.22
2222.42
2227.61
2232.81
2238.01
2243.2
2248.4
2253.59
2258.77
2263.97
2269.18
2274.37
2279.57
2284.81
2289.97
2295.16
2300.36
2305.56
2310.76
2315.97
2321.15
2326.38
2331.55
2336.76
2341.99
2347.18
2352.4
2357.57
2362.79
2367.98
2373.2
2378.38
2383.59
2388.83
2394.02
2399.21
2404.41
2409.63
2414.87
2420.04
2425.22
2430.45
2435.63
2440.85
2446.06
2451.25
2456.46
2461.7
2466.88
2472.1
2477.34
2482.56
2487.77
2492.98
2498.18
2503.4
];

%Exact
E = [
4.0074396133422852
9.2157726287841797
14.424106597900391
19.632440567016602
24.840774536132813
30.049108505249023
35.257442474365234
40.465774536132813
45.674106597900391
50.882438659667969
56.090770721435547
61.299102783203125
66.507438659667969
71.715774536132813
76.924110412597656
82.1324462890625
87.340782165527344
92.549118041992188
97.757453918457031
102.96578979492187
108.17412567138672
113.38246154785156
118.59079742431641
123.79913330078125
129.00746154785156
134.21578979492187
139.42411804199219
144.6324462890625
149.84077453613281
155.04910278320312
160.25743103027344
165.46575927734375
170.67408752441406
175.88241577148437
181.09074401855469
186.299072265625
191.50740051269531
196.71572875976562
201.92405700683594
207.13238525390625
212.34071350097656
217.54904174804687
222.75736999511719
227.9656982421875
233.17402648925781
238.38235473632812
243.59068298339844
248.79901123046875
254.00733947753906
259.21566772460937
264.42401123046875
269.63235473632812
274.8406982421875
280.04904174804687
285.25738525390625
290.46572875976562
295.674072265625
300.88241577148437
306.09075927734375
311.29910278320312
316.5074462890625
321.71578979492187
326.92413330078125
332.13247680664062
337.3408203125
342.54916381835937
347.75750732421875
352.96585083007812
358.1741943359375
363.38253784179687
368.59088134765625
373.79922485351563
379.007568359375
384.21591186523437
389.42425537109375
394.63259887695312
399.8409423828125
405.04928588867188
410.25762939453125
415.46597290039062
420.67431640625
425.88265991210937
431.09100341796875
436.29934692382812
441.5076904296875
446.71603393554687
451.92437744140625
457.13272094726562
462.341064453125
467.54940795898437
472.75775146484375
477.96609497070312
483.1744384765625
488.38278198242187
493.59112548828125
498.79946899414062
504.0078125
509.21615600585937
514.42449951171875
519.6328125
524.84112548828125
530.0494384765625
535.25775146484375
540.466064453125
545.67437744140625
550.8826904296875
556.09100341796875
561.29931640625
566.50762939453125
571.7159423828125
576.92425537109375
582.132568359375
587.34088134765625
592.5491943359375
597.75750732421875
602.9658203125
608.17413330078125
613.3824462890625
618.59075927734375
623.799072265625
629.00738525390625
634.2156982421875
639.42401123046875
644.63232421875
649.84063720703125
655.0489501953125
660.25726318359375
665.465576171875
670.67388916015625
675.8822021484375
681.09051513671875
686.298828125
691.50714111328125
696.7154541015625
701.92376708984375
707.132080078125
712.34039306640625
717.5487060546875
722.75701904296875
727.96533203125
733.17364501953125
738.3819580078125
743.59027099609375
748.798583984375
754.00689697265625
759.2152099609375
764.42352294921875
769.6318359375
774.84014892578125
780.0484619140625
785.25677490234375
790.465087890625
795.67340087890625
800.8817138671875
806.09002685546875
811.29833984375
816.50665283203125
821.7149658203125
826.92327880859375
832.131591796875
837.33990478515625
842.5482177734375
847.75653076171875
852.96484375
858.17315673828125
863.3814697265625
868.58978271484375
873.798095703125
879.00640869140625
884.2147216796875
889.42303466796875
894.63134765625
899.83966064453125
905.0479736328125
910.25628662109375
915.464599609375
920.67291259765625
925.8812255859375
931.08953857421875
936.2978515625
941.50616455078125
946.7144775390625
951.92279052734375
957.131103515625
962.33941650390625
967.5477294921875
972.75604248046875
977.96435546875
983.17266845703125
988.3809814453125
993.58929443359375
998.797607421875
1004.0059204101562
1009.2142333984375
1014.4225463867187
1019.630859375
1024.8392333984375
1030.047607421875
1035.2559814453125
1040.46435546875
1045.6727294921875
1050.881103515625
1056.0894775390625
1061.2978515625
1066.5062255859375
1071.714599609375
1076.9229736328125
1082.13134765625
1087.3397216796875
1092.548095703125
1097.7564697265625
1102.96484375
1108.1732177734375
1113.381591796875
1118.5899658203125
1123.79833984375
1129.0067138671875
1134.215087890625
1139.4234619140625
1144.6318359375
1149.8402099609375
1155.048583984375
1160.2569580078125
1165.46533203125
1170.6737060546875
1175.882080078125
1181.0904541015625
1186.298828125
1191.5072021484375
1196.715576171875
1201.9239501953125
1207.13232421875
1212.3406982421875
1217.549072265625
1222.7574462890625
1227.9658203125
1233.1741943359375
1238.382568359375
1243.5909423828125
1248.79931640625
1254.0076904296875
1259.216064453125
1264.4244384765625
1269.6328125
1274.8411865234375
1280.049560546875
1285.2579345703125
1290.46630859375
1295.6746826171875
1300.883056640625
1306.0914306640625
1311.2998046875
1316.5081787109375
1321.716552734375
1326.9249267578125
1332.13330078125
1337.3416748046875
1342.550048828125
1347.7584228515625
1352.966796875
1358.1751708984375
1363.383544921875
1368.5919189453125
1373.80029296875
1379.0086669921875
1384.217041015625
1389.4254150390625
1394.6337890625
1399.8421630859375
1405.050537109375
1410.2589111328125
1415.46728515625
1420.6756591796875
1425.884033203125
1431.0924072265625
1436.30078125
1441.5091552734375
1446.717529296875
1451.9259033203125
1457.13427734375
1462.3426513671875
1467.551025390625
1472.7593994140625
1477.9677734375
1483.1761474609375
1488.384521484375
1493.5928955078125
1498.80126953125
1504.0096435546875
1509.218017578125
1514.4263916015625
1519.634765625
1524.8431396484375
1530.051513671875
1535.2598876953125
1540.46826171875
1545.6766357421875
1550.885009765625
1556.0933837890625
1561.3017578125
1566.5101318359375
1571.718505859375
1576.9268798828125
1582.13525390625
1587.3436279296875
1592.552001953125
1597.7603759765625
1602.96875
1608.1771240234375
1613.385498046875
1618.5938720703125
1623.80224609375
1629.0106201171875
1634.218994140625
1639.4273681640625
1644.6357421875
1649.8441162109375
1655.052490234375
1660.2608642578125
1665.46923828125
1670.6776123046875
1675.885986328125
1681.0943603515625
1686.302734375
1691.5111083984375
1696.719482421875
1701.9278564453125
1707.13623046875
1712.3446044921875
1717.552978515625
1722.7613525390625
1727.9697265625
1733.1781005859375
1738.386474609375
1743.5948486328125
1748.80322265625
1754.0115966796875
1759.219970703125
1764.4283447265625
1769.63671875
1774.8450927734375
1780.053466796875
1785.2618408203125
1790.47021484375
1795.6785888671875
1800.886962890625
1806.0953369140625
1811.3037109375
1816.5120849609375
1821.720458984375
1826.9288330078125
1832.13720703125
1837.3455810546875
1842.553955078125
1847.7623291015625
1852.970703125
1858.1790771484375
1863.387451171875
1868.5958251953125
1873.80419921875
1879.0125732421875
1884.220947265625
1889.4293212890625
1894.6376953125
1899.8460693359375
1905.054443359375
1910.2628173828125
1915.47119140625
1920.6795654296875
1925.887939453125
1931.0963134765625
1936.3046875
1941.5130615234375
1946.721435546875
1951.9298095703125
1957.13818359375
1962.3465576171875
1967.554931640625
1972.7633056640625
1977.9716796875
1983.1800537109375
1988.388427734375
1993.5968017578125
1998.80517578125
2004.0135498046875
2009.221923828125
2014.4302978515625
2019.638671875
2024.8470458984375
2030.055419921875
2035.2637939453125
2040.47216796875
2045.6805419921875
2050.888916015625
2056.09716796875
2061.305419921875
2066.513671875
2071.721923828125
2076.93017578125
2082.138427734375
2087.3466796875
2092.554931640625
2097.76318359375
2102.971435546875
2108.1796875
2113.387939453125
2118.59619140625
2123.804443359375
2129.0126953125
2134.220947265625
2139.42919921875
2144.637451171875
2149.845703125
2155.053955078125
2160.26220703125
2165.470458984375
2170.6787109375
2175.886962890625
2181.09521484375
2186.303466796875
2191.51171875
2196.719970703125
2201.92822265625
2207.136474609375
2212.3447265625
2217.552978515625
2222.76123046875
2227.969482421875
2233.177734375
2238.385986328125
2243.59423828125
2248.802490234375
2254.0107421875
2259.218994140625
2264.42724609375
2269.635498046875
2274.84375
2280.052001953125
2285.26025390625
2290.468505859375
2295.6767578125
2300.885009765625
2306.09326171875
2311.301513671875
2316.509765625
2321.718017578125
2326.92626953125
2332.134521484375
2337.3427734375
2342.551025390625
2347.75927734375
2352.967529296875
2358.17578125
2363.384033203125
2368.59228515625
2373.800537109375
2379.0087890625
2384.217041015625
2389.42529296875
2394.633544921875
2399.841796875
2405.050048828125
2410.25830078125
2415.466552734375
2420.6748046875
2425.883056640625
2431.09130859375
2436.299560546875
2441.5078125
2446.716064453125
2451.92431640625
2457.132568359375
2462.3408203125
2467.549072265625
2472.75732421875
2477.965576171875
2483.173828125
2488.382080078125
2493.59033203125
2498.798583984375
2504.0068359375
];

figure(1);
clf
plot([0:numel(A)-1], A, '.-');
xlim([0 numel(A)-1])
set(gca,'YTickLabel',[]);
hold on;
plot([0 numel(A)], [0 0], 'k-');
vline(T, 'b');
vline(E, 'g');

figure(2)
plot(E-T)
xlim([0 numel(E)])