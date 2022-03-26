clear;close all;clc;

f = 25e9;
c = 3e8;
lambda    = c/f;
Distancia = 17e3;

R0      = 6370000;
Lt_dB   = 1.5;
G_PH_dB = 35;
R001    = 26;
CAG_dB  = 15;
h1      = 292;
h2      = 913;
K       = 4/3;

% A con cota de 252m 
% B cota de 855m. 
% Las altura de A es igual a 40m. 
 
% O1: de cota 396m a 3km de la estación A
% O2: de cota 642m a 10km de la estación A


  
    %OBSTACULO A---------
    Distancia_E1_O1 = 3000;
    Distancia_E2_O1 = Distancia - Distancia_E1_O1;
    e_O1            = 396;

    Flecha_A        = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

    AlturaRayo_A    = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

    Despejamiento_A = Flecha_A + e_O1-AlturaRayo_A;

    Rfresnell_A     = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1));

    Difracc_A       = sqrt(2)*(Despejamiento_A/Rfresnell_A);

    %OBSTACULO B---------
    Distancia_E1_O2  = 10000;
    Distancia_E2_O2  = Distancia - Distancia_E1_O2;
    e_O2             = 642;

    Flecha_B        = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

    AlturaRayo_B    = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

    Despejamiento_B = Flecha_B + e_O2 - AlturaRayo_B;

    Rfresnell_B     = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

    Difracc_B       = sqrt(2)*(Despejamiento_B/Rfresnell_B);


% ----------------------Pérdidas adicionales---------------------------
if( ( (Difracc_A<0) ||(Difracc_B<0) ) && (abs(Difracc_A -Difracc_B)<0.5) )
        "Método uno"
%         
%         %Para Ldif(uve'1)
%         Distancia_entre_obstaculos = Distancia_E1_O2-Distancia_E1_O1;
% 
%         flecha_A_prima         = Distancia_entre_obstaculos*Distancia_E1_O1/(2*Re);
%         altura_rayo_A_prima    = ((h1-e_O2)*Distancia_entre_obstaculos/Distancia_E1_O2)+e_O2;
%         Despejamiento_A_prima  = e_O1 + flecha_A_prima - altura_rayo_A_prima;
% 
%         R1_A_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O1/Distancia_E1_O2);
%         Difracc_A_prima = sqrt(2)*(Despejamiento_A_prima/R1_A_prima);
% 
%         %Para Ldif(uve'2)
%         flecha_2p             = Distancia_entre_obstaculos*Distancia_E2_O2/(2*Re);
%         altura_rayo_B_prima   = ((h2-e_O1)*Distancia_entre_obstaculos/Distancia_E2_O1)+e_O1;
%         Despejamiento_B_prima = e_O2 + flecha_2p - altura_rayo_B_prima;
% 
%         R1_B_prima      = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O2/Distancia_E2_O1);
%         Difracc_B_prima = sqrt(2)*(Despejamiento_B_prima/R1_B_prima);
%         
%         Ldif_A_prima    = 6.9 + 20*log10(sqrt((Difracc_A_prima-0.1)^2+1)+Difracc_A_prima-0.1);
%         Ldif_B_prima    = 6.9 + 20*log10(sqrt((Difracc_B_prima-0.1)^2+1)+Difracc_B_prima-0.1);
%         
%         Ldif_dB = Ldif_A_prima+Ldif_B_prima+10*log10((Distancia_E1_O2*Distancia_E2_O1)/(Distancia_entre_obstaculos*(Distancia_E1_O2+Distancia_E2_O1)));
end

if( ( (Difracc_A>0) && (Difracc_B>0) ) && (abs(Difracc_A -Difracc_B)>0.5) )
        "Método dos"
end


% Tras lo terminales, el receptor presenta un figura de ruido de 8dB.
% Además, el receptor cuenta con un CAG como mecanismo de protección frente a desvanecimientos de 15dB. R0,01=26mm/h

% Determinar:
% a)	La altura mínima que tiene que tener la antena de la estación B para evitar pérdidas por difracción. 
% b)	Si el flujo de potencia recibido en condiciones normales de propagación es de -94dBW/m^2, determinar la CN0R en condiciones normales.
% c)    Calcular el campo parásito que aparece en condiciones de máximo desvanecim