clear;clc;close all;
% Los requisitos exigidos al módulo de la respuesta en frecuencia |Ha(ω)| 
% son: Debe ser mayor que 0,89125 en la banda de frecuencias comprendidas 
% entre 0 y 800 Hz. No debe superar 0,17783 a partir de los 1400 Hz.
Ts=0.125e-3;
% a) Obtenga la plantilla de especificaciones del módulo de la respuesta en
% frecuencia, expresada en dB que debe cumplir el filtro digital Hd(Ω)
alfa_a = -20*log10(0.89125);
alfa_p = -20*log10(0.17783);

Omega_p = 800*2*pi*Ts;
Omega_a = 1400*2*pi*Ts;

% b) Se decide realizar el diseño del filtro anterior a partir de un 
% prototipo analógico y empleando la transformación bilineal. Obtenga la 
% plantilla de especificaciones del módulo de la respuesta en frecuencia 
% de dicho filtro analógico. Considere Td = 2.
Td = 2;
Wp=2/Td*(tan(Omega_p/2));
Wp_radianes=Wp/pi;
Wa=2/Td*(tan(Omega_a/2));
Wa_radianes=Wa/pi;


% c) En la etapa de aproximación se elige un filtro elíptico de orden 2 
% cuya función de sistema es H(s). Obtenga la función de sistema Hd(z) 
% correspondiente.
%           H(s) = 0,158 *(s2 + 0,7s )/ (s2 + 0,32 · s + 0,124)

Fd = 1/Td;

[N,wc]=buttord(Wp_radianes,Wa_radianes,alfa_a,alfa_p,"s");
[B,A]=butter(N,wc,"s");
[Bz,Az]=bilinear(B,A,Fd);

figure(1);title("Representación polos/ceros Hd(z)");
zplane(Bz,Az);
