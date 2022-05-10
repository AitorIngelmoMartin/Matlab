% % Problema 1

%datos
d = 13e3;
G_dB = 34;
Lt_dB = 3;
a1 = 8;
a2 = 22;
f = 2.5;
e_dBu = 71.2; %  
% campo recibido
Refectivo = -0.8628; % coeficiente de reflexion efectivo 
Rtierra = 6370e3;
k = 4/3;
c= 3e8;
%solución
lambda = c/f;
Prad_dB = e_dBu - 10*log10(120*pi) - 120;
PIRE = 


%%Problema 2

%datos
d = 21000; 
f = 5e9;
Prec_dBm = -80; %dBm
h1 = 10;
h2 = 8;
Ptx_dBW = -15; %dBW
G_dB = 27;
permitividad_r = 15; %suelo
conductividad = 0.001;
%polarizacion horizontal
Rtierra = 6370e3;
k = 4/3;
permitividad_0 = -0.8628;

%solución
dmax = sqrt(2*Rtierra*k)*(sqrt(h1)+sqrt(h2)); % d>0,1dmax -> MTC

%reflexion o difraccion?
p = 2/sqrt(3)*(k*Rtierra*(h1+h2)+ d^2/4)^(1/2);
theta = acos(2*k*Rtierra*(h1-h2)*d/p^3);

d1 = (d/2 + p*cos((pi+theta)/3)); %en km
d2 = d - d1; %en km

hp1 = h1-(d1^2/(2*k*Rtierra));
hp2 = h2-(d2^2/(2*k*Rtierra));

phi_limite = ((5400*1e6/f)^(1/3))*1e-3;
phi = atan(hp1/d1); %phi>phi_lim -> reflexion



%%Problema 3
clc;
clear;
%datos
d = 38000;
f = 23e9;
a1 = 150;
a2 = 40;
e1 = 150;
e2 = 200;
h1 = a1 + e1;
h2 = a2 + e2;
d_obs1 = 15e3;
d_obs2 = 29e3;
ho1 = 261;
ho2 = 239;
%polarizacion horizontal
Rtierra = 6370e3;
k = 4/3;
Re = k*Rtierra;

%solución
dmax = sqrt(2*Rtierra*k)*(sqrt(h1)+sqrt(h2)); % d>0,1dmax -> MTC
d11=2*Re*h1;
d22 = 2*Re*h2;
dmax1 = d1+d2;

%reflexion o difraccion?
p = 2/sqrt(3) * (k*Rtierra*(h1+h2)+ d^2/4)^(1/2);
theta = acos((2*k*Rtierra*(h1-h2)*d)/p^3);

d1 = (d/2 + p*cos((pi+theta)/3)); %en km
d2 = d - d1; %en km

hp1 = h1-(d1^2/(2*k*Rtierra));
hp2 = h2-(d2^2/(2*k*Rtierra));

phi_limite = (5400*1e6/f)^(1/3);
phi = atan(hp1/d1)*1e3; %phi>phi_lim -> reflexion 



