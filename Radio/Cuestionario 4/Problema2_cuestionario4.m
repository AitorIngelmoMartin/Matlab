clc;clear;close all;
f = 6e9;
c=3e8;
lambda= c/f;

% Alturas, distancia y radio en metros
h1 = 150;
h2 = 300;
Distancia = 35000;
R0 =6370000;

K = 4/3;
termino1 = K*R0+h1;
termino2= K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;
Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2)

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
else
    %Código ejecutado si tierra curva
    
end
