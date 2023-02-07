n=90;
k=(1:89);
w=k.*(n-k);
figure(1)
plot(w,'.'); grid on
xlim([min(k), max(k)])
set(gca, 'xtick', [1,22,45,67,89]);
% xticklabels ("manual")
set(gca, 'xticklabel', ({'1', '', '(N+1)/2', '', 'N-1'}))
%set(gca, 'xticklabel', ({1, 2, 3, 4, 5}))

set(gca, 'ytick', (0:500:2500));
set(gca, 'yticklabel', ({'', '', '', '', '', ''}));

m=9;

figure(2)
fn=0.02;
R=exp(1i*2*pi*NN*fn);
plot(R,'*');
grid on
xlim([-1.2, 1.2]);
ylim([-1.2, 1.2]);
axis equal

function foo(fid, m, fn)
  figure(fid)
  NN=(1:m);
  R=exp(1i*2*pi*NN*fn)*exp(-1i*2*pi*((m+1)/2)*fn);
  clf;
  hold on
  p1=exp(1i*2*pi*((m-1)/2)*fn);
  cc = get(gca,'ColorOrder')(1,:);
  plot([0,real(p1)],[0,imag(p1)],':', 'color', cc);
  plot([0,real(p1)],[0,-imag(p1)],':', 'color', cc);
  plot(R,'*', 'color', cc);
  grid on
  xlim([-1.2, 1.2]);
  ylim([-0.6, 0.6]);
  yticks((-0.5:0.5:0.5));
  axis equal
  text(-0.95, 0.4, ["M = ", num2str(m)], 'fontsize', 20)
end

foo(3, 9, fn)
foo(4, 8, fn)