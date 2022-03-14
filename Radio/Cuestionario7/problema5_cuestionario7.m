clear;close all;clc;

f   = 18e9;
c   = 3e8;
R0  = 6370000;
K   = 4/3; %Tabulando a casi 20
Re  = K*R0;
h1  = 235;
h2  = 312;
q   = 0.1;
Ptx = 2;

Ptx_dBm     = 10*log10(Ptx*1000);
G_dBi      = 24;
lambda     = c/f;
G_dB       = G_dBi-2.14;
R_001      = 32;% mm/Km
Umbral_dBm = -96;
Lt_dB = 2;
Alpha       = 1.0025; %Tabulando casi a 20 en PV
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

%Para Ldif(uve'1)
        Distancia_entre_obstaculos = Distancia_E1_O2-Distancia_E1_O1;

        flecha_A_prima         = Distancia_entre_obstaculos*Distancia_E1_O1/(2*Re);
        altura_rayo_A_prima    = ((h1-e_O2)*Distancia_entre_obstaculos/Distancia_E1_O2)+e_O2;
        Despejamiento_A_prima  = e_O1 + flecha_A_prima - altura_rayo_A_prima;

        R1_A_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O1/Distancia_E1_O2);
        Difracc_A_prima = sqrt(2)*(Despejamiento_A_prima/R1_A_prima);

        %Para Ldif(uve'2)
        flecha_2p             = Distancia_entre_obstaculos*Distancia_E2_O2/(2*Re);
        altura_rayo_B_prima   = ((h2-e_O1)*Distancia_entre_obstaculos/Distancia_E2_O1)+e_O1;
        Despejamiento_B_prima = e_O2 + flecha_2p - altura_rayo_B_prima;

        R1_B_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O2/Distancia_E2_O1);
        Difracc_B_prima = sqrt(2)*(Despejamiento_B_prima/R1_B_prima);
        
        Ldif_A_prima    = 6.9 + 20*log10(sqrt((Difracc_A_prima-0.1)^2+1)+Difracc_A_prima-0.1);
        Ldif_B_prima    = 6.9 + 20*log10(sqrt((Difracc_B_prima-0.1)^2+1)+Difracc_B_prima-0.1);
        
        Ldif_dB = Ldif_A_prima+Ldif_B_prima+10*log10((Distancia_E1_O2*Distancia_E2_O1)/(Distancia_entre_obstaculos*(Distancia_E1_O2+Distancia_E2_O1)))

 Lbf_dB  = 20*log10((4*pi*Distancia/lambda));        
 Distancia=35;f=18;K =0.0771;       
 
Lespecifica_lluvia = K *(R_001^Alpha)  % dB/Km

termino1 = 0.477*(Distancia^0.633)*(R_001^(0.073*Alpha))*(f^(0.123));
termino2 = 10.579*(1-exp(-0.024*Distancia));
Deff     = (Distancia)/(termino1-termino2) %Km

F_001    = Lespecifica_lluvia* Deff % dB
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

Fq_dB = F_001*C1*(q^(-(C2+C3*log10(q))));


Prx_dBm = Ptx_dBm + G_dB - Lt_dB - Lbf_dB - Fq_dB - Ldif_dB + G_dB - Lt_dB

%HORAS?¿