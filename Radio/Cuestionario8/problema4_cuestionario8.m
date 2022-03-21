clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
f  = 18e9;
c  = 3e8;
R0 = 6370000;
lambda    = c/f;
Distancia = 21000; % Km
Simbolos  = 64;
roll_off  = 0.3;

Sigma     = 0.001;
epsilon_R = 15;
factor_rugosidad = 0.2;
G_dB = 9;
h1 =210;
h2 =54;

%  LNA con una figura de ruido de 6dB y ganancia 20dB, 
%  un mezclador con pérdidas 12dB 
%  amplificador en frecuencia intermedia con figura de ruido de 14dB que permite amplificar hasta 20dB. 


% El requisito de Eb/N0 es de 16dB para un filtro ideal. El MTTR es de 4 horas y el MTBF de 468.000 horas. Datos: R0,01=33mm/h
Eb_N0_dB = 16;
MTTR     = 4;

MTBF  = 468000
R_001 = 33;
% Determinar la PIRE y la indisponibilidad del enlace.

Ptx_dBm = 14;
Lt_dB   = 2;
Lt      = 10^(Lt_dB/10)
T0      = 290;

Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lgases_dB = 0.09*Distancia/1000;
Lb_dB     = Lbf_dB + Lgases_dB;





Prx_dBm = Ptx_dBm + G1_dB + G2_dB -Lbf_dB -Lt1_dB -Lt2_dB