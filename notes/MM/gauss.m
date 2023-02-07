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
SPS = 10;
t = linspace(-span/2, span/2, span*SPS);
alpha = sqrt(log(2)/2)/(bt);
H = (sqrt(pi)/alpha)*exp(-(t*pi/alpha).^2);


H = H./sum(H);

figure(1);
plot([1:numel(H)],H,'o-');
set(gca,'XTick',[0:numel(t)])

S0=[H(SPS*2+1:numel(H)) zeros(1,SPS*2)];
S1=[H(SPS+1:numel(H)) zeros(1,SPS)];
S2=[zeros(1,SPS) H(1:numel(H)-SPS)];
S3=[zeros(1,SPS*2) H(1:numel(H)-SPS*2)];

B1=repmat(+1, 1,SPS);
B0=repmat(-1, 1,SPS);

% Sorry, this is not very elegant

% Symbols
A( 1,:)=[B1 B1 B1 B1 B1];
A( 2,:)=[B0 B1 B1 B1 B1];
A( 3,:)=[B1 B0 B1 B1 B1];
A( 4,:)=[B0 B0 B1 B1 B1];
A( 5,:)=[B1 B1 B0 B1 B1];
A( 6,:)=[B0 B1 B0 B1 B1];
A( 7,:)=[B1 B0 B0 B1 B1];
A( 8,:)=[B0 B0 B0 B1 B1];
A( 9,:)=[B1 B1 B1 B0 B1];
A(10,:)=[B0 B1 B1 B0 B1];
A(11,:)=[B1 B0 B1 B0 B1];
A(12,:)=[B0 B0 B1 B0 B1];
A(13,:)=[B1 B1 B0 B0 B1];
A(14,:)=[B0 B1 B0 B0 B1];
A(15,:)=[B1 B0 B0 B0 B1];
A(16,:)=[B0 B0 B0 B0 B1];
A(17,:)=[B1 B1 B1 B1 B0];
A(18,:)=[B0 B1 B1 B1 B0];
A(19,:)=[B1 B0 B1 B1 B0];
A(20,:)=[B0 B0 B1 B1 B0];
A(21,:)=[B1 B1 B0 B1 B0];
A(22,:)=[B0 B1 B0 B1 B0];
A(23,:)=[B1 B0 B0 B1 B0];
A(24,:)=[B0 B0 B0 B1 B0];
A(25,:)=[B1 B1 B1 B0 B0];
A(26,:)=[B0 B1 B1 B0 B0];
A(27,:)=[B1 B0 B1 B0 B0];
A(28,:)=[B0 B0 B1 B0 B0];
A(29,:)=[B1 B1 B0 B0 B0];
A(30,:)=[B0 B1 B0 B0 B0];
A(31,:)=[B1 B0 B0 B0 B0];
A(32,:)=[B0 B0 B0 B0 B0];

% Signals
X( 1,:)=+S0+S1+H+S2+S3;
X( 2,:)=-S0+S1+H+S2+S3;
X( 3,:)=+S0-S1+H+S2+S3;
X( 4,:)=-S0-S1+H+S2+S3;
X( 5,:)=+S0+S1-H+S2+S3;
X( 6,:)=-S0+S1-H+S2+S3;
X( 7,:)=+S0-S1-H+S2+S3;
X( 8,:)=-S0-S1-H+S2+S3;
X( 9,:)=+S0+S1+H-S2+S3;
X(10,:)=-S0+S1+H-S2+S3;
X(11,:)=+S0-S1+H-S2+S3;
X(12,:)=-S0-S1+H-S2+S3;
X(13,:)=+S0+S1-H-S2+S3;
X(14,:)=-S0+S1-H-S2+S3;
X(15,:)=+S0-S1-H-S2+S3;
X(16,:)=-S0-S1-H-S2+S3;
X(17,:)=+S0+S1+H+S2-S3;
X(18,:)=-S0+S1+H+S2-S3;
X(19,:)=+S0-S1+H+S2-S3;
X(20,:)=-S0-S1+H+S2-S3;
X(21,:)=+S0+S1-H+S2-S3;
X(22,:)=-S0+S1-H+S2-S3;
X(23,:)=+S0-S1-H+S2-S3;
X(24,:)=-S0-S1-H+S2-S3;
X(25,:)=+S0+S1+H-S2-S3;
X(26,:)=-S0+S1+H-S2-S3;
X(27,:)=+S0-S1+H-S2-S3;
X(28,:)=-S0-S1+H-S2-S3;
X(29,:)=+S0+S1-H-S2-S3;
X(30,:)=-S0+S1-H-S2-S3;
X(31,:)=+S0-S1-H-S2-S3;
X(32,:)=-S0-S1-H-S2-S3;

figure(2)
clf;
plot(X','o-');
set(gca,'XTick',[1:numel(t)])
grid on;
legend;

figure(555);
clf
plot([1:numel(H)],X(22,:),'o-');
grid on;
set(gca,'XTick',(1:2:numel(H)))

E0=zeros(1,numel(H));
E1=zeros(1,numel(H));
E2=zeros(1,numel(H));
for j=SPS+1:numel(H)
    E0(j) = mean(X(:,j).*A(:,j-SPS)-X(:,j-SPS).*A(:,j));
    E1(j) = max(X(:,j).*A(:,j-SPS)-X(:,j-SPS).*A(:,j));
    E2(j) = min(X(:,j).*A(:,j-SPS)-X(:,j-SPS).*A(:,j));
end

figure(557)
clf
hold on;
II=[numel(H)/2-SPS/2+1:numel(H)/2+SPS/2];
plot(II,E0(II),'o-');
plot(II,E1(II),'o-');
plot(II,E2(II),'o-');
set(gca,'XTick',[1:numel(t)])
grid on;
legend('mean','max','min');

%Z=zeros(1,SPS);
%S1=[hg(SPS+1:numel(hg)) Z];
%S2=[Z hg(1:numel(hg)-SPS)];

%hold on
%plot(S1+hg+S2,'o-b')
%plot(-S1+hg-S2,'o-r')
%xlabel('Normalized time (t/Ts)')
%ylabel('Amplitude')
%grid off;