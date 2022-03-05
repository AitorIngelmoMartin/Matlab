
%% Radioenlace EPS-Pueblo Barajas. Grupo 4


%% Cálculo de Lad por MTC. Pérdidas por reflexión
clear 
close all

h1=5;
h2=5;
cota1=612.4224;
cota2=623.8448;
H1=cota1+h1;
H2=cota2+h2;
d=21189.76298;%m
f=23e9;
sigma=0.001;% S/m
epsilon_r=15;
rho=0.5865;
K=4/3;
Ro=6370*1e3;%m

dmax=sqrt(2*K*Ro*H1)+sqrt(2*K*Ro*H2);
dlim=0.1*dmax;

%H2>H1
p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4));
Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3);%PHI
d2=d/2+p*cos((pi+Phi)/3);

d1=d-d2;
hp1=H1-(d1^2/(2*K*Ro));
hp2=H2-(d2^2/(2*K*Ro));
tan_phi=hp1/d1;
phi=atan(tan_phi);%phi

phi_lim=((5400/(f/1e6))^(1/3))/(1e3);%rad
%phi_lim=6.1691e-4 < phi=5.81e-2 -> reflexión MTC

lamda=3*10^8/f;
epsilon_o=epsilon_r-1j*60*sigma*lamda;


Ab=(2*hp1*hp2)/(d);%incremento de longitud
Gamma=(4*pi*rho*sin(phi))/(lamda);

Rv=(epsilon_o*sin(phi)-sqrt(epsilon_o-cos(phi).^2))/(epsilon_o*sin(phi)+sqrt(epsilon_o-cos(phi).^2))
D=1/sqrt(1+((5/(16*K))*(((d2/1e3)*(d1/1e3)^2)/((d/1e3)*H1))));
Re=Rv*D*exp(-(Gamma^2)/2);

lad=1/abs(1+Re*exp(-1i*2*pi*Ab/lamda))^2
Lad=10*log10(lad)

%% Cálculo de Lad por MDTE. Pérdidas por difracción
clear 
close all

cota1=612.4224;
cota2=623.8448;
d=21189.76298;%m. Distancia total del enlace
f=23e9;
k=4/3;
Ro=6370e3;
h1=10;
h2=55;
cotao1=613.075;%O1. obstáculo más cercano a h1
cotao2=651.076;%O2. obstáculo más cercano a h2
d1=1.46134e3;%distancia h1-O1
d2=14.7828e3-d1;%distancia O1-O2
d3=d-14.7828e3;%distancia O2-h2
lamda=3e8/f;

%Parámetro de difracción V1
c1=(d1*(d2+d3)/(2*k*Ro)+cotao1)-((h2+cota2-h1-cota1)*d1/d+h1+cota1);
R1=sqrt(lamda*(d1*(d2+d3)/d));
V1=sqrt(2)*(c1/R1)

%Parámetro de difracción V2
c2=(d3*(d2+d1)/(2*k*Ro)+cotao2)-((h2+cota2-h1-cota1)*(d1+d2)/d+h1+cota1);
R2=sqrt(lamda*(d3*(d2+d1)/d));
V2=sqrt(2)*(c2/R2)

