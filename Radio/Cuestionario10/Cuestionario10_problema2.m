clc;clear;close all;
% En un estudio de planificación previa se pretende evaluar la efectividad de
% plantear un radioenlace con tres vanos y dos secciones de conmutación.

% Las características de las estaciones terminales e intermedias son:
% - Antenas Parabólicas de 48 dB de ganancia con polarización vertical
    G_Pv_dB = 48;
% - Frecuencia de trabajo 52 GHz
    f = 52e9;
    lambda = (3e8)/f;
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
    Distancia_total = 31e3;
% - régimen binario ofrecido
    Rb_bps = 15e6;
  
 % Tabulando a f=52Ghz y PV:
    K_lluvia = 0.6901   
    Alpha    = 0.7783
% Determinar la calidad de disponibilidad para asegurar una Eb/N0=12 dB 
% para QPSK. 
Eb_N0 = 12;
M     = 4;

Bn        = Rb_bps/(log2(M));
Boltzman  = 1.381e-23;
C_N0      = Eb_N0 + 10*log10(Rb_bps);

Distancia = [11 6 14]*1e3;
Lgas_dB   = 1*Distancia/1000;
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lb        = Lbf_dB(1) + Lt_dB +Lgas_dB(1)  +Lbf_dB(2) +Lgas_dB(2) +Lbf_dB(3) + Lt_dB + Lgas_dB(3);

Prx_dBm = PIRE_dBw - Lbf_dB - Lgas_dB + G_Pv_dB - Lt_dB +30

T0 = 290;
Lt = 10^(Lt_dB/10);

f_receptor   = 10^(F_receptor/10);
T_despues_lt = T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(f_receptor-1)

Umbral_dBm   = C_N0 + 10*log10(T_despues_lt*Boltzman*Bn) +30;
MD_dB   = Prx_dBm - Umbral_dBm

Distancia = (Distancia)/1000; f=f/(1e9);

Gamma_r  = K_lluvia* R_001^Alpha;
Deff     = (Distancia)./(0.477*(Distancia.^0.633)*(R_001^(0.073*Alpha))*(f^(0.123))-10.579*(1-exp(-0.024*Distancia)));
F_001    = Gamma_r .* Deff



if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

logaritmo = log10(MD_dB./(F_001.*C1));

soluciones_x =  [( -C2 + sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3),( -C2 - sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3)];


x1    = [soluciones_x(1) soluciones_x(3) soluciones_x(5)];
x2    = [soluciones_x(2) soluciones_x(4) soluciones_x(6)];
x = max(x1,x2);

q_calculado = 10.^x

U_equipo = ((MTTR/MTBF)*100)*[1.5 1.5 2];

U_total = q_calculado+U_equipo
