clc;clear

f       = f/(1e9);
R_001   = 29;       % mm/Km
Alpha = 1.0025;     %Tabulando casi a 20 en PV

Gamma_r  = K* R_001^Alpha %dB/Km
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

if(q == 0.01)
Fq = F_001; % ya que q=0.01
end
Fq_PH = F_001_PH*C1*(q^(-(C2+C3*log10(q))));