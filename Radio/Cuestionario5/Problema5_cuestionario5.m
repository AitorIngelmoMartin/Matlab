clear;close all;clc;


f = 23e9;
c=3e8;
lambda= c/f;
R0 =6370000;
K = 4/3;


h1 = 300;
h2 = 240;
Distancia = 38000;

% -------------------------------------------------------------------------

termino1 = K*R0+h1;termino2= K*R0;termino3 = K*R0+h2;termino4 = K*R0;
Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

% -------------------------------------------------------------------------

%OBSTACULO A---------
DobsA_1 = 15000;
DobsA_2 = Distancia - DobsA_1;
e_A  = 261;


Flecha_A = (DobsA_1*DobsA_2)/(2*K*R0);

AlturaRayo_A = ((h2-h1)/Distancia)*DobsA_1 + h1;

Despejamiento_A = Flecha_A + e_A-AlturaRayo_A;

Rfresnell_A = sqrt((lambda*DobsA_1*DobsA_2)/(DobsA_1+DobsA_2))

Difracc_A   = sqrt(2)*(Despejamiento_A/Rfresnell_A)

%--------------------

%OBSTACULO B---------
DobsB_1  = 29000;
DobsB_2  = Distancia - DobsB_1;
e_B   = 239;

Flecha_B = (DobsB_1*DobsB_2)/(2*K*R0);

AlturaRayo_B = ((h2-h1)/Distancia)*DobsB_1 + h1;

Despejamiento_B = Flecha_B + e_B-AlturaRayo_B;

Rfresnell_B = sqrt((lambda*DobsB_1*DobsB_2)/(DobsB_1+DobsB_2))

Difracc_B   = sqrt(2)*(Despejamiento_B/Rfresnell_B)
%--------------------
if( ( (Difracc_A<0) ||(Difracc_B<0) ) && (abs(Difracc_A -Difracc_B)<0.5) )
        "Método uno"
        
end

if( ( (Difracc_A>0) && (Difracc_B>0) ) && (abs(Difracc_A -Difracc_B)>0.5) )
        "Método dos"
end


Ldif1 = 6.9 + 20*log10(sqrt( (Difracc_A -0.1)^2 +1) + Difracc_A -0.1)


h1 = e_A;
Dentre_obs = 29-15;

Rfresnell_B = sqrt((lambda*Dentre_obs*DobsB_2)/(Dentre_obs+DobsB_2))

Difracc_B   = sqrt(2)*(Despejamiento_B/Rfresnell_B)

Ldif1 = 6.9 + 20*log10(sqrt( (Difracc_B -0.1)^2 +1) + Difracc_B -0.1)




