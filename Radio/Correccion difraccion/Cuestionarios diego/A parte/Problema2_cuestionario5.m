clear;clc;

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
d = 21e3;
R0 =6370e3;
Gmax_dB = 34;
Epsilon0=Epsilon_relativa-1i*60*Conductividad*lambda;

% -------------------------------------------------------------------------
k = 4/3;
Re = R0*k;
dmax = sqrt(2*Re)*(sqrt(h1)+sqrt(h2)); 

if(d<0.1*dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end
% -------------------------------------------------------------------------


p = (2/3^0.5)*(((k*R0*(h1+h2)+(d^2)/4)))^0.5; 

if(h1>h2)
    theta = acos((2*k*R0*(h1-h2)*d)/p^3);
    d1 = d/2+p*cos((pi+theta)/3)*(1/1000);
    d2=d-d1;
else
    theta = acos((2*k*R0*(h2-h1)*d)/p^3);
    d2 = d/2+p*cos((pi+theta)/3)*(1/1000);
    d1=d-d2;
end

hp2 = h2 - (d2^2)/(2*k*R0);
hp1 = h1 - (d1^2)/(2*k*R0);

Phi = atan(hp1/d1);
Phi_lim = (1/1000)*(5400/(f/1000))^(1/3);

%Polarización Horizontal

numerador   = sin(Phi) - sqrt(Epsilon0-(cos(Phi)^2));
denominador = sin(Phi) + sqrt(Epsilon0-(cos(Phi)^2));
Rh =numerador/denominador;

%Polarizaciín Vertical

% numerador   = Epsilon0*sin(Phi) - sqrt(Epsilon0-(cos(Phi)^2));
% denominador = Epsilon0*sin(Phi) + sqrt(Epsilon0-(cos(Phi)*^2));
% Rv =numerador/denominador;


if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"
    
        dif_caminos =sqrt( d^2 + abs(hp1+hp2)^2 ) - sqrt( d^2 + (hp1-hp2)^2 );
        
        Divergencia = ( 1 + (5*(d1/1000)^2*d2/1000)/(16*k*(d/1000)*hp1))^(-0.5);
        R_efectivo = Rh*Divergencia; %terreno liso: gamma <0,3 (exp(-gamma^2/2))=1;
        %gamma = r*pi*rho*sin(Phi)/lambda;
        exponente = (-1i*2*pi*dif_caminos/lambda)^2;  
        Lad_dB   = -20*log10(abs( 1 + R_efectivo*exp(exponente)));     
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
end

% -------------------------------------------------------------------------

PIRE_dBw = Ptx_dBw + G_dB;
Lbf_dB = 20*log10((4*pi*d^2)/lambda);
Lad_dB =Lbf_dB + Lad_dB;
Prec_dBw = PIRE_dBw - Lad_dB + G_dB;

Prec_W = 10^(Prec_dBw/10);
Prec_necesaria_W = (1/1000)*10^(-80/10);
Prec_necesaria_dBw = 10*log10(Prec_necesaria_W);
Prec_mW = Prec_W*1000;
Prec_dBm = 10*log10(Prec_mW);

if(Prec_W<Prec_necesaria_W)
    "No es viable"
end

