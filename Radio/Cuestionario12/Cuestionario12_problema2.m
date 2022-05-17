clc;clear;

% Se pretende diseñar una red de radioenlaces con la configuración 
% representada en la figura adjunta que conecta tres estaciones terminales 
% a partir de repetidores activos situados en el emplazamiento D.

% La banda de trabajo seleccionada para ofrecer el servicio es 
% 13GHz (12,75 – 13,25 GHz) y la separación entre canales es de 28MHz. 
% Como primer paso del diseño se asume que todas las estaciones tienes
% propiedades similares

f = 13e9;
lambda = 3e8/f;
% - Ganancia 36dB
G_dB = 36;
% - Polarización horizontal

K_lluvia = 0.03041;
Alpha    = 1.1586;
% - Pérdidas en terminales 2dB
Lt_dB = 2;
% - CAG como mecanismo de protección frente a desvanecimientos
% - Figura de ruido 8dB
F_receptor = 8;
% - MTTR=4h y MTBF=250.000h
MTTR = 4;
MTBF = 250000;
% - CNR_ideal=10dB 
CNR_ideal = 10;
% - Capacidad de 20Mbps modulados en 16QAM con un filtro de coseno alzado 
% con factor de roll-off 0,3 (degradación por el filtro de 1dB)
Rb_bps = 20e6;
M  = 16;
roll_off = 0.3;
% - Diagrama de radiación de la antena (azul para polarización horizontal, rojo para polarización vertical)
% 1) Determinar el número de radiocanales que se puede ofrecer si ZS1=15MHz, ZS2=23MHz e YS=70MHz
BW_total = (13.25 -12.75)*1e9;
Separacion_canal = 28e6;
Guarda_1               = 15e6;
Separacion_direcciones = 70e6;
Guarda_2               = 23e6;

% BW_total = Guarda_1 +(N-1)*Separacion_canal + Separacion_direcciones + (N-1)*Separacion_canal + Guarda_2;
N = (((BW_total - Separacion_direcciones - Guarda_1 - Guarda_2)/Separacion_canal) +2)/2

% Rb_bps           = (Separacion_canal*log2(M))/(1+roll_off)
% 2) Determinar la potencia a transmitir en cada vano del enlace A-C 
% despreciando el efecto de las interferencias y la indisponibilidad por
% equipos en dicho enlace
Distancia = [28 23]*1e3;
Boltzman  = 1.381e-23;

T0 = 290;
Lt = 10^(Lt_dB/10);
Bn = Rb_bps/(log2(M));

f_receptor   = 10^(F_receptor/10);
T_despues_lt = T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(f_receptor-1)

Gamma_gases = 0.02;
Lgases_dB   = Gamma_gases*Distancia/1000;
Lbf_dB      = 20*log10((4*pi*Distancia)/lambda);
Lb_dB = Lbf_dB + Lgases_dB;

Umbral_ideal_dBm = CNR_ideal  + 10*log10(T_despues_lt*Boltzman*Bn) + 30

PIRE_dBm = Umbral_ideal_dBm + Lb_dB - G_dB + Lt_dB - G_dB + Lt_dB
% 3) Comprobar la viabilidad del enlace A-B teniendo en cuenta el efecto 
% sólo de las interferencias intrasistema cocanales y asumiendo que todas
% las estaciones transmiten con 4dBm: demostrar que la potencia recibida 
% en condiciones normales es mayor que el umbral en cada vano.
Distancia = [28 14]*1e3;

Lgases_dB = Gamma_gases*Distancia/1000;
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lb_dB     = Lbf_dB + Lgases_dB;


% DATOS:
% CIR            Degradación del umbral
% CIR≥30dB               1dB
% 20dB≤CIR<30dB          3dB
% 10dB≤CIR<20dB          10dB


