% Se estudia un radioenlace de 10km que trabaja a 13 GHz. 
% El transmisor entrega una potencia de 14dBm, presentando 
% una pérdida en la línea de transmisión de 1,5 dB, y una ganancia 
% de la antena de 28 dB. El receptor, cuya antena tiene una ganancia de 23 dB,
% presenta unas pérdidas en la línea de transmisión de 1,2 dB y un dispositivo con un factor de ruido
% de 7,5 dB. La velocidad de transmisión es  15Mbps, transmitiendo una señal modulada en 16PSK 
% con un factor de roll-off de 0,3 (lo que supone una degradación del umbral de 1 dB). Si la CNR mínima requerida para una BER máxima de 10^-3 es 18dB y el receptor cuenta con un atenuador variable frente a desvanecimientos, calcular el margen dinámico del atenuador.

clc;clear;

f = 13e9; %en hercios
c = 3e8;
lambda = c/f;

d = 10e3; %en metros
Ptx_dBm = 14;
Lt_tx_dB = 1.5;
Gtx_dB = 28;

Lt_rx_dB = 1.2;
Grx_dB = 23;

factor_ruido_rx_dB = 7.5;

T0 = 290; %temperatura normal en Kelvin
K = 1.38*10e-23; %constante de boltzman en J/K
BER_max = 10e-3;
CNR_min_dB = 18;
Rb_tx = 15e6; %velocidad de transmision en bps
roll_off = 0.3; %Factor para señal modulada 16-PSK. 
Ux = 1; %degradación del umbral
"Modulación 16-PSK"
"Atenuador variable frente a desvanecimientos"


%-------------------------------------------------------------------------

Eb_No_dB= 14; %de tabla
B = (1+roll_off)*Rb_tx; %ancho de banda


%Perdidas

gamma_gases = 0.02;
Lgases_dB = gamma_gases*d/1000;
Lbf_dB = 20*log10(4*pi*d/lambda);
Lb_dB =Lbf_dB + Lgases_dB;

% Prec_atenuador = Umbral_dBm + MD_dB = Ptx_dBm + G_dBi - Lt_dB - Lb_dB + G_dBi - Lt_dB; Para atenuador variable
% MD_dB = Ptx_dBm - Umbral_dBm + Gtx_dB - Lt_tx_dB - Lb_dB + Grx_dB - Lt_rx_dB;
Prec_CN_dBm = Ptx_dBm + Gtx_dB - Lt_tx_dB - Lb_dB + Grx_dB - Lt_rx_dB;

MD_dB = Prec_CN_dBm - Ux;