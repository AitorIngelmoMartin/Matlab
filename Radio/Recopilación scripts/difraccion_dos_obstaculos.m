clc;clear;close all

K = 2/3;
f =2.3e9;
c =3e8;
lambda=c/f;
R0 = 6370000;
Distancia = 20.09e3;
Re = K*R0;
h1 = 796+17;
h2 = 805+12;

%OBSTACULO A---------
Distancia_E1_O1 = 1.910e3;
Distancia_E2_O1 = Distancia - Distancia_E1_O1;
e_O1            = 803;

Flecha_O1       = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

AlturaRayo_O1   = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

Despejamiento_O1= Flecha_O1 + e_O1-AlturaRayo_O1;

Rfresnell_O1 = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1))

Difracc_O1   = sqrt(2)*(Despejamiento_O1/Rfresnell_O1)


%OBSTACULO B---------
Distancia_E1_O2  = 3.721e3;
Distancia_E2_O2  = Distancia - Distancia_E1_O2;
e_O2             = 799;

Flecha_O2        = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

AlturaRayo_O2    = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

Despejamiento_O2 = Flecha_O2 + e_O2-AlturaRayo_O2;

Rfresnell_O2 = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

Difracc_O2   = sqrt(2)*(Despejamiento_O2/Rfresnell_O2);
%--------------------

if( (((Difracc_O1<0) ||(Difracc_O2<0) ) && (abs(Difracc_O1 -Difracc_O2)<0.5)) || (((Difracc_O1>0) && (Difracc_O2>0) ) && (abs(Difracc_O1 -Difracc_O2)<0.5)) )    "Método uno"        
        %Para Ldif(uve'1)
        Distancia_entre_obstaculos = Distancia_E1_O2-Distancia_E1_O1;

        flecha_A_prima         = Distancia_entre_obstaculos*Distancia_E1_O1/(2*Re);
        altura_rayo_A_prima    = ((h1-e_O2)*Distancia_entre_obstaculos/Distancia_E1_O2)+e_O2;
        Despejamiento_A_prima  = e_O1 + flecha_A_prima - altura_rayo_A_prima;

        R1_A_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O1/Distancia_E1_O2);
        Difracc_A_prima = sqrt(2)*(Despejamiento_A_prima/R1_A_prima);
% R1_A_prima= sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O1/Distancia_E1_O2);
        %Para Ldif(uve'2)
        flecha_2p             = Distancia_entre_obstaculos*Distancia_E2_O2/(2*Re);
        altura_rayo_B_prima   = ((h2-e_O1)*Distancia_entre_obstaculos/Distancia_E2_O1)+e_O1;
        Despejamiento_B_prima = e_O2 + flecha_2p - altura_rayo_B_prima;

        R1_B_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O2/Distancia_E2_O1);
        Difracc_B_prima = sqrt(2)*(Despejamiento_B_prima/R1_B_prima);
        
        Ldif_A_prima    = 6.9 + 20*log10(sqrt((Difracc_A_prima-0.1)^2+1)+Difracc_A_prima-0.1);
        Ldif_B_prima    = 6.9 + 20*log10(sqrt((Difracc_B_prima-0.1)^2+1)+Difracc_B_prima-0.1);
        
        Ldif_dB = Ldif_A_prima+Ldif_B_prima+10*log10((Distancia_E1_O2*Distancia_E2_O1)/(Distancia_entre_obstaculos*(Distancia_E1_O2+Distancia_E2_O2)))
end

if( ( (Difracc_O1>0) && (Difracc_O2>0) ) && (abs(Difracc_O1 -Difracc_O2)>0.5) )
     "Método dos"
        
        Dentre_obs             = Distancia_E1_O2-Distancia_E1_O1;

        Flecha_02_prima        = (Dentre_obs*Distancia_E2_O2)/(2*Re);

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

if(Difracc_O2<-0.78 && Difracc_O1>-0.78)
    Ldif_01       = 6.9 + 20*log10(sqrt( (Difracc_O1      -0.1)^2 +1) + Difracc_O1      -0.1)
end

if(Difracc_O1<-0.78 && Difracc_O2>-0.78)
    Ldif_02       = 6.9 + 20*log10(sqrt( (Difracc_O2      -0.1)^2 +1) + Difracc_O2      -0.1)
end

if(Difracc_O2<-0.78 && Difracc_O1<-0.78)
   "Los obstáculos no afectan" 
end