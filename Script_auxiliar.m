clc;clear;close all;

f = [300,1300, 2300, 3300, 4300,7475,12650, 17825, 23000].*1e6;
Ldif = [17.25 14.06	12.25	12.68	12.4206	11.78	3.04818	2.526048031	2.087027749]


figure(1);
plot(f,Ldif)
title("Perdidas 3 obstaculos en funcion de la frecuencia ")
xlabel("Frecuencia [Hzs]");ylabel("Ldif[dB]")


Ldif = [19.85302508	21.5025501	23.53647459	24.52 25.40	27.34	28.5962948	29.599824	30.67080685];

figure(2);
plot(f,Ldif)
title("Perdidas (orientativas) 3 obstaculos en funcion de la frecuencia ")
xlabel("Frecuencia [Hzs]");ylabel("Ldif[dB]")