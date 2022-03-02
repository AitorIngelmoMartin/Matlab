clc;clear;close all;
f = 2500000000;
c=3e8;
lambda= c/f;
Lt_dB = 3;
Lt    = 10^(Lt_dB/10);

% Alturas, distancia y radio en metros
h1 = 8;
h2 = 22;
Distancia = 13000;
R0 =6370000;
Gmax_dB = 34;
Gmax = 10^(Gmax_dB/10);
Re = -0.8628;%Coeficiente de reflexion efectivo


% -----------------------------------------------------------------

K = 4/3;
termino1 = K*R0+h1;
termino2= K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;
Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

% -----------------------------------------------------------------

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

Phi = atan(H1/d1);
Phi_lim = (1/1000)*(5400/(f/1000))^(1/3);
% -----------------------------------------------------------------


if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"    
    %Como suelo liso, no hay la exponencial de la rugosidad.
        Raiz1       = sqrt( Distancia*Distancia + abs(H1+H2)^2 );
        Raiz2       = sqrt( Distancia*Distancia + abs(H1-H2)^2 );
        Dcaminos    = Raiz1 - Raiz2;
        Divergencia = ( 1 + (5*(d1/1000*d1/1000*d2/1000)/(16*K*(Distancia/1000)*H1)) )^(-0.5);
        Refectivo   = Re*Divergencia;
        exponente   = (-1i*(((2*pi)/lambda))*Dcaminos);
        Lref_dB     = -20*log10(norm( 1 + (Refectivo*exp(exponente)) )) ;

else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
end
% -------------------------------------------------------------------------

e_rx_dBu = 71.2;
e_V = (10^(e_rx_dBu/20))/1000000

flujo = (e_V*e_V)/(120*pi)
PIRE = flujo*(4*pi*Distancia*Distancia)

Ptx_w = (PIRE*Lt)/Gmax

Lbf_dB = 20*log10((4*pi*Distancia)/lambda);

Lad_dB = Lbf_dB + Lref_dB;
Lad    = 10^(Lad_dB/10);



% PIRE_dB = Prx
% Prx_W = PIRE - Lbf_dB + Gmax_dB - Lt_dB








