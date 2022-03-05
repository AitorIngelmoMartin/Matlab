clear;close all;clc;

% **************** DOS OBSTÁCULOS *****************
f  = 38e9;
c  = 3e8;
R0 = 6370000;
K  = 4/3;

lambda= c/f;

h1 = 332;
h2 = 328;
Distancia = 40000;

G_dB    = 23;
Ptx_dBm = 35;
Lt_dB = 2;
% -------------------------------------------------------------------------

Dmax = sqrt((K*R0+h1)^2 - (K*R0)^2)+sqrt((K*R0+h2)^2 - (K*R0)^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

% -------------------------------------------------------------------------

%OBSTACULO A---------
Distancia_E1_O1 = 9500;
Distancia_E2_O1 = Distancia - Distancia_E1_O1;
e_O1  = 311;

Flecha_A = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);



AlturaRayo_A = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

Despejamiento_A = Flecha_A + e_O1-AlturaRayo_A;

Rfresnell_A = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1))

Difracc_A   = sqrt(2)*(Despejamiento_A/Rfresnell_A)

%--------------------

%OBSTACULO B---------
Distancia_E1_O2  = 26000;
Distancia_E2_O2  = Distancia - Distancia_E1_O2;
e_O2   = 306;

Flecha_B = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

AlturaRayo_B = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

Despejamiento_B = Flecha_B + e_O2 - AlturaRayo_B;

Rfresnell_B = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2))

Difracc_B   = sqrt(2)*(Despejamiento_B/Rfresnell_B)
%--------------------



% ----------------------Pérdidas adicionales---------------------------
if( ( (Difracc_A<0) ||(Difracc_B<0) ) && (abs(Difracc_A -Difracc_B)<0.5) )
        "Método uno"
        
end

if( ( (Difracc_A>0) && (Difracc_B>0) ) && (abs(Difracc_A -Difracc_B)>0.5) )
        "Método dos"
end

% Ldif1 = 6.9 + 20*log10(sqrt( (Difracc_A -0.1)^2 +1) + Difracc_A -0.1)
% 
% 
% h1 = e_O1;
% Dentre_obs = 29-15;
% 
% Rfresnell_B = sqrt((lambda*Dentre_obs*Distancia_E2_O2)/(Dentre_obs+Distancia_E2_O2))
% 
% Difracc_B   = sqrt(2)*(Despejamiento_B/Rfresnell_B)
% 
% Ldif1 = 6.9 + 20*log10(sqrt( (Difracc_B -0.1)^2 +1) + Difracc_B -0.1)
Ldif_dB = 0;
%--------------------

% ------------------ Valance de potencias ---------------------------

Lbf_dB = 20*log10((4*pi*Distancia*Distancia)/lambda);

Prx_dBm = Ptx_dBm +G_dB -Lt_dB -Lbf_dB - Ldif_dB +G_dB - Lt_dB;
