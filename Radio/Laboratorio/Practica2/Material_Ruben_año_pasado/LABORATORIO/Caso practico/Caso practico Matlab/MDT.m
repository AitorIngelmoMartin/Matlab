function [Fq] = MDT(q,d,f,R_001,k,alpha)
%MDT calcula y devuelve el margen de desvanecimiento sobrepasdo en el q% del año por
%atenuación causada por lluviaen un radioenlace terrestre.

% d: distancia en km.
% f: frecuencia en Hz.
% R_001 en mm/h.
% k.
% alpha.
% q en tanto por ciento (%).

%Cálculo de Fq.

%PASO 2
gammaR=k*R_001^(alpha);%dB/km 
%PASO 3 ENLACES TERRENALES
r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff=d*r;

%PASO 4
F_001=gammaR*deff;
%PASO 5
if(f<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((f/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=F_001*C1*q^(-(C2+C3*log10(q)));%dB

end

