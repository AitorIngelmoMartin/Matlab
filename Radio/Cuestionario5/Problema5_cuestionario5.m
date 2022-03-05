clear;close all;clc;

f  = 23e9;
c  = 3e8;
R0 = 6370000;
K  = 4/3;
h1 = 300;
h2 = 240;
lambda    = c/f;
Distancia = 38000;


%OBSTACULO A---------
Distancia_E1_O1 = 15000;
Distancia_E2_O1 = Distancia - Distancia_E1_O1;
e_O1            = 261;

Flecha_O1        = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

AlturaRayo_O1    = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

Despejamiento_O1 = Flecha_O1 + e_O1-AlturaRayo_O1;

Rfresnell_O1 = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1))

Difracc_O1   = sqrt(2)*(Despejamiento_O1/Rfresnell_O1)


%OBSTACULO B---------
Distancia_E1_O2  = 29000;
Distancia_E2_O2  = Distancia - Distancia_E1_O2;
e_O2             = 239;

Flecha_O2        = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

AlturaRayo_O2    = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

Despejamiento_O2 = Flecha_O2 + e_O2-AlturaRayo_O2;

Rfresnell_O2 = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

Difracc_O2   = sqrt(2)*(Despejamiento_O2/Rfresnell_O2);
%--------------------

if( ( (Difracc_O1<0) ||(Difracc_O2<0) ) && (abs(Difracc_O1 -Difracc_O2)<0.5) )
        "Método uno"
        
end

if( ( (Difracc_O1>0) && (Difracc_O2>0) ) && (abs(Difracc_O1 -Difracc_O2)>0.5) )
        "Método dos"
        
        Dentre_obs             = (29-15)*1000;

        Flecha_02_prima        = (Dentre_obs*Distancia_E2_O2)/(2*K*R0);

        e_O2_prima             = ((h2-e_O1)*Dentre_obs/Distancia_E2_O1)+e_O1;

        Despejamiento_O2_prima = Flecha_02_prima+e_O2-e_O2_prima;

        Rfresnell_O2_prima     = sqrt(lambda*((Dentre_obs*Distancia_E2_O2)/(Dentre_obs+Distancia_E2_O2)));

        Difracc_O2_prima       = sqrt(2)*(Despejamiento_O2_prima/Rfresnell_O2_prima);

        Alpha         = atan(((Distancia*Dentre_obs)/(Distancia_E1_O1*Distancia_E2_O2))^(1/2));

        Ldif_V1       = 6.9 + 20*log10(sqrt( (Difracc_O1      -0.1)^2 +1) + Difracc_O1      -0.1);
        Ldif_V2_prima = 6.9 + 20*log10(sqrt(((Difracc_O2_prima-0.1)^2)+1) + Difracc_O2_prima-0.1);

        Tc            =(12 - 20*log10(2/(1 - (Alpha/pi))))*((Difracc_O2/Difracc_O1)^(2*Difracc_O1));

        Lad=Ldif_V1+Ldif_V2_prima-Tc
end










