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
CNR_dB = 18;
CNR    = 10^(CNR_dB/10);
Boltzman = 1.381e-23;


Figura_ruido_Rx_dB = 7.5;
Figura_ruido_Rx = 10^(Figura_ruido_Rx_dB/10);
alfa_gases        =0.2; %dB/Km

Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lgases_dB = alfa_gases*Distancia/1000;
Lb_dB     = Lbf_dB + Lgases_dB;

%Como no dan figura de ruido del amplificador, supongo que es ideal f=1
T_antes_dispositivo = T0/Lt2 + T0*(Lt2-1)/Lt2 + T0*(Figura_ruido_Rx-1)


Prx_dBm = Ptx_dBm + G1_dB + G2_dB -Lbf_dB -Lt1_dB -Lt2_dB
Prx_W   = (1/1000) * 10^(Prx_dBm/10)

degradacion = (1+Roll_Off)*(Rb_bps/log2(16))
Bn = Rb_bps/log2(16);

Thx_dBW = CNR_dB + 10*log10(Boltzman*T_antes_dispositivo*Bn)+10*log10(degradacion)

Thx_W = 10^(Thx_dBW/10);
MD_W =  Prx_W - Thx_W
logaritmo = log10(MD/F_001*C1);

soluciones_x =  [( -C2 + sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3),( -C2 - sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3)];
x =max(soluciones_x);
q = 10^x
