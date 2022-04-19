clc;clear;close all;

% Datos satelite transmisor
 Ku    = (14- 12)*1e9;
 Ptx_w = 98;
 Lt_dB = 0.9;
 G_dB  = 30.7;
 F_001 = 5;
 
 G_T_transmisor = 3;
 
Distancia    = 38500e3;
Lgas_down_dB = 1;
Lt_dB        = 0.6;

F_receptor_dB  = 5;
T_ruido_antena = 93;

% Se considera una distancia media de cualquier receptor de la zona central 
% de cobertura al satélite de 39000km A efectos de planificación, se consideran unas pérdidas 
% por lluvia máximas durante el 99,9% del tiempo en toda la zona central de cobertura de 7dB 
% en el enlace descendente. Las pérdidas adicionales en el canal descendente son de 0,8dB debidas 
% a los gases atmosféricos.