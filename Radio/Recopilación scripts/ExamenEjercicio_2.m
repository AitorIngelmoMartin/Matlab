clear;close all;clc;

f   = 28.5e9;
c   = 3e8;
lambda = c/f;

Polarizacion = "Horizontal"

R0  = 6370000;
K   = 4/3;
Re  = K*R0;
h1  = 277;
h2  = 91;

Distancia = 21e3;

% Ptx_dBw = 2;
% Ptx_W   = 10^(Ptx_dBw/10);
% 
% Ptx_dBm = 55;
% Ptx_W   = (1/1000)*10^(Ptx_dBm/10);

% Cadena de potencias
Lt_dB = 1;
    Lt = 10^(Lt_dB/10);
G_dB = 42.8-23;
    G = 10^(G_dB/10);

G_LNA_dB = 15;
   G_LNA = 10^(G_LNA_dB/10);
F_LNA_dB =5;
   F_LNA = 10^(F_LNA_dB/10);
Lmezclador_dB = 8;
  Lmezclador = 10^(Lmezclador_dB/10);
   
%  LLuvias  
     K_lluvia =0.2224;
     Alpha = 0.9580; 
     R_001 =18;% mm/Km
    %Tabulando casi a 20 en PV
     CAG_dB = 18;
     MD_dB = CAG_dB;
% horas
MTTR  = 104;
MTBF =  880000;

% Ruidos
T0 = 290;
Boltzman = 1.381e-23;
Degradacion = 1.5;
M           = 16;
CNR_dB      = 11;
Rb_bps      = 40e6;
Bn          = Rb_bps/(log2(M));

% Pérdidas

 gamma_gases = 0.23;
 Lgases_dB   = gamma_gases*Distancia/1000;
 Lbf_dB      = 20*log10(4*pi*Distancia/lambda);

 
 f       = f/(1e9);Distancia =Distancia/1000;

Gamma_r  = K_lluvia* R_001^Alpha %dB/Km
Deff     = (Distancia)/(0.477*(Distancia^0.633)*(R_001^(0.073*Alpha))*(f^(0.123))-10.579*(1-exp(-0.024*Distancia))) %Km

F_001    = Gamma_r * Deff % dB

if(f>=10)
 C0 = 0.12+0.4*log10((f/10)^0.8);
else
 C0 = 0.12;    
end

C1 = (0.07^C0)  * (0.12^(1-C0));
C2 = (0.855*C0) + 0.5446*(1-C0);
C3 = (0.139*C0) + 0.043* (1-C0);


% Fq_dB   = F_001_PH*C1*(q^(-(C2+C3*log10(q))))

% Calcular q -----------------------------------
logaritmo = log10(MD_dB/(F_001*C1));

soluciones_x =  [( -C2 + sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3),( -C2 - sqrt( C2*C2 -4*logaritmo*C3 ) )/(2*C3)];
x =max(soluciones_x);
q_calculado = 10^x

U_equipos_total = 2*(MTTR/MTBF)*100
U_total = U_equipos_total +q_calculado


Fq_dB = CAG_dB;

U = 15 + 30*log10(f);

if (f>8 && f<=20)
    V = 12.8*f^0.19;
elseif (f>20 && f<=35)
    V = 22.6;
end

XPD_ll = U - V*log10(Fq_dB)

T_despues_Lt =  T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(F_LNA-1) +T0*(Lmezclador-1)*(1/G_LNA)

Thx_dBm  = CNR_dB + 10*log10(T_despues_Lt*Boltzman*Bn) +30

PIRE_dBm = Thx_dBm - G_dB + Lt_dB + Lbf_dB + Lgases_dB + Lt_dB - G_dB

PIRE_w = (1/1000)*(10^(PIRE_dBm/10))
Distancia = Distancia*1000;f = f*(1e9);

FLUJO_w = PIRE_w/(4*pi*Distancia)

EespacioLibre     = sqrt(FLUJO_w*120*pi)

EespacioLibre_dBu = 20*log10(EespacioLibre/1e-6)
Fq_PH = Fq_dB;
XPD_dB = 0--30;
Prx_CP_PH_dBm = PIRE_dBm - Lbf_dB - Lgases_dB - Fq_PH + G_dB - Lt_dB

Prx_XP_PH_dBm = PIRE_dBm - Lbf_dB - Lgases_dB - Fq_PH + G_dB - Lt_dB - XPD_dB - XPD_ll 

PIRE_parasita_dBm = Prx_XP_PH_dBm + G_dB - Lt_dB

Eparasito_total_dBu = EespacioLibre_dBu - MD_dB - XPD_ll
