clear,clc;close all;

numero =100;
tipo_base=1;

%  Si tipo_base 0, a dB
% Si tipo_base 1, a dBw
% Si tipo_base 2, a dBm
% Si tipo_base 3, a dBr
% Si tipo_base 4, a dBi

if tipo_base == 0 || tipo_base == 1
    conversion_solicitada = 10*log10(numero);
end

if tipo_base == 2
    
end

if tipo_base == 3
    
end

if tipo_base == 4
    
end

