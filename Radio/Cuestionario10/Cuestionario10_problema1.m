clc;clear;
% En la figura adjunta se representa un radioenlace para enlazar dos edificios. 
% Debido a la existencia de otro edificio situado en la línea de vista de los edificios considerados, se 
% estudia la alternativa de diseñar el enlace a través de un reflector:

% Frecuencia de trabajo: 18 GHz
f = 18e9;
lambda = (3e8)/f;
% Régimen binario: 2 Mbps
Rb = 2e6;
% Modulación: 128 QAM.
M = 128;
% Factor de roll-off: 0,2
roll_off = 0.2;
% Atenuación debida a gases: despreciable
% Figura de ruido del receptor: 6 dB.
F_receptor = 6;
% Potencia transmitida: 29 dBm
Ptx_dBm = 29;
% C/N (umbral) = 9 dB
C_N_umbral = 9;
% Pérdidas en guías y branching: 1 dB.
L_guias_dB = 1;
% Antenas: Parabólicas de 36dB de ganancia.
G_antena = 36;
% Reflector parabólico de 1,2m^2 de superficie geométrica
S_geometrica = 1.2;
% ectivaR0,01=24 mm/h; α =1,0818; k=0,0708
R_001 = 24;
Alpha = 1.0818;
K_lluvia = 0.0708;
% Atenuador variable frente a desvanecimientos
% Determinar la indisponibilidad de propagación debida a la atenuación por lluvia.
D1 = 11e3;
D2 = D1;
% GANANCIA DEL REFLECTOR
angulo = atand(11/3.7);
Ganancia_reflector    = (S_geometrica*cosd(angulo)*4*pi)/(lambda^2);
Ganancia_reflector_dB = 10*log10(Ganancia_reflector)


% POTENCIA RECIBIDA
Lbf1 = 20*log10((4*pi*D1)/lambda);
Lbf2 = Lbf1;

Lb   = Lbf1  - Ganancia_reflector_dB + L_guias_dB  - Ganancia_reflector_dB +Lbf2; 

Prx_dBm = Ptx_dBm + G_antena -Lb + G_antena - L_guias_dB - L_guias_dB

% DISTANCIA DEL VANO

%   Vano es la distancia entre dos antenas, por lo que 22Km, la suma de los
%   dos tramos.

% UMBRAL A LA SALIDA DE LOS TERMINALES
Bn          = Rb/(log2(M));
Boltzman    = 1.381e-23;
T0 = 290;
f_receptor = 10^(F_receptor/10);
Lt = 10^(L_guias_dB/10);
% T_despues_lt = T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(f_receptor-1)
T_despues_lt = T0*(f_receptor)

Umbral_dBm   = C_N_umbral + 10*log10(T_despues_lt*Boltzman*Bn) +30

% q DEBIDO A LA LLUVIA

Distancia = (2*D1)/1000; f=f/(1e9);

Gamma_r  = K_lluvia* R_001^Alpha; %dB/Km
Deff     = (Distancia)/(0.477*(Distancia^0.633)*(R_001^(0.073*Alpha))*(f^(0.123))-10.579*(1-exp(-0.024*Distancia))); %Km

F_001    = Gamma_r * Deff; % dB

% En Lvbl Prx = MD+ Thx
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

soluciones_x =  [( -C2 + sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3),( -C2 - sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3)];
x =max(soluciones_x);
q_calculado = 10^x
