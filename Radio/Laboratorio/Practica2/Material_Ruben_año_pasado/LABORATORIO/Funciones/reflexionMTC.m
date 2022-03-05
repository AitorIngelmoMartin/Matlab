function [Lad_v,Lad_h] = reflexionMTC(cotaE1,cotaE2,hE1,hE2,d,freq,K,rho,sigma,epsilon_r)
%REFLEXIONMTC calcula y devuelve las pérdidas por reflexión para el modelo
%de tierra curva en polarización vertical (Lad_v) y horizontal (Lad_h)

%   Si dlim<d-->MTC. Si no, sería MTP
%   Si phi_lim < phi --> hay reflexión MTC. Si no, habría difracción.
%   Si no se cumplen las dos condiciones la función devuelve 0.
%  
%   freq: frecuencia en Hz.
%   cotaE1: cota de la estación 1 en m.
%   cotaE2: cota de la estación 2 en m.
%   hE1: Altura de la estación 1 en m.
%   hE2: Altura de la estación 2 en m.
%   d: distancia entre las estaciones en m.
%   rho:
%   sigma: S/m
%   epsilon_r:

lambda=3e8/freq;

%Cálculo de pérdidas por reflexión:
H1=cotaE1+hE1;
H2=cotaE2+hE2;
Ro=6370*1e3;%m

dmax=sqrt(2*K*Ro*H1)+sqrt(2*K*Ro*H2);
dlim=0.1*dmax;
%dlim<d-->MTC


p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4));
Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3);%PHI
if (H1>H2)
    d1=d/2+p*cos((pi+Phi)/3);
    d2=d-d1;
else
   d2=d/2+p*cos((pi+Phi)/3);
   d1=d-d2; 
end

hp1=H1-(d1^2/(2*K*Ro));
hp2=H2-(d2^2/(2*K*Ro));
tan_phi=hp1/d1;
phi=atan(tan_phi);%phi

phi_lim=((5400/(freq/1e6))^(1/3))/(1e3);%rad
%Si phi_lim < phi -> hay reflexión MTC. si no, habría difracción.

epsilon_o=epsilon_r-1i*60*sigma*lambda;

Ab=(2*hp1*hp2)/(d);%incremento de longitud
Gamma=(4*pi*rho*sin(phi))/(lambda);

Rv=(epsilon_o*sin(phi)-sqrt(epsilon_o-cos(phi).^2))/(epsilon_o*sin(phi)+sqrt(epsilon_o-cos(phi).^2))
Rh=(sin(phi)-sqrt(epsilon_o-cos(phi).^2))/(sin(phi)+sqrt(epsilon_o-cos(phi).^2))
D=1/sqrt(1+((5/(16*K))*(((d2/1e3)*(d1/1e3)^2)/((d/1e3)*hp1))));

%P.V.
Re_v=Rv*D*exp(-(Gamma^2)/2);
lad_v=1/abs(1+Re_v*exp(-1i*2*pi*Ab/lambda))^2;
Lad_v=10*log10(lad_v);
%P.H.
Re_h=Rh*D*exp(-(Gamma^2)/2);
lad_h=1/abs(1+Re_h*exp(-1i*2*pi*Ab/lambda))^2;
Lad_h=10*log10(lad_h);

if (phi_lim>phi || dlim>d)
    Lad_h=0;
    Lad_v=0;
end

end

