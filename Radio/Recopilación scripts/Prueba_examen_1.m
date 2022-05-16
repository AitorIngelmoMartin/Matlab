% Se establece un enlace radio punto a punto desde el emplazamiento A con cota de 252m al emplazamiento B cota de 855m. 
% Las alturas de las antenas son iguales a 40m, en el estacionamiento A, y 36, en el emplazamiento B. 

% Por un error en la instalación, las antenas se han orientado perfectamente en azimut pero con una elevación 
% paralela a la horizontal (ángulo de elevación, en ambos emplazamientos, 0°). 

% El terreno presenta dos obstáculos agudos: 
% O1: de cota 396m a 3km de la estación A 
% O2: de cota 642m a 10km de la estación A 

% La frecuencia de trabajo es de 25GHz y la distancia total del enlace son 17km. 
% Las pérdidas de los terminales 1,5 dB y la ganancia de la antena con polarización vertical
% en azimut y elevación se ofrece en la figura adjunta. 

% Determinar: a) La potencia transmitida necesaria para una configuración basada en un atenuador variable 
% que garantiza una indisponibilidad por desvanecimientos por lluvia de 0,05% 
% y un receptor con un nivel de sensibilidad de -107 dBm.



% b) El flujo de potencia parásito con polarización horizontal en condiciones de máximo desvanecimiento 
% permitido por el atenuador variable Datos R0,01=26mm/h; K=4/3 (atmósfera estándar); R=6370 kmTexto de una sola línea


clc;clear;close all;
h1 = 292;
h2 = 891;
f  = 25e9;
c  = 3e8;

lambda    = c/f;
Distancia = 17e3;
Lt_dB     = 1.5;

K  = 4/3;
R0 = 6370000;
Re = K*R0

%OBSTACULO A---------
Distancia_E1_O1 = 3e3;
Distancia_E2_O1 = Distancia - Distancia_E1_O1;
e_O1            = 396;

Flecha_O1        = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

AlturaRayo_O1    = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

Despejamiento_O1 = Flecha_O1 + e_O1-AlturaRayo_O1;

Rfresnell_O1 = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1));

Difracc_O1   = sqrt(2)*(Despejamiento_O1/Rfresnell_O1)


%OBSTACULO B---------
Distancia_E1_O2  = 10e3;
Distancia_E2_O2  = Distancia - Distancia_E1_O2;
e_O2             = 642;

Flecha_O2        = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

AlturaRayo_O2    = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

Despejamiento_O2 = Flecha_O2 + e_O2-AlturaRayo_O2;

Rfresnell_O2 = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

Difracc_O2   = sqrt(2)*(Despejamiento_O2/Rfresnell_O2)
%--------------------

if( (((Difracc_O1<0) ||(Difracc_O2<0) ) && (abs(Difracc_O1 -Difracc_O2)<0.5)) || (((Difracc_O1>0) && (Difracc_O2>0) ) && (abs(Difracc_O1 -Difracc_O2)<0.5)) )
    "Método uno"        
        %Para Ldif(uve'1)
        Distancia_entre_obstaculos = Distancia_E1_O2-Distancia_E1_O1;

        flecha_A_prima         = Distancia_entre_obstaculos*Distancia_E1_O1/(2*Re);
        altura_rayo_A_prima    = ((h1-e_O2)*Distancia_entre_obstaculos/Distancia_E1_O2)+e_O2;
        Despejamiento_A_prima  = e_O1 + flecha_A_prima - altura_rayo_A_prima;

        R1_A_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E1_O1/Distancia_E1_O2);
        Difracc_A_prima = sqrt(2)*(Despejamiento_A_prima/R1_A_prima);

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