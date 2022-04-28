% En un estudio de planificación previa se pretende evaluar la efectividad de
% plantear un radioenlace con tres vanos y dos secciones de conmutación.

% Las características de las estaciones terminales e intermedias son:
% - Antenas Parabólicas de 48 dB de ganancia con polarización vertical
    G_Pv_dB = 48;
% - Frecuencia de trabajo 52 GHz
    f = 52e9;
% - Pérdidas en los terminales de 1,4 dB
    Lt_dB = 1.4;
% - Modulación QPSK y filtro de coseno alzado con α=0,4 (se asume una degradación debida al filtro de 2 dB)
    Degradacion = 2;
% - Figura de ruido del receptor de 5 dB
    F_receptor = 5;
% - MTTR 40 horas
    MTTR = 40;
% - MTBF 2*10^6 horas
    MTBF = 2*(1e6);
% - PIRE=75 dBW
    PIRE_dBw = 75;
% - Atenuador variable
% - R0,01=40 mm/h
    R_001 = 40;
% - distancia entre estaciones terminales
    Distancia = 31e3;
% - régimen binario ofrecido
    Rb_bps = 15e6;
    
% Determinar la calidad de disponibilidad para asegurar una Eb/N0=12 dB 
% para QPSK. 
Eb_No = 12;
M     = 4;
% las longitudes de los tres vanos son 11,6 y 14 km. Las longitudes de las 
% dos secciones de conmutación son 17 y 14km.