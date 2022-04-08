
CNR_dB = Eb_N0_dB + 10*log10(Rb_bps/Bn);

Thx_dBm  = CNR_dB + 10*log10(T_antes_dispositivo*Boltzman*Bn) +30

% En Lvbl Prx = MD+ Thx

Prx_dBm = Ptx_dBm + G1_dB + G2_dB - Lb_dB -Lt1_dB -Lt2_dB
% Donde U_lluvia es q
UR_total_enlace = U_equipos + U_lluvia
    
    U_equipos = 2*(MTTR/MTBF)*100 
    % CUIDADO: El dos es porque los dos equipos son iguales.
   
