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

Ptx_dB     = 10*log10(Ptx);
G_dBi      = 24;
lambda     = c/f;
G_dB       = 27;
R_001      = 32;% mm/Km
Umbral_dBm = -96;

Alpha       = 1; %Tabulando casi a 20 en PV
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

if( ( (Difracc_O1<0) ||(Difracc_O2<0) ) && (abs(Difracc_O1 -Difracc_O2)<0.5) )
        "Método uno"
        
end

if( ( (Difracc_O1>0) && (Difracc_O2>0) ) && (abs(Difracc_O1 -Difracc_O2)>0.5) )
        "Método dos"
end


% Distancia  = 35; % En Km
% f       = f/(1e9);