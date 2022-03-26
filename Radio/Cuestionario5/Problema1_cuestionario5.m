clc;clear;close all;
f = 2.5e9;
c=3e8;
lambda= c/f;
Lt_dB = 3;
Lt    = 10^(Lt_dB/10);

% Alturas, distancia y radio en metros
h1 = 8;
h2 = 22;
Distancia = 13000;
R0 =6370000;
Gmax_dB = 34-13;
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
        Dcaminos    = sqrt( Distancia*Distancia + abs(H1+H2)^2 ) - sqrt( Distancia*Distancia + abs(H1-H2)^2 );
        Refectivo   = Re;
        exponente   = (-1i*(((2*pi)/lambda))*Dcaminos);
        Lref_dB     = -20*log10(norm( 1 + (Refectivo*exp(exponente)) )) ;
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
end
% -------------------------------------------------------------------------
Lbf_dB = 20*log10((4*pi*Distancia)/lambda);
Lad_dB = Lref_dB;
Lad    = 10^(Lad_dB/10);

e_rx_dBu = 71.2;

PIRE_W   = (((10^(e_rx_dBu/20))*1e-6)^2*Distancia*Distancia*10^(Lad_dB/10))/30;

PIRE_dbW = 10*log10(PIRE_W);

Ptx_dBW  = PIRE_dbW - Gmax_dB + Lt_dB 