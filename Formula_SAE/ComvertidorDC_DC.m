clear; clc; close all;
Iin_max = 180; %En amperios

I0= 1;
V0max=24;
VOmin =5;
F0= [1000:1000:20000]; %Array para hacer un análisis para determinar la Frec

VINmin = 5

Dmax = (V0max-VINmin)/V0max;
IL = I0/(1-Dmax);


%Esta línea es la prueba que hicimos con 20khz, ya que la bobina de
%0.04micro faradios no se puede comprar.

Inductancia_Prueba = (1/20000)/(2*I0)*(V0max)*Dmax*(1-Dmax)^2;

d
Ts = 1/10000;
Inductancia_Prueba2 = (1/20000)/(2*I0)*(V0max)*Dmax*(1-Dmax)^2
Ilb=(Ts/(2))*(V0max)*Dmax*(1-Dmax)*(1-Dmax)

Inductancia_Prueba = 26e-6;
Corriente_Prueba = ((1/10000)/(2*Inductancia_Prueba))*V0max*Dmax*(1-Dmax)^2
Iou=Corriente_Prueba*(1-Dmax)
%Frecuencia de corte de 10khs

%Es un FPS con un operacional / Cambio de la resistencia por un condensador


% El porcentaje de rizado debe ser menor a un 1%
Ts=1/300;
Rizado = 0.01;
Rpeor_caso=24/Iou;
Capacitancia = (Dmax*Ts)/(Rpeor_caso*Rizado)


Bobina = Inductancia_Prueba;
Condensador = Capacitancia;

