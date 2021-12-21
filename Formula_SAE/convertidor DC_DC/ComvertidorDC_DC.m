clear; clc; close all;

I0= 1;
V0max=24;
VOmin =5;

VINmin = 5

Dmax = (V0max-VINmin)/V0max;
IL = I0/(1-Dmax);

Ts = 1/10000;
% Inductancia_Prueba = (1/20000)/(2*I0)*(V0max)*Dmax*(1-Dmax)^2
% Ilb=(Ts/(2))*(V0max)*Dmax*(1-Dmax)*(1-Dmax)

Inductancia_Prueba = 26e-6;
Corriente_Prueba = (Ts)/(2*Inductancia_Prueba)*V0max*Dmax*(1-Dmax)^2
Iou=Corriente_Prueba*(1-Dmax)


% El porcentaje de rizado debe ser menor a un 1%
Ts=1/10000;
Rizado = 0.01;
Rpeor_caso=24/Iou;
Capacitancia = (Dmax*Ts)/(Rpeor_caso*Rizado)


Inductancia = Inductancia_Prueba;
Condensador = Capacitancia;



% //////////// D CON v = 12
V0max=24;
VOmin =5;

VINmin = 12

Dmax = (V0max-VINmin)/V0max;
IL = I0/(1-Dmax);

Ts = 1/10000;
% Inductancia_Prueba = (1/20000)/(2*I0)*(V0max)*Dmax*(1-Dmax)^2
% Ilb=(Ts/(2))*(V0max)*Dmax*(1-Dmax)*(1-Dmax)

Inductancia_Prueba = 26e-6;
Corriente_Prueba = (Ts)/(2*Inductancia_Prueba)*V0max*Dmax*(1-Dmax)^2
Iou=Corriente_Prueba*(1-Dmax)


% El porcentaje de rizado debe ser menor a un 1%
Ts=1/10000;
Rizado = 0.01;
Rpeor_caso=24/Iou;
Capacitancia = (Dmax*Ts)/(Rpeor_caso*Rizado)


Inductancia = Inductancia_Prueba;
Condensador = Capacitancia;

% Porcentaje de trabajo diapositiva 12/43 dc-dc boost
porcentaje_trabajo = (1-Dmax)/12;


    
