clc;clear;close all;
f = 6e9;
c=3e8;
lambda= c/f;

% Alturas, distancia y radio en metros
h1 = 150;
h2 = 300;
Distancia = 35000;
R0 =6370000;

K = 4/3;
termino1 = K*R0+h1;
termino2= K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;
Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2)

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    Caso = "Tierra plana"
else
    %Código ejecutado si tierra curva
    Caso = "Tierra curva"
end


f=6000000;
c=3e8;
lambda = c/f;
Factor_rugosidad = 0.1;

P = (2/sqrt(3))*sqrt((K*R0*(h1+h2)+(Distancia^2)/4)); 

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
Phi_lim = (5400/(f/1000))^(1/3);
if(Phi<0.1)
 R = -1;
end

if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MCTE
    "Hay pérdidas por reflexión"
    Divergencia = (1 + (5/(16*K)*((d2*d1^2)/(Distancia*H1))))^(-1/2); 
    Rugosidad = (4*pi*Factor_rugosidad*sin(Phi))/lambda
    if(Rugosidad>0.3)
        %Las pérdidas por refelxión son cero;
        Ldif = 0;
    else
        Divergencia = (1 + (5/(16*K)*((d2*d1^2)/(Distancia*H1))))^(-1/2); 
        Rugosidad = (4*pi*Factor_rugosidad*sin(Phi))/lambda;
    end
    Re = Distancia*Divergencia*Rugosidad;
else
 %Código ejecutado si hay difracción
    "Hay pérdidas por difracción"
end