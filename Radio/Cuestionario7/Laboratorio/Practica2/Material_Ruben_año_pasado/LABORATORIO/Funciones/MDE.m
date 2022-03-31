function [Fq] = MDE(q,d,f,R_001,k,alpha,K,ho,hS,Lat,theta)
%MDE calcula y devuelve el margen de desvanecimiento sobrepasdo en el q% del año por
%atenuación causada por lluviaen un radioenlace espacial.

% d: distancia en km.
% f: frecuencia en Hz.
% R_001 en mm/h.
% k.
% alpha.
% q en tanto por ciento (%).
% K factor de corrección por atmósfera
% ho: en km
% hS: cota sobre el nivel del mar en km. 

% theta: inclinación en grados
% Lat: latituudo en grados (usar signo (-) si es Lat sur)



Ro=6370;

%Cálculo de Fq.

%PASO 2
gammaR=k*R_001^(alpha)%dB/km 


%PASO 3 ENLACE ESPACIAL
hR=ho+0.36;%km
if(theta>=5)
   LS=(hR-hS)/sind(theta);%km
else
    Re=Ro*K;
    LS=(2*(hR-hS))/(sqrt(sind(theta)^2+(2*(hR-hS)/Re))+sind(theta));   
end
LG=LS*cosd(theta);%km
r_001=1/(1+0.78*sqrt(LG*gammaR/(f/1e9))-0.38*(1-exp(-2*LG)));

if(atand((hR-hS)/(LG*r_001))>theta)
   LR=LG*r_001/cosd(theta);
else
   LR=(hR-hS)/sind(theta);   
end

if(abs(Lat)<36)
   epsilon=36-abs(Lat);
else
   epsilon=0;   
end

V_001=1/(1+sqrt(sind(theta))*(((31*(1-exp(-theta/(1+epsilon)))*sqrt(LR*gammaR))/(f/1e9)^2-0.45)))
deff=LR*V_001;

%PASO 4
F_001=gammaR*deff;

%PASO 5
if(q>=1 || abs(Lat)>=36)
   beta=0;  
elseif (q<1 && abs(Lat)<36 && theta>=25)
   beta=-0.005*(abs(Lat)-36);   
    else
       beta=-0.005*(abs(Lat)-36)+1.8-4.25*sind(theta); 
end

Fq=F_001*(q/0.01)^(-(0.655+0.033*log(q)-0.045*log(F_001)-beta*(1-q)*sind(theta)))