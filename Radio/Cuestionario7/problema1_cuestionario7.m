clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
f  = 18e9;
c  = 3e8;
R0 = 6370000;
K  = 0.0771; %Tabulando a casi 20
q  = 0.01;
lambda    = c/f;
Distancia = 16; % Km

f       = 18;
G_dB    = 27;
R_001   = 29;% mm/Km
Umbral_dBm = -88;
Alpha = 1.0025; %Tabulando casi a 20 en PV

Gamma_r  = K* R_001^Alpha %dB/Km
termino1 = 0.477*(Distancia^0.633)*(R_001^(0.073*Alpha))*(f^(0.123));
termino2 = 10.579*(1-exp(-0.024*Distancia));
Deff     = (Distancia)/(termino1-termino2) %Km

F_001    = Gamma_r * Deff % dB
if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);
Fq = F_001;
Distancia = 16e3;
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lgases_dB = 0.09*Distancia/1000;
Lb_dB     = Lbf_dB + Lgases_dB;

PIRE_dBm_vbls = Umbral_dBm - G_dB + Lb_dB + Fq

PIRE_dBm_cag  = Umbral_dBm - G_dB + Lb_dB