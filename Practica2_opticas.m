clc;clear;close all;

P1 = [0.20 0.70	-0.08 0.52 -0.08 0.46];
P2 = [-57 -57.77  -55.80 -54.96 0 0 ];
P3=[-3.97 -2.99 -2.01 -1.83 -29.55 -0.82];
P4=[-4.01 -3.52	-12.1 -8.11 -1.08 -24.96];

Perdidas_insercion_dB = P1-P3

Perdidas_exceso_dB =-10*log10((10.^(P3/10)+10.^(P4/10))./(10.^(P1/10)))


Acoplamiento_dB = (10.^(P4/10))./((10.^(P3/10)+10.^(P4/10)))



P1 = 0.24;
P2= -5;
P3= -19.76;

Insercion_1310_dB   = P1-P2
Aislamiento_1310_dB = P2-P1

P1 =  0.68;
P2 = -1.38;
P3 = -55.5;

Insercion_1550_dB   = P1-P2
Aislamiento_1550_dB = P2-P1
