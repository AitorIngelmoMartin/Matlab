clear;close all;clc;

% **************** DOS OBSTÁCULOS *****************
f  = 38e9;
c  = 3e8;
R0 = 6370000;
K  = 4/3;
Re = K*R0;
lambda= c/f;

h1 = 332;
h2 = 328;
Distancia = 40000;

G_dB    = 23;
Ptx_dBm = 35;
Lt_dB = 2;

%OBSTACULO A---------
Distancia_E1_O1 = 9500;
Distancia_E2_O1 = Distancia - Distancia_E1_O1;
e_O1            = 311;

Flecha_A        = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

AlturaRayo_A    = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

Despejamiento_A = Flecha_A + e_O1-AlturaRayo_A;

Rfresnell_A     = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1));

Difracc_A       = sqrt(2)*(Despejamiento_A/Rfresnell_A);


%OBSTACULO B---------
Distancia_E1_O2  = 26000;
Distancia_E2_O2  = Distancia - Distancia_E1_O2;
e_O2   = 306;

Flecha_B = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

AlturaRayo_B = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

Despejamiento_B = Flecha_B + e_O2 - AlturaRayo_B;

Rfresnell_B = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

Difracc_B   = sqrt(2)*(Despejamiento_B/Rfresnell_B);
%--------------------

% ----------------------Pérdidas adicionales---------------------------
if( ( (Difracc_A<0) ||(Difracc_B<0) ) && (abs(Difracc_A -Difracc_B)<0.5) )
        "Método uno"
        
        %Para Ldif(uve'1)
        Distancia_entre_obstaculos = Distancia_E1_O2-Distancia_E1_O1; %distancia entre obstaculos

        flecha_A_prima = Distancia_entre_obstaculos*Distancia_E1_O1/(2*Re);
        altura_rayo_A_prima = ((h1-e_O2)*Distancia_entre_obstaculos/Distancia_E1_O2)+e_O2;
        despejamiento_A_primap = e_O1 + flecha_A_prima - altura_rayo_A_prima;

        R1_A_prima = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O1/Distancia_E1_O2); %Altura del primer rayo de Fresnel
        uve_1p = sqrt(2)*(despejamiento_A_primap/R1_A_prima);
        
%       R1_1p = sqrt(lambda*do1_o2*d1(2)/d1(3)); %Altura del primer rayo de Fresnel
%         uve_1p = sqrt(2)*(despejamiento_1p/R1_1p);
% 
%         Ldif_p1_dB = 6.9 + 20*log10(sqrt((uve_1p-0.1)^2+1)+uve_1p-0.1);
% 
% 
        Ldif_A_prima = 6.9 + 20*log10(sqrt((uve_1p-0.1)^2+1)+uve_1p-0.1)

        %Para Ldif(uve'2)
        flecha_2p = Distancia_entre_obstaculos*Distancia_E2_O2/(2*Re);
        altura_rayo_2p = ((h2-e_O1)*Distancia_entre_obstaculos/Distancia_E2_O1)+e_O1;
        despejamiento_2p = e_O2 + flecha_2p - altura_rayo_2p;

        R1_2p = sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O2/Distancia_E2_O1); %Altura del primer rayo de Fresnel
        uve_2p = sqrt(2)*(despejamiento_2p/R1_2p);

        Ldif_B_prima = 6.9 + 20*log10(sqrt((uve_2p-0.1)^2+1)+uve_2p-0.1)
        
        Ldif_dB = Ldif_A_prima+Ldif_B_prima+10*log10((Distancia_E1_O2*Distancia_E2_O1)/(Distancia_entre_obstaculos*(Distancia_E1_O2+Distancia_E2_O1))) %Perdidas adicionales
%         Ldif_dB = -31.1487;
end

if( ( (Difracc_A>0) && (Difracc_B>0) ) && (abs(Difracc_A -Difracc_B)>0.5) )
        "Método dos"
end


% ------------------ Valance de potencias ---------------------------

Lbf_dB = 20*log10((4*pi*Distancia/lambda))

Prx_dBm = Ptx_dBm +G_dB -Lt_dB -Lbf_dB - Ldif_dB +G_dB - Lt_dB
