clear;clc;close all;

% En Mhzs
f = 800;
Radio_efectivo = 20;
Incremento_distancia = 50;

Lambda = (2*pi)/f;


% En mili radianes
Gamma_lim = (5400/f)^(1/3);

Campo_espacio_libre = 50;


%   "e" 
Termino_auxiliar = (1 + Radio_efectivo*exp(-i*((2*pi)/Lambda))*Incremento_distancia);
Campo_e = Campo_espacio_libre*Termino_auxiliar;

% Pérdidas totales "Lb = Lbf + Lpp" | Lad = (|efs|^2)/(|e|^2)

Lad = 1/(norm(Termino_auxiliar))^2;

% DUDAS
%     *Que es Re, ¿Radio efectivo?.
%     *Cual es la fórmula de efs.
%     *


