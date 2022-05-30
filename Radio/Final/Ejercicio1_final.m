clc;clear;

% f =
% lambda = 3e8/f;
T0       = 290;
Boltzman = 1.381e-23;
% Gamma_gas =

% Alpha =
% K=

Distancia = [11 6 14]*1e3;
Lgas_dB   = Gamma_gas*Distancia/1000;
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lb_dB     = Lgas_dB + Lbf_dB;