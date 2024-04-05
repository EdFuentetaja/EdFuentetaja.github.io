
M=[
188, 16855, -11406-4260i, 3544-12138i, 6653-4103i
189, 8637, -9019-8532i, -1481-12801i, 6542-4333i
190, -1020, -5186-11560i, -6385-11486i, 6424-4560i
191, -10615, -478-12895i, -10406-8399i, 6313-4790i
192, -18696, 4432-12344i, -12889-4026i, 6252-5039i
193, -24089, 8893-9954i, -13375+968i, 6326-5284i
194, -26005, 12252-5912i, -11759+5894i, 6552-5403i
195, -24074, 13825-696i, -8366+10023i, 6796-5325i
196, -18263, 13208+4841i, -3723+12653i, 6965-5133i
197, -9398, 10477+9749i, 1528+13338i, 7091-4910i
198, 1170, 6067+13242i, 6634+11965i, 7210-4683i
199, 11824, 663+14780i, 10833+8738i, 7336-4461i
200, 20921, -4874+14100i, 13522+4118i, 7505-4269i
201, 27001, -9401+11207i, 14567-1324i, 8003-4223i
202, 29206, -12958+6782i, 12966-6771i, 8018-4197i
203, 26989, -14572+1301i, 9384-11224i, 8014-4203i
];

P1=M(:,3);
P3=M(:,4);
DC=M(:,5);
row=16;
figure(1)
clf
figure(11);
clf;
row = 11;
TA=[];
Angles_a1_4=[];
Angles_a3_4=[];
for ii = (1:16)
    figure(1)
    subplot(4,4,ii)
    hold on;
    dc=DC(row);
    a1=P1(row)*conj(dc)/32768/32768;
    a3=P3(row)*conj(dc)/32768/32768;
    aa=(angle(a1)*4)*180/pi;
    while aa > 180
        aa = aa - 360;
    end
    while aa < -180
        aa = aa + 360;
    end
    Angles_a1_4(end+1)=aa;
    aa=(angle(a3)*4)*180/pi;
    while aa > 180
        aa = aa - 360;
    end
    while aa < -180
        aa = aa + 360;
    end
    Angles_a3_4(end+1)=aa;
    dc = dc*conj(dc)/32768/32768;
    s = -a1 + conj(a3);
    plot([0, real(a1)],[0, imag(a1)], '-');
    plot([0, real(a3)],[0, imag(a3)], '-');
    plot([0, real(dc)],[0, imag(dc)], '-');
    set(gca,'ColorOrderIndex',1);
    plot([real(a1)],[imag(a1)], '*');
    plot([real(a3)],[imag(a3)], '*');
    plot([real(dc)],[imag(dc)], '*');
    axis equal;
    tt=0.2;
    xlim([-tt,tt]);
    ylim([-tt,tt]);
    xticklabels([]);
    yticklabels([]);
    %xlabel("Real",'FontWeight','bold')
    %ylabel("Imag",'FontWeight','bold')
    text(0, -tt-tt/3, num2str(ii-1), 'HorizontalAlignment', 'center');
    tf = -a1+conj(a3);
    TA(end+1)=angle(tf);
    fprintf("%d, %f, %f, %f\n", ii-1, real(a3)-real(a1), real(tf), imag(tf));

    figure(11)
    subplot(4,4,ii)
    hold on;
    s = -a1 + conj(a3);
    set(gca,'ColorOrderIndex',4);
    plot([0, real(s)],[0, imag(s)], '-');
    set(gca,'ColorOrderIndex',4);
    plot([real(s)],[imag(s)], '*');
    axis equal;
    tt=0.3;
    xlim([-tt,tt]);
    ylim([-tt,tt]);
    xticklabels([]);
    yticklabels([]);
    %xlabel("Real",'FontWeight','bold')
    %ylabel("Imag",'FontWeight','bold')
    text(0, -tt-tt/3, num2str(ii-1), 'HorizontalAlignment', 'center');

    row = row+1;
    if row > 16
        row = 1;
    end
end
%legend("+2400 Hz", "-2400 Hz", "DC (0 Hz)", "location", "southoutside");

figure(111)
plot(TA*180/pi);

figure(112)
clf;
hold on;
plot((0:15), Angles_a1_4, '.-');
plot((0:15), Angles_a3_4, '.-');
ylim([-180,180]);

figure(2)
clf
row = 11;
for ii = (1:16)
    subplot(4,4,ii)
    hold on;
    dc=DC(row)/32768;
    p1=P1(row)/32768;
    p3=P3(row)/32768;
    plot([0, real(p1)],[0, imag(p1)], '-');
    plot([0, real(p3)],[0, imag(p3)], '-');
    plot([0, real(dc)],[0, imag(dc)], '-');
    set(gca,'ColorOrderIndex',1);
    plot([real(p1)],[imag(p1)], '*');
    plot([real(p3)],[imag(p3)], '*');
    plot([real(dc)],[imag(dc)], '*');
    axis equal;
    xlim([-1,1]);
    ylim([-1,1]);
    xticklabels([]);
    yticklabels([]);
    text(0, -1.3, num2str(ii-1), 'HorizontalAlignment', 'center');
    row = row+1;
    if row > 16
        row = 1;
    end
end
