clear;clc;close all;

% Ejercicio 6.4: Asumiendo que las estaciones de un enlace terrestre cuentan con las antenas de
% diámetro 0.6m y que están separadas 23km, determinar el campo recibido asociado a una potencia
% recibida de -88dBm.  

% Determinar la potencia recibida en caso de que ese valor de campo llegara a la
% antena en polarización horizontal.

% DATOS ANTENA
Dmx_dB=43.7; G = Dmx_dB;
Dmx = 10^(Dmx_dB/10);
frec=6675e6;
c = 3e8;
lambda = c/frec;
% DUDA:Cómo paso la directividad a Ganancia de la antena ?
% Voy a suponer que Dmx = Ganancia de la antena.



Distancia = 23000;
Prx_dBm = -88;
Prx_W = 1000*(10^(-88/10));
Prx_dB = 10*log10(Prx_W);

Lbf_dB =20*log10((4*pi*Distancia)/lambda);

% DUDA: Estoy calculando el flujo con la Ptx obtenida a partir de la 
% recibifa, espero que sea asi, en caso de no serlo creo que debo usar 
% la formula del flujo considerando que la Ptx es la recibida. Es decir,
% como si considerase que salgo de la antena Rx.

Ptx_dB = Prx_dB - G - G + Lbf_dB;

PIRE_dB = Ptx_dB + G;
PIRE_W = 10^(PIRE_dB/10);
Flujo =PIRE_W/(4*pi*Distancia*Distancia);

e = (Flujo * 120 * pi)^(1/2);



% Preguntar sobre cómo hago la segunda parte, si debo mirar el XPD o como.

