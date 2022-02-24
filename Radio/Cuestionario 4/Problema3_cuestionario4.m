clc;clear;close all;
f = 6e9;
c=3e8;
lambda= c/f;

% Alturas, distancia y radio en metros
h1 = 150;
h2 = 300;
Distancia = 35000;
R0 =6370000;

Permeavilidad_terreno = 70;
Conductividad=5;


K = 4/3;
termino1 = K*R0+h1;
termino2= K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;
Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    Caso = "Tierra plana"
else
    %Código ejecutado si tierra curva
    Caso = "Tierra curva";
end


f=6e9;
c=3e8;
lambda = c/f;
Rho = 0.1;


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

Epsilon0 = Permeavilidad_terreno -1i*60*Conductividad*lambda;
numerador   = Epsilon0*sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
denominator = Epsilon0*sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
Rv =numerador/denominator;
% Programar para que vaya solito poe PH/PV


if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"
    Rugosidad = 4*pi*Rho*sin(Phi)/lambda;
    
    if(Rugosidad>0.3)
        %Las pérdidas por refelxión son cero;
        Lref = 0;
    else
        Dcaminos =sqrt( Distancia*Distancia + abs(H1+H2)^2 ) - sqrt( Distancia*Distancia + abs(H1-H2)^2 );
        
        Divergencia = (1 + (5/(16*K)*((d2*d1*d1)/(Distancia*H1))))^(-1/2);
        Refectivo = Rv*Divergencia*exp(-((Rugosidad*Rugosidad)/2))
        exponente = (-1i*(((2*pi)/lambda))*Dcaminos);
        Lref_dB   = -20*log10(norm( 1 + (Refectivo*exp(exponente)) )) 
    end
    
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
end