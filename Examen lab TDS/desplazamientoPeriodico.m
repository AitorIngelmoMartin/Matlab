function [Signal_after_movement] = desplazamientoPeriodico(Xn,n0,L)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

xint = [zeros(1,n0) Xn];
longitud = length(xint);
numero_ceros_agregados = L - longitud;

    if(numero_ceros_agregados>0)
        Signal_after_movement = [xint zeros(1,numero_ceros_agregados)];
    else
        Signal_after_movement =[xint(1,1) xint(1:L-1)];
    end
    

end

