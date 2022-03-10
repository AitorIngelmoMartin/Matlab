clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
f  = 38e9;
c  = 3e8;
R0 = 6370000;
K  = 0.3884;
lambda    = c/f;
Distancia = 15; % Km
f       = 38;
G_dBi   = 27;
G_dB    = G_dBi - 2.14;
Ptx_dBw = 5;
R_001   = 24.42;% mm/Km
Alpha   = 0.8552;

MargenDinamico_atenuador_dB = 34;

Lespecifica_lluvia = K *(R_001^Alpha)  % dB/Km

termino1 = 0.477*(Distancia^0.633)*(R_001^(0.073*Alpha))*(f^(0.123));
termino2 = 10.579*(1-exp(-0.024*Distancia));
Deff     = (Distancia)/(termino1-termino2) %Km

F_001 = Lespecifica_lluvia* Deff % dB
% Almenos en una hora al año, la lluvia va a probocar una atenuación
% mayor que F_001 en dB.

if(f>=10e9)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

% Fq = F_001*C1*(0.01^(-(C2+C3*log10(0.01))));

Lbf_dB = 20*log10((4*pi*Distancia*Distancia)/lambda);

Prx_dBm = Ptx_dBw + G_dBi - Lbf_dB + G_dBi;