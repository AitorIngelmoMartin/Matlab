clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
f  = 13e9;
c  = 3e8;
R0 = 6370000;
lambda    = c/f;
Distancia = 10000; % Km

Ptx_dBm  = 14;
Lt1_dB   = 1.5;
Lt2_dB   = 1.2;
Lt2      = 10^(Lt2_dB/10)
T0       = 290;
G1_dB    = 28;
G2_dB    = 23;
g2       =10^(G2_dB/10);
Rb_bps   =15e6;
BW       = Rb_bps/(log2(16))

Factor_ruido_recepcion_dB = 7.5;

Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lgases_dB = 0.09*Distancia/1000;
Lb_dB     = Lbf_dB + Lgases_dB;


T_antes_dispositivo = T0*g2/Lt2 + T0*(2-1)*g2/Lt2 + T0*(Lt2-1)*(1/Lt2) 


Prx_dBm = Ptx_dBm + G1_dB + G2_dB -Lbf_dB -Lt1_dB -Lt2_dB