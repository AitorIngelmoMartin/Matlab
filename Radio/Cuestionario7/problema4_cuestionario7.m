clear;close all;clc;

f  = 11.2e9;
c  = 3e8;
R0 = 6370000;
K  = 0.55; %Tabulando a casi 20
q  = 0.01;
lambda    = c/f;
Distancia = 14; % Km

f       = f/(1e9);
q       = 0.005;
G_dB    = 27;
R_001   = 29;% mm/Km
Umbral_dBm = -88;
Alpha = 1; %Tabulando casi a 20 en PV

Ptx_dBm_PH = 23;
Lt_dB      =  1;
K_PH       = 0.0189;
Alpha_PH   = 1.2069;
K_PV       = 0.0187;
Alpha_PV   = 1.1528;

