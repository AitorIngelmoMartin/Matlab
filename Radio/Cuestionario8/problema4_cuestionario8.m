clear;close all;clc;



% Estación receptora con LNA de figura de ruido de 6dB y ganancia 20dB, un mezclador con pérdidas 12dB y 
% un amplificador en frecuencia intermedia con figura de ruido de 14dB. 
% Este último amplificador cuenta con un control automático de potencia que permite amplificar hasta 20dB. 
% El requisito de Eb/N0 es de 16dB para un filtro ideal. El MTTR es de 4 horas y el MTBF de 468.000 horas. 

% Determinar la PIRE y la indisponibilidad del enlace.

f  = 18e9;
c  = 3e8;
R0 = 6370000;
lambda    = c/f;
Distancia = 21000; % Km
Simbolos  = 64;
roll_off  = 0.3;
Rb_bps    = 64e6;
alfa_gas  = 4; %dB/Km

Conductividad         = 0.001;
Permeavilidad_terreno = 15;
Rugosidad = 0.2;
G_dB = 9;
h1 =210;
h2 =54;

K = 4/3;
Eb_N0_dB = 16;
MTTR     = 4;

MTBF  = 468000
R_001 = 33;

Ptx_dBm = 14;
Lt_dB   = 2;
Lt      = 10^(Lt_dB/10)
T0      = 290;
Re = K*R0
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lgases_dB = alfa_gas*Distancia/1000;

termino1 = K*R0+h1;
termino2 = K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;
Dmax     = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    Caso = "Tierra plana"
else
    %Código ejecutado si tierra curva
    Caso = "Tierra curva"
end


P = (2/3^0.5)*(((K*R0*(h1+h2)+(Distancia^2)/4)))^0.5; 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*Distancia)/P^3);
    d1 = Distancia/2+P*cos((pi+Thau)/3);
    d2=Distancia-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*Distancia)/P^3);
    d2 = Distancia/2+P*cos((pi+Thau)/3);
    d1=Distancia-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi = atan(H1/d1)*1000;
Phi_lim = (5400/(f/1e6))^(1/3);

Epsilon0    = Permeavilidad_terreno -1i*60*Conductividad*lambda;
numerador   = sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
denominator = sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));

Rh =numerador/denominator;

if(Phi>=Phi_lim)
   Dcaminos    = sqrt( Distancia*Distancia + abs(H1+H2)^2 ) - sqrt( Distancia*Distancia + abs(H1-H2)^2 );        
   Divergencia = ( 1 + (5*(d1/1000*d1/1000*d2/1000)/(16*K*(Distancia/1000)*H1)) )^(-0.5)
   Refectivo   = Rh*Divergencia*exp(-((Rugosidad*Rugosidad)/2))
   exponente   = (-1i*(((2*pi)/lambda))*Dcaminos);
   Lref_dB     = -20*log10(norm( 1 + (Refectivo*exp(exponente)) ))     

else
 %Código ejecutado si hay difracción -> MDTE
   "Hay pérdidas por difracción"
end
Lb_dB     = Lgases_dB + Lref_dB;
% *-*-*-*-*-*-*-

% PH
Gamma_PH = K *(R_001^Alpha)  % dB/Km

termino1 = 0.477*(Distancia^0.633)*(R_001^(0.073*Alpha_PH))*(f^(0.123));
termino2 = 10.579*(1-exp(-0.024*Distancia));
Deff     = (Distancia)/(termino1-termino2) %Km

F_001_PH    =   Gamma_PH * Deff % dB
% Almenos en una hora al año, la lluvia va a probocar una atenuación
% mayor que F_001 en dB.

if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

% *-*-*-*-*-*-*
PIRE_dBm = Ptx_dBm  + G_dB - Lt_dB
Prx_dBm  = PIRE_dBm + G_dB - Lb_dB - Lt_dB -Lbf_dB

%  LNA con una figura de ruido de 6dB y ganancia 20dB, 
%  un mezclador con pérdidas 12dB 
%  amplificador en frecuencia intermedia con figura de ruido de 14dB que permite amplificar hasta 20dB. 


% El requisito de Eb/N0 es de 16dB para un filtro ideal. El MTTR es de 4 horas y el MTBF de 468.000 horas.