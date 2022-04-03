clear;close all;clc;


F_ll = 19;
f  = 11.2e9;
c  = 3e8;
R0 = 6370000;
K  = 0.55; %Tabulando a casi 20
q  = 0.005;
lambda    = c/f;
Distancia=14000;
Lbf_dB = 20*log10((4*pi*Distancia)/lambda);
Distancia = 14; % Km


f       = f/(1e9);
q       = 0.005;
G_dB    = 40.4;
R_001   = 37;% mm/Km
Umbral_dBm = -88;

Ptx_dBm_PH = 23;
Lt_dB      =  1;
K_PH       = 0.0189;
Alpha_PH   = 1.2069;
K_PV       = 0.0187;
Alpha_PV   = 1.1528;

% PH
Gamma_PH = K_PH *(R_001^Alpha_PH)  % dB/Km

termino1 = 0.477*(Distancia^0.633)*(R_001^(0.073*Alpha_PH))*(f^(0.123));
termino2 = 10.579*(1-exp(-0.024*Distancia));
Deff     = (Distancia)/(termino1-termino2) %Km

F_001_PH    =   Gamma_PH * Deff % dB
% Almenos en una hora al año, la lluvia va a probocar una atenuación
% mayor que F_001 en dB.

if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

Fq_PH = F_001_PH*C1*(q^(-(C2+C3*log10(q))));


if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

% F_ll = 19;
U = 15 + 30*log10(f);

if (f>8 && f<=20)
    V = 12.8*f^0.19;
elseif (f>20 && f<=35)
    V = 22.6;
end

XPD_ll = U - V*log10(Fq_PH);

Lgases_dB = 0.0160*Distancia;
XPD_dB    = 0--40;

Prx_CP_PH_dBm = Ptx_dBm_PH + G_dB -Lt_dB - Lbf_dB - Lgases_dB - Fq_PH + G_dB - Lt_dB

Prx_XP_PH_dBm = Ptx_dBm_PH + G_dB -Lt_dB - Lbf_dB - Lgases_dB - Fq_PH + G_dB - Lt_dB - XPD_dB - XPD_ll 

Prx_CP_PV_dBm = Ptx_dBm_PH + G_dB -Lt_dB - Lbf_dB - Lgases_dB - Fq_PH + G_dB - Lt_dB - XPD_ll

Prx_XP_PV_dBm = Ptx_dBm_PH + G_dB -Lt_dB - Lbf_dB - Lgases_dB - Fq_PH + G_dB - Lt_dB - XPD_dB
