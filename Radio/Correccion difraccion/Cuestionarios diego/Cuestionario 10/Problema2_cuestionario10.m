clc;clear;

c = 3e8;
f = 13e9;
lambda = c/f;

G_dB = 39;
G= 10^(G_dB/10);

Lt_dB = 4;
Lt = 10^(Lt_dB/10);

figura_ruido_rf_dB = 4.5;
figura_ruido_rf = 10^(figura_ruido_rf_dB/10);

C_N = 18;
roll_off = 1.4;

R_001 = 35;
alpha = 1.0901;
k = 0.03266;

"CAG"

Ptx_dBm = 20;

dvano1 = 27e3;
dvano2 = 19e3;

MTTR = 5;
MTBF = 10e5;

Utotal = 0.025;

% 1) Calcular la velocidad binaria máxima que se puede ofrecer
% con el plan de frecuencias, si la modulación es QPSK y el factor
% zdel filtro es 1,4. 

%2) Calcular el campo eléctrico que se recibe en cada vano en condiciones 
% normales de propagación. Datos: Considerar como velocidad binaria la máxima
% posible y atenuador variable frente a desvanecimientos; R0.01=35mm/h



