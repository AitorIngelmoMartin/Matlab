clear;close all;clc;

f = 5e9;
c=3e8;
lambda= c/f;
Lt_dB = 3;

% Alturas, distancia y radio en metros
Prx_min_dBm =-80;
Ptx_dBw = -15;
G_dB = 27;
Epsilon_relativa = 15;
Conductividad=0.001;
Polarizacion = "horizontal";
h1 = 9;
h2 = 4;
Distancia = 21000;
R0 =6370000;
Gmax_dB = 34;
Epsilon0 = -0.8628;%Coeficiente de reflexion efectivo


% -------------------------------------------------------------------------
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
% -------------------------------------------------------------------------


P = (2/3^0.5)*(((K*R0*(h1+h2)+(Distancia^2)/4)))^0.5; 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*Distancia)/P^3);
    d1 = Distancia/2+P*cos((pi+Thau)/3)*(1/1000);
    d2=Distancia-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*Distancia)/P^3);
    d2 = Distancia/2+P*cos((pi+Thau)/3)*(1/1000);
    d1=Distancia-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi = atan(H1/d1);
Phi_lim = (1/1000)*(5400/(f/1000))^(1/3);

numerador   = sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
denominator = sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
Rh =numerador/denominator;
% Programar para que vaya solito por PH/PV


if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"
    
        Dcaminos =sqrt( Distancia*Distancia + abs(H1+H2)^2 ) - sqrt( Distancia*Distancia + abs(H1-H2)^2 );
        
        Divergencia = ( 1 + (5*(d1/1000*d1/1000*d2/1000)/(16*K*(Distancia/1000)*H1)) )^(-0.5);
        Refectivo = Rh*Divergencia;
        exponente = (-1i*(((2*pi)/lambda))*Dcaminos);
        Lref_dB   = -20*log10(norm( 1 + (Refectivo*exp(exponente)) ))     
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
end

% -------------------------------------------------------------------------

PIRE_dBw = Ptx_dBw + G_dB
Lbf_dB = 20*log10((4*pi*Distancia*Distancia)/lambda)
Lad_dB =Lbf_dB + Lref_dB;
Prx_dBw = PIRE_dBw - Lad_dB + G_dB

Prx_W = 10^(Prx_dBw/10);
Prx_necesaria_w = (1/1000)*10^(-80/10);
Prx_necesaria_dBw = 10*log10(Prx_necesaria_w)
Prx_mW = Prx_W*1000;
Prx_dBm = 10*log10(Prx_mW);

if(Prx_W<Prx_necesaria_w)
    "No es viable"
end

