close all
clear

k=4/3;
f=450*10^6;
lamda=3e8/f;
R0=6370*1000;
d=6.8e3;
dt1=1644;
d2 = 3265;
dt2=(d-(d2));
ht1=1763; 
ht2=1798; 
htx=(10+1652); 
hrx=(50+1678); 

phi=((ht1-htx)/dt1)+((ht2-hrx)/dt2);
R=(d-dt1-dt2)/phi;

beta=((hrx-htx)/d)+((ht2-hrx)/dt2);
dp=((beta*d)/phi);
hp=((ht1-htx)/dt1)*dp+htx;

flecha=(dp*(d-dp))/(2*k*R0);
rayoE1=htx; rayoE2=hrx;
rayo=(rayoE2-rayoE1)*dp/(d)+rayoE1;
desp=hp+flecha-rayo;
R1=sqrt(lamda*(dp*(d-dp))/(d));
despeja_porcen=100*desp/R1;
Q=sqrt(2)*desp/R1;
cp=hp-rayo;
d1=sqrt(((0-dp)^2)+((htx-cp)^2));
d2=sqrt(((d-dp)^2)+((hrx-cp)^2));
coef_v=desp*sqrt(2)./R1; %Parámetro de difracción

J = 6.9+20*log10(sqrt((coef_v-0.1).^2+1)+coef_v-0.1);
% %Perdidas de difraccion obstaculo puntiagudo
% Ltotal=6.9+20*log10(sqrt((0.7-0.1)^2+1)+0.7-0.1);

%Perdidas adiciolanes obstaculo redondeado
mnum=R*(d1+d2)/(d1*d2);
mden=((pi*R)/lamda)^(1/3);
m=mnum/mden;

nnum=cp*(((pi*R)/lamda)^(2/3));
nden=R;
n=nnum/nden;

condicion=n*m;

if condicion > 4
    Tm=-(-6-20*log10(m*n)+7.2*((m)^(1/2))-(2-17*m)*m+3.6*(m^(3/2))-0.8*(m^2));
else 
    Tm= 7.2*m^0.5 - (2-12.5*n)*m + (3.6*m)^3/2 - 0.8*m^2;
end

Lad = Tm + J;