clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
f  = 14e9;
c  = 3e8;
R0 = 6370000;
K  = 0.0374;
h2 = 368;
h0 = 2.33; %Km
Angulo_elev = 27.3; %Grados
lambda      = c/f;
Distancia   = 38920; % Km

G_dBi   = 27;
G_dB    = G_dBi - 2.14;
Ptx_dBw = 5;
R_001   = 38.89;% mm/Km
Alpha   = 1.1396;

MargenDinamico_atenuador_dB = 34;

Lespecifica_lluvia = K * R_001  % dB/Km
Deff =h0+0.36 %Km