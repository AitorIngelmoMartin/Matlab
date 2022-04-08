clear;close all;clc;

f   = 32e9;
c   = 3e8;
lambda = c/f;

% Polarizacion = "Horizontal"
Polarizacion = "Vertical"

R0  = 6370000;
K   = 4/3;
Re  = K*R0;
h1  = 277;
h2  = 91;

Distancia = 35e3;
%
% Ptx_dBw = 2;
% Ptx_W   = 10^(Ptx_dBw/10);

Ptx_dBm = 55;
Ptx_W   = (1/1000)*10^(Ptx_dBm/10);

% Cadena de potencias
Lt_dB = 1;
    Lt = 10^(Lt_dB/10);
% G_dB = 15-5;
%     G = 10^(G_dB/10);

G1_dB = 15-5;
    G1 = 10^(G1_dB/10);
G2_dB = 50;
    G2 = 10^(G2_dB/10);

G_LNA_dB = 25;
   G_LNA = 10^(G_LNA_dB/10);
F_LNA_dB =5;
   F_LNA = 10^(F_LNA_dB/10);
Lmezclador_dB = 12;
  Lmezclador = 10^(Lmezclador_dB/10);

% en S/m
Conductividad =5;
Permeavilidad_terreno=70;

% Si dan rugosidad:
    Rugosidad =0;
    
%  LLuvias   
     K_lluvia =0.2646 
     R_001 =18;% mm/Km
     Alpha = 0.8981;     %Tabulando casi a 20 en PV
% horas
MTTR1=8;
MTBF1 = 3.2e5;

MTTR2 = 4;
MTBF2 = 1e6;

% Ruidos
T0 = 290;
Boltzman = 1.381e-23;
Degradacion = 1.5;
M           = 16;
CNR_dB      = 11;
Rb_bps      = 64e6;
Bn          = Rb_bps/(log2(M));
% Pérdidas

 gamma_gases = 0.09;
 Lgases_dB   = gamma_gases*Distancia/1000;
 Lbf_dB      = 20*log10(4*pi*Distancia/lambda);
