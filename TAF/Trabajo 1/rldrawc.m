function R1=rldrawc(Z,Freq,Zo,linetype);
% Return Loss trace
%
% Plot additional Return Loss trace on existing plot in specified colour
%
% Usage : rlossc(Z,Freq,Zo,linetype)
%         
% e.g.  rldrawc(Z1,Freq,Zo,'g-') 
%           

% N.Tucker www.activefrance.com 2008

hold on;
Zr=Z; % Es la Z que carga a la línea de 50 ohmios cuando hemos insertado la red adaptadora
p=(Zr-Zo)./(Zr+Zo);
s=(1+abs(p))./(1-abs(p));
R1=20.*log10(abs(p));
% Lretorno=-R1;
posiciones=find(R1<-80);
R1(posiciones)=-80;
plot(Freq,R1,linetype,'LineWidth',2);
ylabel('|\Gamma| dB');
legend('|\Gamma_{L}| without matching network', '|\Gamma_{IN}| with matching network')
hold off;