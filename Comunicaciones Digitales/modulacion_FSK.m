function [signal_FSK,digital_Signal] = modulacion_FSK(secuenciaBinaria,frecuenciaBaja,frecuenciaAlta,precision)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% modulacion_FSK devuelve la señal analógica y digital enviadas, a partir %
% de 3 parámetros.                                                        %
%     secuenciaBinaria: Es una variable que comprende la secuencia binaria% 
%     que se desea transmitir.                                            %
%                                                                         %
%     frecuenciaBaja: Define la frecencia "baja" del tono puro usado para %
%     la modulación.                                                      %
%                                                                         %
%     frecuenciaAlta: Define la frecencia "alta" del tono puro usado para %
%     la modulación.                                                      %
%                                                                         %
%     precision: Define el número de muestras de la señal analógica.      %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

if nargin > 4
    error("Exceso en los argumentos de entrada");
elseif nargin == 1
    frecuenciaBaja=1;FrecuenciaAlta = 2;
elseif nargin == 2
    frecuenciaAlta =2;
end

valorCero = ceil(frecuenciaBaja) - frecuenciaBaja;
ValorUno = ceil(frecuenciaAlta) - frecuenciaAlta;
if frecuenciaBaja<1 || frecuenciaAlta<1
    error("Las frecuencias no pueden ser menor de uno");
end

tiempo = 0:2*pi/(precision-1):2*pi;
portadoraModulada=[];mod=[];numeroBit=[];

for n=1:length(secuenciaBinaria)
    if secuenciaBinaria(n)==0
        moduladora=ones(1,precision);
        portadora = sin(frecuenciaBaja*tiempo);
        signal=zeros(1,precision);
    else secuenciaBinaria(n)==1
        moduladora= ones(1,precision);
        portadora = sin(frecuenciaAlta*tiempo);
        signal=ones(1,precision);
    end
    
    portadoraModulada = [portadoraModulada moduladora];
    mod=[mod portadora];
    numeroBit=[numeroBit signal];
end

signal_FSK    = portadoraModulada.*mod;
digital_Signal= numeroBit;
end