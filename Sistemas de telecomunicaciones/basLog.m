function [conversion_solicitada] = basLog(numero,tipo_base)
%LOGARITMOS Summary of this function goes here
%   Detailed explanation goes here


%  Si tipo_base 0, a dB
% Si tipo_base 1, a dBw
% Si tipo_base 2, a dBm
% Si tipo_base 3, a dBr
% Si tipo_base 4, a dBi


if tipo_base == 0
    conversion_solicitada = 10*log10(numero);
end

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

