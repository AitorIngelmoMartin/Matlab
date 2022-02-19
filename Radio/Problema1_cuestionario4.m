clear;clc;close all;

f = 15e9;
c=3e8;
lambda = c/f;

D = 24000; % 24Km

Ptx = 0.001*(10^(24/10));
Ptx_dBw = 10*log10(Ptx);

Perdida_guia = (5/100)*33; %En dBm
Perdida_alimentador = 0.5; %dB

Lt_dB =  Perdida_guia +Perdida_alimentador;
Lt = 10*10^(Lt_dB/10);

% Pérdidas en espacio libre, en dB y Wats
Lbf = ((4*pi*D*D)/lambda)^2;
Lbf_dB = 20*log10((4*pi*D*D)/lambda)

% PIRE en dBw y W
g_dB=28;
g = 10^(g_dB/10);

Prad_dBw = Ptx_dBw + g_dB - Lt_dB;
Prad = 10^(Prad_dBw/10);

PIRE = Prad*(1/Lbf);
PIRE_dBW = 10*log10(PIRE)

% Flujo en dBw/m2
Flujo = (Prad*g)/(4*pi*D*D);
Flujo_dBw = 10*log10(Flujo)

e = sqrt(Flujo*120*pi);
e_dBuVn = 20*log10(e/1e-6);


%Cálculos adicionales
Seff = ((lambda^2)/(4*pi))*g
Seff_dB = 10*log(Seff);

Prx = ((Ptx*(1/Lt))/(4*pi*D*D))*Seff*g*(1/Lt)

10*log10(Prx)

Prx_dBw = Ptx_dBw + g_dB + g_dB -Lbf_dB -Lt_dB -Lt_dB + Seff_dB
