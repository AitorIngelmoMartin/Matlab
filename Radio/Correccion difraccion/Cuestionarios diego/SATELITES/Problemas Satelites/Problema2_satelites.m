clc;clear;close all;

Boltzmann       = 1.38e-23;
Distancia       = 38200e3;
Rb              = 34e6;
BW_total        = 36e6;

M               = 16;
% LLuvia estación A
F_001_A = 9;
%LLuvia estación B
F_001_B = 16;

Eb_No_total_min = 12;
 
%Si el sistema está por debajo de este Eb/No
f_ascendente   = 14e9;
f_descendente  = 11e9;

Lad_up_dB      = 0.2;
Lad_down_dB    = 0.3;

Margen_up_dB   = 1.3;
Margen_down_dB = 1.4;

G_T_satelite      = -5;
G_T_estacion      = 19.1;
PIRE_satelite_dBw = 48;

% 1)Si la modulación utilizada es 16-PSK. ¿Cuál será el valor del factor de roll-off del
% filtro de coseno alzado utilizado en la transmisión si se utiliza una codificación 
% contra errores FEC 1/3? Existe una banda de guarda en los extremos de la banda de 0,15 MHz.

BW_portadora = BW_total/17;
Roll_off     = ((BW_portadora-2*0.15e6) -1)/((Rb*(1/3))/(log2(M)));

% 2)Obtenga el  parámetro de transmisión de las estaciones terrenas de ambas zonas 
% climáticas para que el enlace funcione con la calidad requerida durante
% el 99,99% del tiempo. Las estaciones terrenas deben ser equipadas con los 
% dispositivos UPC y CAG adecuados a cada zona climática.

%       Parámetros de transmisiñon son PIREet y G/Tet, que dan la C/N0total_minima

Flujo_sat     = (10^(PIRE_satelite_dBw/10))/(4*pi*Distancia*Distancia);
Flujo_sat_dBw = 10*log10(Flujo_sat);


PIRE_et_dBW   = Flujo_sat_dBw + 10*log10(4*pi*Distancia^2) + Lad_up_dB +Margen_up_dB;