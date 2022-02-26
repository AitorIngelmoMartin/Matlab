clear;close all;clc;

f = 23e9;
c=3e8;
lambda= c/f;
R0 =6370000;
K = 4/3;

h1 = 3000;
h2 = 240;
Distancia = 38000;

%OBSTACULO A---------
DobsA_1 = 15000;
DobsA_1 = Distancia -DobsA_1;
Eobs    = 261;
%--------------------

%OBSTACULO B---------
DobsB_1 = 29000;
DobsB_2 = Distancia - DobsB_1;
EobsB   = 239;
%--------------------




% -------------------------------------------------------------------------

termino1 = K*R0+h1;termino2= K*R0;termino3 = K*R0+h2;termino4 = K*R0;

Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

% -------------------------------------------------------------------------


P = (2/3^0.5)*(((K*R0*(h1+h2)+(Distancia^2)/4)))^0.5; 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*Distancia)/P^3);
    d1 = Distancia/2+P*cos((pi+Thau)/3);
    d2=Distancia-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*Distancia)/P^3);
    d2 = Distancia/2+P*cos((pi+Thau)/3);
    d1=Distancia-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi = atan(H1/d1);
Phi_lim = (1/1000)*(5400/(f/1000))^(1/3);

% Programar para que vaya solito por PH/PV


if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"  
    
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
end

% -------------------------------------------------------------------------

