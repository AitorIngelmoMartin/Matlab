clear;close all;clc;

f = 25e9;
c = 3e8;
lambda     = c/f;
Distancia  = 17e3;
alfa_gases = 1.5;
R0      = 6370000;
Lt_dB   = 1.5;
G_PH_dB = 35;

R001    = 26;
CAG_dB  = 15;
h1      = 292;
h2      = 855;
K       = 4/3;

Difracc_A = 0;
Difracc_B = 0;

    %OBSTACULO A---------
    Distancia_E1_O1  = 3000;
    Distancia_E2_O1  = Distancia - Distancia_E1_O1;
    e_O1             = 396;
    %OBSTACULO B---------
    Distancia_E1_O2  = 10000;
    Distancia_E2_O2  = Distancia - Distancia_E1_O2;
    e_O2             = 642;
    

while( (Difracc_A >= -0.78) || (Difracc_B >= -0.78) )
    h2 = h2+1

    Flecha_A        = (Distancia_E1_O1*Distancia_E2_O1)/(2*K*R0);

    AlturaRayo_A    = ((h2-h1)/Distancia)*Distancia_E1_O1 + h1;

    Despejamiento_A = Flecha_A + e_O1-AlturaRayo_A;

    Rfresnell_A     = sqrt((lambda*Distancia_E1_O1*Distancia_E2_O1)/(Distancia_E1_O1+Distancia_E2_O1));

    Difracc_A       = sqrt(2)*(Despejamiento_A/Rfresnell_A);


    Flecha_B        = (Distancia_E1_O2*Distancia_E2_O2)/(2*K*R0);

    AlturaRayo_B    = ((h2-h1)/Distancia)*Distancia_E1_O2 + h1;

    Despejamiento_B = Flecha_B + e_O2 - AlturaRayo_B;

    Rfresnell_B     = sqrt((lambda*Distancia_E1_O2*Distancia_E2_O2)/(Distancia_E1_O2+Distancia_E2_O2));

    Difracc_B       = sqrt(2)*(Despejamiento_B/Rfresnell_B);
end

Lbf_dB    = 20*log10((4*pi*Distancia)/lambda)
Lgases_dB = alfa_gases*Distancia/1000;
Lad_dB    = Lgases_dB
Flujo_dBw = -94; %dBw/m^2
Flujo_W   = 10^(Flujo_dBw/10);
PIRE_W_rx    = Flujo_W * 4*pi*Distancia*Distancia
PIRE_dBw_rx  = 10*log10(PIRE_W)
Prx_dBw   = PIRE_dBw -Lbf_dB - Lad_dB + G_PH_dB - Lt_dB

% Tras lo terminales, el receptor presenta un figura de ruido de 8dB.
% Además, el receptor cuenta con un CAG como mecanismo de protección frente a desvanecimientos de 15dB. R0,01=26mm/h

% Determinar:
% a)	La altura mínima que tiene que tener la antena de la estación B para evitar pérdidas por difracción. 

% b)	Si el flujo de potencia recibido en condiciones normales de propagación es de -94dBW/m^2, determinar la CN0R en condiciones normales.


% c)    Calcular el campo parásito que aparece en condiciones de máximo desvanecimiento