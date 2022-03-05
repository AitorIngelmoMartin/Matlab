function [c,R1,V] = PFR(cotaE1,cotaE2,cotaO,hE1,hE2,d1,d2,freq)
%PF CALCULA EL DESPEJAMIENTO, EL PRIMER RADIO DE FRESNEL Y EL PARÁMETRO DE
%DISPERSIÓN PARA OBSTÁCULO REDONDEADO.
%   cotaE1: Cota en m del extremo izquierdo del rayo (obstáculo o estación).
%   cotaE2: Cota en m del extremo derecho del rayo (obstáculo o estación).
%   cotaO: Cota en m del obstáculo (hp).
%   hE1: Altura en m de la estación izquierda (=0 si es un obstáculo).
%   hE2: Altura en m de la estación redecha (=0 si es un obstáculo).
%   d1: Distancia en m desde el extremo izquierdo hasta el obstáculo.
%   d2: Distancia en m desde el extremo derecho hasta el obstáculo.
%   freq: frecuencia en Hz.

lambda=3e8/freq;

%cálculo del despejamiento (c), el primer radio de Fresnel (R1) y el parámetro de difracción (V):
c=cotaO-((hE2+cotaE2-hE1-cotaE1)*d1/(d1+d2)+hE1+cotaE1);
R1=sqrt(lambda*(d1*d2/(d1+d2)));
V=sqrt(2)*(c/R1);

end

