clc;clear;
% En la figura adjunta se representa un radioenlace para enlazar dos edificios. 
% Debido a la existencia de otro edificio situado en la línea de vista de los edificios considerados, se 
% estudia la alternativa de diseñar el enlace a través de un reflector:

% Frecuencia de trabajo: 18 GHz
f      = 18e9;
lambda = (3e8)/f;
Rb = 2e6;
M  = 128;
roll_off = 0.2;
% Atenuación debida a gases: despreciable
F_receptor   = 6;
Ptx_dBm      = 29;
C_N_umbral   = 9;
L_guias_dB   = 1;
G_antena     = 36;
R_001        = 24;
Alpha        = 1.0818;
K_lluvia     = 0.0708;
S_geometrica = 1.2;
% Atenuador variable frente a desvanecimientos
% Determinar la indisponibilidad de propagación debida a la atenuación por lluvia.

angulo = atand(11/3.7);
D1     = 3.7/(cosd(angulo))*1000
% GANANCIA DEL REFLECTOR
angulo = atand(11/3.7);
Ganancia_reflector    = (S_geometrica*cosd(angulo)*4*pi)/(lambda^2);
Ganancia_reflector_dB = 10*log10(Ganancia_reflector)

% POTENCIA RECIBIDA
Lbf1 = 20*log10((4*pi*D1)/lambda);
Lbf2 = Lbf1;

% Al no decir nada, supongo rendimiento de 1 y no pongo pérdidas (LT) en el
% reflector

Lb      = Lbf1 + L_guias_dB - Ganancia_reflector_dB - Ganancia_reflector_dB + Lbf2 + L_guias_dB; 
Prx_dBm = Ptx_dBm + G_antena -Lb + G_antena  

% DISTANCIA DEL VANO

%   La diagonal = 11.6 -> 
    Distancia_vano = 2*(sqrt(11^2 + 3.7^2))*1e3
% que es la suma de las dos.

% UMBRAL A LA SALIDA DE LOS TERMINALES
Bn          = Rb/(log2(M));
Boltzman    = 1.381e-23;

T0 = 290;
Lt = 10^(L_guias_dB/10);

f_receptor   = 10^(F_receptor/10);
T_despues_lt = T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(f_receptor-1)
Umbral_dBm   = C_N_umbral + 10*log10(T_despues_lt*Boltzman*Bn) +30

% q DEBIDO A LA LLUVIA
Distancia_vano = (Distancia_vano)/1000; f=f/(1e9);

Gamma_r  = K_lluvia* R_001^Alpha;
Deff     = (Distancia_vano)/(0.477*(Distancia_vano^0.633)*(R_001^(0.073*Alpha))*(f^(0.123))-10.579*(1-exp(-0.024*Distancia_vano)));
F_001    = Gamma_r * Deff;

% En Lvbl Prx = MD + Thx
MD_dB = Prx_dBm - Umbral_dBm;
if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

logaritmo = log10(MD_dB/(F_001*C1));

soluciones_x =  roots([C3 C2 log10(MD_dB/(F_001*C1))]);
x = max(soluciones_x);
q_calculado = 10^x