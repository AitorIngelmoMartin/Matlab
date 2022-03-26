clear;close all;clc;

% señal modulada en 16PSK con un roll-off de 0,3 (lo que supone una degradación del umbral de 1 dB).
% Si la CNR mínima requerida para una BER máxima de 10^-3 es 18dB y el receptor cuenta con un atenuador variable 
% calcular el margen dinámico del atenuador.

f  = 13e9;
c  = 3e8;
lambda    = c/f;
Distancia = 10000;

Ptx_dBm  = 14;
Lt1_dB   = 1.5;
Lt2_dB   = 1.2;
Lt2      = 10^(Lt2_dB/10);
T0       = 290;
G1_dB    = 28;
G2_dB    = 23;
g2       = 10^(G2_dB/10);
Rb_bps   = 15e6;
Roll_Off = 0.3;
BW       = (1+0.3)*Rb_bps/(log2(16));
Eb_No_dB = 18;
Eb_No    = 10^(18/10);
Boltzman = 1.381e-23;


Figura_ruido_Rx_dB = 7.5;
alfa_gases        =0.1; %dB/Km

Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lgases_dB = alfa_gases*Distancia/1000;
Lb_dB     = Lbf_dB + Lgases_dB;

%Como no dan figura de ruido del amplificador, supongo que es ideal f=1
T_antes_dispositivo = T0*g2/Lt2 + T0*(1-1)*g2/Lt2 + T0*(Lt2-1)*(1/Lt2) 

Prx_dBm = Ptx_dBm + G1_dB + G2_dB -Lbf_dB -Lt1_dB -Lt2_dB
Prx_W   = (1/1000) * 10^(Prx_dBm/10)

Thx = Eb_No + 10*log(Boltzman*T_antes_dispositivo*BW) - BW

MD_W =  Prx_W - Thx

