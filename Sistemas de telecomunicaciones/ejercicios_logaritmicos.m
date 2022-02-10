clear;clc;close all;


Potencia_dBr = [3 5 0 1 -10 -1 -5 10 9 -2];
Potencia_dBr_ordenado = sort(Potencia_dBr);
dBm0 = -3;

Potencia_referencia = (10*(10^(dBm0/10)))/1000; %En W

longitud_vector=size(Potencia_dBr_ordenado);
Vector_potencia_watios=zeros(1,longitud_vector(1,2));

for k=1:longitud_vector(1,2)
    
Vector_potencia_watios(1,k) =  Potencia_referencia* (10^(Potencia_dBr_ordenado(1,k)/10));

end

Vector_potencia_absoluto = 10*log10(Vector_potencia_watios);
Vector_potencia_dBm = 10*log10((Vector_potencia_watios.*1000));

figure(1);
hold on;

plot(Vector_potencia_watios,Vector_potencia_absoluto);
plot(Vector_potencia_watios,Potencia_dBr_ordenado);
plot(Vector_potencia_watios,Vector_potencia_dBm);

title("Evolución de potencias");xlabel("Watios");
legend('dBr','dB','dBm');

hold off;

figure(2);subplot(311);
plot(Vector_potencia_watios,Vector_potencia_absoluto);
title("Potencias en dB");xlabel("Watios");

subplot(312);
plot(Vector_potencia_watios,Potencia_dBr_ordenado,'Color' ,"#D95319");
title("Potencias en dBr");xlabel("Watios");
subplot(313);
plot(Vector_potencia_watios,Vector_potencia_dBm,'Color','#EDB120');
title("Potencias en dBm");xlabel("Watios");