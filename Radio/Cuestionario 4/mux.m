clear;clc;
h1 = 150;
h2=300;
R0 = 6370000;K = 4/3;
D = 35000;
f=6000000;
c=3e8;
lambda = c/f;
Factor_rugosidad = 0.1;

P = (2/sqrt(3))*sqrt((K*R0*(h1+h2)+(D^2)/4)); 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*D)/P^3);
    d1 = D/2+P*cos((pi+Thau)/3);
    d2=D-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*D)/P^3);
    d2 = D/2+P*cos((pi+Thau)/3);
    d1=D-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi = atan(H1/d1);
Phi_lim = (5400/(f/1000))^(1/3);
if(Phi<0.1)
 R = -1;
end
if(Phi>Phi_lim)
 %Código ejecutado si hay reflexión -> MDTE
    Divergencia = (1 + (5/(16*K)*((d2*d1^2)/(D*H1))))^(-1/2); 
    Rugosidad = (4*pi*Factor_rugosidad*sin(Phi))/lambda
    if(Rugosidad>0.3)
        %Las pérdidas por refelxión son cero;
        Lref = 0;
    else
        Divergencia = (1 + (5/(16*K)*((d2*d1^2)/(D*H1))))^(-1/2); 
        Rugosidad = (4*pi*Factor_rugosidad*sin(Phi))/lambda;
    end
    Re = D*Divergencia*Rugosidad;
else
 %Código ejecutado si hay difracción
end