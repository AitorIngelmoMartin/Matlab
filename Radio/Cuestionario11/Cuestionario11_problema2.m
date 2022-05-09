clc;clear;

% Un servicio de radioenlace fijo en la banda de los 13 GHz.
f = 13e9;
lambda = 3e8/f;
% El radioenlace está compuesto por dos vanos de 27 km y 19 km. 
Distancia_total = 46;
Distancia = [27 19]*1e3;

% Teniendo en cuenta el plan de disposición de frecuencias correspondiente de la UIT (UIT-R F.497),
% en el rango de frecuencias de trabajo, 12.75 - 13.25 GHz, se 
% transmiten 8 canales con alternancia de polarizaciones. 
% Las bandas de guarda a extremos son 15 y 23 MHz, y entre direcciones de 70 MHz.
N =8;
roll_off =1.4;
% Separacion_canal = (1+roll_off)*()

% Las estaciones terminales transmiten 20 dBm de potencia. 
Ptx_dBm = 20;
% Las antenas de todas las estaciones presentan una ganancia de 39dB en polarización horizontal, 
G_dB = 39;
% y se encuentran conectadas a través de un cable coaxial que presenta 4 dB de pérdidas. 
Lt_dB = 4;
Lt = 10^(Lt_dB/10);

MTTR = 5;
MTBF = 10^5;
%La figura de ruido de los receptores es 4,5 dB. La indisponibilidad total máxima es de 0,025%,
% asumiendo que en cualquier estación se necesita al menos una C/N = 18 dB 
F_receptor_dB = 4.5;
f_receptor = 10^(F_receptor_dB/10);
q=0.025;
C_N_umbral = 18;
% 1) Calcular la velocidad binaria máxima que se puede ofrecer con el plan de frecuencias, 
% si la modulación es QPSK y el factor del filtro es 1,4. 
M =4;
Boltzman    = 1.381e-23;

Guarda_1               = 15e6;
Separacion_canal       = 28e6;
Separacion_direcciones = 70e6;
Guarda_2               = 23e6;

BW_total = Guarda_1 +(N-1)*Separacion_canal +Separacion_direcciones + (N-1)*Separacion_canal;
Rb_bps = (BW_total*log2(M))/(1+roll_off)


% 2) Calcular el campo eléctrico que se recibe en cada vano en condiciones normales de propagación. 
% Datos: Considerar como velocidad binaria la máxima posible y atenuador variable frente a desvanecimientos;
% R0.01=35mm/h

R_001 = 35;
Bn    = Rb_bps/(log2(M));

T0 = 290;
T_despues_lt = T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(f_receptor-1)
Umbral_dBm   = C_N_umbral + 10*log10(T_despues_lt*Boltzman*Bn) +30;

f = f/(1e9);Distancia =Distancia/1000;

K_lluvia = 0.03041
R_001    = 29;         
Alpha    = 1.1586;     

Gamma_r  = K_lluvia* R_001^Alpha %dB/Km
Deff     = (Distancia)./(0.477*(Distancia.^0.633)*(R_001^(0.073*Alpha))*(f^(0.123))-10.579*(1-exp(-0.024*Distancia))); %Km
F_001    = Gamma_r * Deff % dB

if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);

Fq_dB   = F_001*C1*(q^(-(C2+C3*log10(q))));
f       = f*(1e9);Distancia =Distancia*1000;

gamma_gases = 0.4;
Lgases_dB   = gamma_gases*Distancia/1000;

Lbf_dB = 20*log10((4*pi*Distancia)/lambda);
Lb     = Lbf_dB + Lgases_dB;
Prx_dB = Ptx_dBm + G_dB - Lt_dB - Lb + G_dB - Lt_dB

PIRE_dBm      = Ptx_dBm + G_dB - Lt_dB;
Flujo_dBm     = (PIRE_dBm)-10*log10((4*pi.*Distancia.*Distancia)) -Lgases_dB -Fq_dB
Flujo =10.^(Flujo_dBm/10);
e       = sqrt(Flujo*120*pi)