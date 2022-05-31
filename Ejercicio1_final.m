clc;clear;

% f =
% lambda = 3e8/f;

% Gamma_gas =
% Alpha     =
% K         =

% RUIDOS----------
T0       = 290;
Boltzman = 1.381e-23;
% F_receptor_dB =
% F_receptor    = 10^(F_receptor_dB/10);

% G_dB =
% G    = 10^(G_dB/10);

% Lt_dB =
% Lt    = 10^(Lt_dB/10);
% ----------
T_antes_dispositivos = T_antena + T0*(Lcable - 1) + T0*(Freceptor-1)*(Lcable);
                  %Es la temperatura inmediatamente a continuacon de la antena

% VANOS INTERFERENCIA-----------------------

Distancia = [11 6 14]*1e3;
Lgas_dB   = Gamma_gas*Distancia/1000;
Lbf_dB    = 20*log10((4*pi*Distancia)/lambda);
Lb_dB     = Lgas_dB + Lbf_dB;

% degradacion sin interferencia, en caso de haber CIR + degradacion
Umbral_dBm = Eb_N0 + 10*log10(K*T_antes_dispositivos*Rb) + degradacion + 30;
Umbral_dBm = C_N_umbral + 10*log10(T_antes_dispositivos*Boltzman*Bn)   + 30;

Prx_dBm =  Ptx_dBm +G_dB - Lt_dB - Lb_dB + G_dB - Lt_dB
Umbral_real_dBm  = Prx_dBm - MD
Umbral_ideal_dBm = Eb_No_ideal  + 10*log10(T_despues_lt*Boltzman*Rb) + 30
% -----------------------------

PIRE_dBm = Umbral_dBm + Lb_dB - G_dB + Lt_dB ;

% Repartir q entre varios vanos de forma equitativa
    % equipos = [2 2];
    % q_total = U_total -((sum(equipos))*(MTTR/MTBF)*100);
    % for i = 1:iteraciones
    %  q(i) = q_total*Distancia(i)/(sum(Distancia)); % q_total va sin equipos
    % end
% -------------------------------------------------