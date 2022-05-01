clc;clear;close all;

% Como la frecuencia es menor a 1Ghz, no hay perdidas por gases atmosféricos
f = 433e6;
lambda = (3e8)/f;
Ptx_dBm = 10*log10(100);

Umbral_dBm = -117;

Rb_max = 250e3; % 250Kbps

% Distancia muy pequeña, se puede considerar tierra plana
Distancia = 1e3;

Ganancia_dB = [0 3.5]

Lbf_dB = 20*log10((4*pi*Distancia)/lambda)
Lt = 3;
Prx_dBm = Ptx_dBm - Lbf_dB + Ganancia_dB -Lt;

figure(1);
hold on    
yline(Prx_dBm(1),"r")
yline(Prx_dBm(2),'b')
yline(Umbral_dBm)
legend("G =0","G = 3.5dBi","Umbral");
hold off
title("Potencia recibida en funcion de la ganancia");ylabel("Prx [dBm]");



Distancia_prueba = [1000:500:10000];
Lbf_prueba_dB = 20*log10((4*pi*Distancia_prueba)/lambda);
Prx_prueba_dBm = Ptx_dBm - Lbf_prueba_dB + Ganancia_dB(2);
figure(2);
plot(Distancia_prueba,Prx_prueba_dBm);
title("Potencia recibida respecto la distancia");
ylabel("Potencia [dBm]");xlabel("Distancia [m]");

Margen_lluvia = Prx_dBm-Umbral_dBm -Lt;
