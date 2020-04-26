as=0.1
phi=[0:as:360-as];

c=299704644.54;
f0=5000000.0;
lambda0=c/f0;
R=7.5*2;
rO=1.0;
rEW=rO*2*sin(2*pi*R*cos(phi*pi/180)/lambda0);
rNS=rO*2*sin(2*pi*R*sin(phi*pi/180)/lambda0);

figure(1)
clf
hold on;
colors = get(gca,'colororder');
plot(phi,rNS, 'color', colors(1,:));
plot(phi,rEW, 'color', colors(2,:));
plot(phi,max(abs(rNS))*sin(phi*pi/180), "--", 'color', colors(1,:));
plot(phi,max(abs(rNS))*cos(phi*pi/180), "--", 'color', colors(2,:));
xlim([0 360]);
set(gca, 'xtick', 0:90:360);
grid on;
legend("r_N_S", "r_E_W", "sine", "cosine               ", 'location', 'northeastoutside', y.intersp=2);
legend('boxoff')
xlabel('\lambda=60, R=15');
set(gca, 'fontsize', 20)
 
return

min_distances=zeros(1,numel(phi));
for ii=(1:numel(phi))
  min_dd = inf;
  x0=rEW(ii);
  y0=rNS(ii);
  for jj=(1:numel(phi))
    if (ii!=jj)
      x1=rEW(jj);
      y1=rNS(jj);
      dd = sqrt((x0-x1)^2+(y0-y1)^2);
      if (dd < min_dd)
        min_dd = dd;
      end;
    end
  end
  min_distances(ii)=min_dd;
end
figure(2);
clf;
plot(phi, min_distances);
xlim([0 360]);
set(gca, 'xtick', 0:90:360);
grid on;
  