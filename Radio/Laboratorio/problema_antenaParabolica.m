clear;clc;close all;

% Ejercicio 6.4: 


% Asumiendo que las estaciones de un enlace terrestre cuentan con las antenas de
% diámetro 0.6m y que están separadas 23km, determinar el campo recibido asociado a una potencia
% recibida de -88dBm.  


% DATOS ANTENA
Dmx_dB=43.7; G = Dmx_dB; %Ya que no dicen nada más.
Dmx = 10^(Dmx_dB/10);
frec=6675e6;
c = 3e8;
lambda = c/frec;

Distancia = 23000;
Prx_dBm = -88;
Prx_w = (1/1000)*(10^(Prx_dBm/10));
Prx_dBw = 10*log10(Prx_w);

Lbf_dB =20*log10((4*pi*Distancia)/lambda);


Ptx_dBw = Prx_dBw - G - G + Lbf_dB;

PIRE_dB = Ptx_dBw + G;
PIRE_w = 10^(PIRE_dB/10);
Flujo =PIRE_w/(4*pi*Distancia*Distancia);

e = (Flujo * 120 * pi)^(1/2);

% Determinar la potencia recibida en caso de que ese valor de campo llegara a la
% antena en polarización horizontal.

XPD_dB = 63,6172;
G_contrapolar_dB = G - XPD_dB;

Flujo_contrapolar = ((e*e)/(120*pi*4*pi*Distancia*Distancia));%El mísmo que antes

PIRE_contrapolar = Flujo_contrapolar * (4*pi*Distancia*Distancia);
PIRE_contrapolar_dB = 10*log10(PIRE_contrapolar);


Prx_contrapolar_dBw = PIRE_contrapolar_dB +G_contrapolar_dB - Lbf_dB;

Prx_contrapolar_w = 10^(Prx_contrapolar_dBw/10);