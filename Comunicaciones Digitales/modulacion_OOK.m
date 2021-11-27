function [signal_OOK,digital_Signal] = modulacion_OOK(secuenciaBinaria,frecuencia,precision)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% modulacion_OOK devuelve la señal analógica y digital enviadas, a partir %
% de 3 parámetros.                                                        %
%     secuenciaBinaria: Es una variable que comprende la secuencia binaria% 
%     que se desea transmitir.                                            %
%                                                                         %
%     frecuencia: Define la frecencia del tono puro usado para la         %
%     modulación.                                                         %
%                                                                         %
%     precision: Define el número de muestras de la señal analógica.      %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

if nargin > 3
    error("Exceso en los argumentos de entrada");
elseif nargin == 1
    frecuencia = 1;
end

if frecuencia<1
    error("La frecuencia no puede ser menor de uno");
end

if precision<1
    error("La precision no puede ser menor de uno, se recomienda usar un valor de 100");
end

tiempo = 0:2*pi/(precision-1):2*pi;
portadoraModulada=[];mod=[];numeroBit=[];

for n=1:length(secuenciaBinaria)
    if secuenciaBinaria(n)==0
        moduladora=zeros(1,precision);
        signal=zeros(1,precision);
    else secuenciaBinaria(n)==1
        moduladora=2*ones(1,precision);
        signal=ones(1,precision);
    end
    
    portadora=sin(frecuencia*tiempo);
    portadoraModulada = [portadoraModulada moduladora];
    mod=[mod portadora];
    numeroBit=[numeroBit signal];
end

signal_OOK    = portadoraModulada.*mod;
digital_Signal= numeroBit;
end

