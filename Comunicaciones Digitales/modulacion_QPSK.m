function [signal_QPSK,digital_Signal] = modulacion_QPSK(secuenciaBinaria,frecuencia,precision)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% modulacion_QPSK devuelve la señal analógica y digital enviadas, a partir %
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

l = length(secuenciaBinaria);
re = ceil(0.5);
val = re - 0.5;
if val ~=0
    error("Introduce un vector divisible por 2");
end

tiempo = 0:2*pi/(precision-1):2*pi;
portadoraModulada=[];mod=[];numeroBit=[];

for n=1:2:length(secuenciaBinaria)
    if secuenciaBinaria(n)==0 && secuenciaBinaria(n+1) ==1
        moduladora=sqrt(2)/2*ones(1,precision);
        moduladora_auxiliar = -sqrt(2)/2*ones(1,precision);
        signal=[zeros(1,fix(precision/2)) ones(1,fix(precision/2))];
    else secuenciaBinaria(n)==1
        moduladora=ones(1,precision);
        signal=ones(1,precision);
    end
    
    portadora=sin(frecuencia*tiempo);
    portadoraModulada = [portadoraModulada moduladora];
    mod=[mod portadora];
    numeroBit=[numeroBit signal];
end

signal_BPSK    = portadoraModulada.*mod;
digital_Signal= numeroBit;
end

