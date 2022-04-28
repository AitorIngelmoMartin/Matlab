clear;close all;clc;

f   = 880e6;
c   = 3e8;
lambda = c/f;

% Polarizacion = "Horizontal"
% Polarizacion = "Vertical"

R0  = 6370000;
K   = 4/3;
Re  = K*R0;
h1  = 230+51;
h2  = 195+33;
uve = -0.256549116623488
Ldiff_dB = 6.9 + 20*log10(sqrt((uve-0.1)^2+1)+uve-0.1)

Distancia = 34e3;

Thx_dBm = -86;
% Ptx_dBw = 2;
% Ptx_W   = 10^(Ptx_dBw/10);

% Ptx_dBm = 55;
% Ptx_W   = (1/1000)*10^(Ptx_dBm/10);

% Cadena de potencias
Lt_dB = 2;
    Lt = 10^(Lt_dB/10);
G_dB = 23;
     G = 10^(G_dB/10);

%  LLuvias   
Lvble_dB = 15;
Lvble = 10^(Lvble_dB/10);
%      K_lluvia =0.2646 
%      R_001 =18;% mm/Km
%      Alpha = 0.8981;     %Tabulando casi a 20 en PV

% Pérdidas

gamma_gases = 0.03;
Lgases_dB   = gamma_gases*Distancia/1000;
Lbf_dB      = 20*log10(4*pi*Distancia/lambda);

Prx_dBm = Thx_dBm + Lvble_dB;
% Prx_dBm = Ptx_dBm + G_dB + G_dB - Lbf_dB - Ldiff_dB -Lt_dB -Lt_dB
Ptx_dBm = Prx_dBm -(+ G_dB + G_dB- Lgases_dB - Lbf_dB - Ldiff_dB -Lt_dB -Lt_dB)

PIRE_dBm = Ptx_dBm +G_dB -Lt_dB;
PIRE_W = (1/1000)*(10^(PIRE_dBm/10))
% 2)Flujo
Flujo     = (PIRE_W)/(4*pi*Distancia*Distancia)
