
% Pérdidas en espacio libre
Lbf_dB = 20*log10((4*pi*D)/lambda)
Lbf    = 10^(Lbf_dB/10);

% PIRE en dBw y W
PIRE_dBw = Ptx_dBw + g_dB - Lt_dB;
PIRE_w = 10^(PIRE_dBw/10);

% Flujo en dBw/m2
Flujo     = (PIRE_w)/(4*pi*D*D);
Flujo_dBw = 10*log10(Flujo)

% Campo en V
e       = sqrt(Flujo*120*pi);
e_dBu   = 20*log10(e/1e-6);

% Superficie efectiva
Seff    = ((lambda^2)/(4*pi))*g
Seff_dB = 10*log10(Seff);

% Cadena de potencia hasta terminales
Prx     = Ptx_w*g*(1/Lt)*(1/Lbf)*g*(1/Lt)
Prx_log = 10*log10(Prx)
Prx_dBw = Ptx_dBw + g_dB + g_dB -Lbf_dB -Lt_dB -Lt_dB 
