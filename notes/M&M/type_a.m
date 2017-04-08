%SINC
%bt=0.4;
%span = 6;    % Filter span in symbols
%SPS = 5;
%t=linspace(-span/2,span/2,span*SPS+1);
%H=sinc(t);
%H=H(4:28);

% GAUSS
bt=0.4;
span = 5;    % Filter span in symbols
SPS = 5000;
t = linspace(-span/2, span/2, span*SPS);
alpha = sqrt(log(2)/2)/(bt);
H = (sqrt(pi)/alpha)*exp(-(t*pi/alpha).^2);


%H = H./sum(H);

figure(1);
plot([0:numel(H)-1],H,'o-');

TAU=linspace(-SPS/2, SPS/2, SPS+1);
F_TAU = H(numel(H)/2 + TAU + SPS)-H(numel(H)/2 + TAU - SPS);

figure(11);
clf;
plot(linspace(-0.5,0.5,numel(F_TAU)), F_TAU);
grid on;

hold on;
plot([-0.5 0.5],[0 0],'black')
plot([0 0],[-0.4 0.4],'black')