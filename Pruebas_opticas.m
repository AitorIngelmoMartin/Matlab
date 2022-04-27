Corriente = 0.146e-3;
Resistencia = 100;

Potencia_extincion_mW = 1000*((Corriente^2) * Resistencia)

Potencia_extincion_dBm = 10*log10(Potencia_extincion_mW)
Potencia_FP_dBm = -9.06;

Relacion = Potencia_Max_dBm - Potencia_extincion_dBm  

Corriente = 0.2e-3;

Potencia_extincion_mW = 1000*((Corriente^2) * Resistencia)

Potencia_extincion_dBm = 10*log10(Potencia_extincion_mW)
Potencia_DFP_dBm =  -4.68 ;

Relacion = Potencia_Max_dBm - Potencia_extincion_dBm 



Ganancia = 12.25 --4.68

% Ganancia = 10*log10(Ganancia)
SN1 = 12.25 - -35.36
SN2 = 12.25 - (-42.36)%(-7.36)
F = SN2-SN1

