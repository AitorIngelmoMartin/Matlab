% Si TDMA --> No hay IBO ni OBO, y por tanto tampoco CN0. 
% Si radio difusion -->1 sola portadora que llega a todas las estaciones,
% trabajando en saturacion.

C_N0up_down =  PIRE_up_down - Lbf_dB_up_down - Lad_dB_up_down - Margen_up_down + G_T -10*log10(Boltzsman) 

% C/N0 posiles

C_N0_total_dB = Eb_No_total_dB + 10*log10(Rb)
C_N0_down_dB  = PIRE_satelite_dBw - Lbf_down_dB - Lad_down_dB - Margen_down_dB + G_T_estacion - 10*log10(Boltzmann);
C_N0_up   = PIRE_up   + IBO_tpdr - Lbf_up_dB - Lgas_up_dB   - Margen_up_dB   + G_T_sat_dB     - 10*log10(Boltzmann);

% Degradacion
%                   ascendente, en descendente es C_N0_up_dB 
L              = C_N0_total_dB - C_N0_down_dB % Si no es mayor de 3 db, no es enlace asimétrico
Incremento_C_N = -10*log10(10^(-L/10)-1)

% PIRE max con lluvia
PIRE_cielo_claro    = C_N0_up_dB + Lbf_up_dB + Margen + Lad_up_dB - G_T_satelite_dB + 10*log10(Boltzmann);
PIRE_max_con_lluvia = PIRE_cielo_claro + F_001_up; %sumando las perdidas maximas por lluvia

PIRE_total    = Flujo_satelite_dBw + 10*log10(4*pi*(Distancia^2)) + Lgas_up_dB + Margen_up_dB;
IBO_portadora = 10*log10(BW_portadora/sum(BW_portadora))
% IBO_transpondedor = "dato"

PIRE_up    = PIRE_total + IBO_transpondedor + 10*log10(BW_portadora/sum(BW_portadora));
PIRE_down  = PIRE_saturacion_dBw + 10*log10(BW_portadora/sum(BW_portadora));

% BW_total_portadoras = BW_transpondedor-2*BW_guarda;
Roll_off     = (BW_portadora)/((Rb*(1/FEC))/(log2(M))) - 1;
BW_portadora = (1+roll_off)*(Rb*(1/FEC))/log2(M);


% En FDMA
c_n0_total  = 1./(1./(10.^(C_N0_up./10)) + 1./(10.^(C_N0_down./10)) + 1./(10.^(C_I0./10)));