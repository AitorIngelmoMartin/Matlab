function [q] = MDTinv(Fq,d,f,R_001,k,alpha)
%MDTINV calcula y devuelve el q% del tiempo en que un margen de desvanecimiento dado es sobrepasdo en año por
%atenuación causada por lluvia en un radioenlace terrestre.

% d: distancia en km.
% f: frecuencia en Hz.
% R_001 en mm/h.
% k.
% alpha.
% Fq: margen de desvanecimiento en dB.

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


solucion=roots([C3 C2 log10(Fq/(F_001*C1))]);
q=10^(max(solucion));
end

