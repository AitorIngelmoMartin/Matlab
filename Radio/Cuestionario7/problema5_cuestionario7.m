clear;close all;clc;

f   = 18e9;
c   = 3e8;
R0  = 6370000;
K   = 4/3;
Re  = K*R0;
h1  = 235;
h2  = 312;
Ptx = 2;
U   = 0.1; %Indisponibilidad total en porcentaje


Ptx_dBm    = 10*log10(Ptx*1000);
lambda     = c/f;
K_PH       = 0.0708;  
G_dB       = 24;
R_001      = 32;% mm/Km
Lt_dB      = 2;
Umbral_dBm = -96;
Umbral_W = (1/1000)*10^(Umbral_dBm/10);

Alpha_PH    = 1.0818; %Tabulando casi a 20 en PV
MTBF_horas  = 1.5e6;
Distancia   = 35000;

%OBSTACULO A---------
Distancia_E1_O1 = 8000;
Distancia_E2_O1 = Distancia - Distancia_E1_O1;
e_O1            = 240;

Flecha_O1        = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

AlturaRayo_O1    = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

Despejamiento_O1 = Flecha_O1 + e_O1-AlturaRayo_O1;

Rfresnell_O1 = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1));

Difracc_O1   = sqrt(2)*(Despejamiento_O1/Rfresnell_O1)


%OBSTACULO B---------
Distancia_E1_O2  = 14000;
Distancia_E2_O2  = Distancia - Distancia_E1_O2;
e_O2             = 240;

Flecha_O2        = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

AlturaRayo_O2    = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

Despejamiento_O2 = Flecha_O2 + e_O2-AlturaRayo_O2;

Rfresnell_O2 = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

Difracc_O2   = sqrt(2)*(Despejamiento_O2/Rfresnell_O2)
%--------------------


if(Difracc_O1>-0.78 && Difracc_O2<-0.78)
    Ldif_dB   = 6.9 + 20*log10(sqrt((Difracc_O1-0.1)^2+1)+Difracc_O1-0.1)
end
    
Lbf_dB    = 20*log10((4*pi*Distancia/lambda));

Distancia = 35;f=18;  

Lgases_dB = 0.060*Distancia; 
Lespecifica_lluvia = K_PH *(R_001^Alpha_PH)  % dB/Km

termino1 = 0.477*(Distancia^0.633)*(R_001^(0.073*Alpha_PH))*(f^(0.123));
termino2 = 10.579*(1-exp(-0.024*Distancia));
Deff     = (Distancia)/(termino1-termino2) %Km

F_001    = Lespecifica_lluvia* Deff % dB


if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

MD_dB = Ptx_dBm - Umbral_dBm + G_dB - Lt_dB - (Lbf_dB + Lgases_dB + Ldif_dB) + G_dB - Lt_dB;
Fq_dB= MD_dB;

logaritmo = log10(MD_dB/(F_001*C1));

soluciones_x =  [( -C2 + sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3),( -C2 - sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3)];
x =max(soluciones_x);
q_calculado = 10^x

UR_lluvia = q_calculado;

% Umbral_W = 2*MTTR*(100/MTBF_horas)
MTTR= + (U-UR_lluvia)*(MTBF_horas)/(2*100)


