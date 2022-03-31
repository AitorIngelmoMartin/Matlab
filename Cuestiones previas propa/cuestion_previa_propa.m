clear;clc;close all;

c           = 3e8;
mu_vacio    = 1.2566370614e-6;

%  CUESTION 1 - Dimensiones en mm

    % En mm
    a_mm = 2.54*0.9*10;
    b_mm = 2.54*0.4*10;
%  CUESTION 2 - frecuecnias de corte

    % En M
    a = 2.54*0.9/100;
    b = 2.54*0.4/100;

    % Los tres primeros modos son TE10, TE20 y TE01
    
    fc_10 = frecuencia_corte(a,b,1,0)

    fc_20 = frecuencia_corte(a,b,2,0)
    
    fc_01 = frecuencia_corte(a,b,0,1)
    
%  CUESTION 4 - lambda_g, lambda_c, Kc, coefciciente_fase, Vfase, Vgrupo
%               si f es 25% superior a fc_10.

f10    = fc_10+(fc_10*(25/100))

lambda = c/f10;

% lambdaGrupo_10 = lambda/(sqrt(1 - (lambda/2*a)^2)) %HACER A MANO

lambda_Guia_10 = lambda/sqrt(1-(fc_10/f10)^2)

lambdaCorte_10 = (2*a)

Kcorte_10      = pi/a

% O velocidad de propagación
Vfase_dielectrico   = (2*pi*fc_10)/((2*pi)/lambdaCorte_10)

Vfase_10            = (lambda_Guia_10/lambda)*Vfase_dielectrico

Vgrupo_10           =  Vfase_dielectrico*sqrt(1-(fc_10/f10)^2)

Coeficiente_de_fase = ((2*pi*f10)/c)*sqrt(1-(fc_10/f10)^2)
% CUESTION 5 - sacar las impedancias de cada modo

f20 = fc_20+(fc_20*(25/100))
f01 = fc_01+(fc_01*(25/100))

Zte_10 = 120*pi/(sqrt ( 1- (fc_10/f10)^2))

Zte_20 = 120*pi/(sqrt ( 1- (fc_20/f20)^2))

Zte_01 = 120*pi/(sqrt ( 1- (fc_01/f01)^2))


% CUESTION 6 - coeficiente de atenuacion para TE10

% sigma_vacio = 1;
% Rs = sqrt((2*pi*f10*mu_vacio)/2*sigma_vacio)