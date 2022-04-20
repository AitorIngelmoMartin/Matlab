clc;clear;close all;

% Se desea planificar un sistema FDMA de comunicaciones por satélite en banda Ku (14GHz/12 GHz)
f_up   = 14e9;
f_down = 12e9;
%8 estaciones terrenas, con 4 que transmiten a 3Mbps, 3 a 5Mbps y 1 a 10Mbps. 
Rb = [3 3 3 3 5 5 5 10]* 1e6;

roll_off = 0.4;
FEC      = 5/6;

Lgas_up_dB = 0.5;
Margen_up  = 1.5;
Boltzmann  = 1.38e-23;

Lgas_down_dB   = 0.5;
Margen_down_dB = 1.25;

Distancia = 39000e3;

% Los parámetros del satélite son:
    BW_transpondedor     = 36e6;
    BW_guarda            = 1.5e6;
    SFD_dBW              = -98;
    G_T_dB               = 10;
    PIRE_saturacion_dBw  = 52; 
% Los parámetros de las estaciones terrenas son:
    G_antena_dB = 40;
    Tantena     = 22;
    Lt_dB       = 0.3;
    G_LNA_dB    = 40;
    FLNA_dB     = 0.5;
    
    
% 1)Calcule la PIRE en cielo claro para cada estación terrena para el punto de saturación.
Eb_No = 11.7; % mirado en tabla
C_N_total = Eb_No + 10*log10(Rb)

Lbf_up_dB = 20*log10((4*pi*Distancia)/f_up)


PIRE_cielo_claro = C_N_total + Lbf_up_dB + Lgas_up_dB + Margen_up - G_T_dB + 10*log10(Boltzmann)


% 2) Calcular la G/T de las estaciones terrenas.

G_T_terrena_dB  = C_N_total + Lbf_up_dB + Lgas_up_dB + Margen_up - PIRE_saturacion_dBw  + 10*log10(Boltzmann)