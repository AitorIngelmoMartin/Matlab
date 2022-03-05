function [c,R1,V] = PF(cotaE1,cotaE2,cotaO,hE1,hE2,d1,d2,K,freq)
%PF CALCULA EL DESPEJAMIENTO, EL PRIMER RADIO DE FRESNEL Y EL PARÁMETRO DE
%DISPERSIÓN.
%   cotaE1: Cota en m del extremo izquierdo del rayo (obstáculo o estación).
%   cotaE2: Cota en m del extremo derecho del rayo (obstáculo o estación).
%   cotaO: Cota en m del obstáculo.
%   hE1: Altura en m de la estación izquierda (=0 si es un obstáculo).
%   hE2: Altura en m de la estación redecha (=0 si es un obstáculo).
%   d1: Distancia en m desde el extremo izquierdo hasta el obstáculo.
%   d2: Distancia en m desde el extremo derecho hasta el obstáculo.
%   K: Factor de modificación del radio terrestre.
%   freq: frecuencia en Hz.

Ro=6370e3;
lambda=3e8/freq;

%cálculo del despejamiento (c), el primer radio de Fresnel (R1) y el parámetro de difracción (V):
c=(d1*d2/(2*K*Ro)+cotaO)-((hE2+cotaE2-hE1-cotaE1)*d1/(d1+d2)+hE1+cotaE1);
R1=sqrt(lambda*(d1*d2/(d1+d2)));
V=sqrt(2)*(c/R1);

end

