function R1=rlossc(Z,Freq,Zo,linetype);
% Return Loss Plot
%
% Plot Return Loss as a function of frequency
% Default display is figure(5)
%
% Usage : rlossc(Z,Freq,Zo,linetype)
%
%    e.g. rlossc(Z,Freq,50,'r')

% N.Tucker www.activefrance.com 2008

figure();
clf;
chartname=['|\Gamma|  (Zo=',num2str(Zo),')'];
%set(5,'name',chartname);

Zr=Z;
p=(Zr-Zo)./(Zr+Zo);
s=(1+abs(p))./(1-abs(p));
% s es el coeficiente de onda (ROE) que no representa
R1=20.*log10(abs(p));
%Lretorno=-R1;
plot(Freq,R1,linetype,'LineWidth',2);
grid;

title(chartname);
xlabel('Frequency MHz');
ylabel('|\Gamma| dB');
legend('|\Gamma_{L}|')

axis('square');
V=[min(Freq),max(Freq),-90,0];
axis(V);
