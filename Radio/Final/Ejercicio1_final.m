clc;clear;

% f =
% lambda = 3e8/f;

% Gamma_gas =
% Alpha     =
% K         =

% RUIDOS----------
T0       = 290;
Boltzman = 1.381e-23;
% F_receptor_dB =
% F_receptor    = 10^(F_receptor_dB/10);

% G_dB =
% G    = 10^(G_dB/10);

% Lt_dB =
% Lt    = 10^(Lt_dB/10);
% ----------
T_antes_dispositivos 

% VANOS INTERFERENCIA-----------------------

Distancia = [11 6 14]*1e3;
Lgas_dB   = Gamma_gas*Distancia/1000;
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lb_dB     = Lgas_dB + Lbf_dB;

Umbral=Eb_N0+10*log10(K*T_total*Rb)+degradacion+30;
PIRE_dBm = Umbral + Lb_dB - G_dB + Lt_dB ;

