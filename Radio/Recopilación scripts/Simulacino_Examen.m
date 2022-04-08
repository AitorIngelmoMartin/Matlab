clear;close all;clc;

f   = 32e9;
c   = 3e8;
lambda = c/f;

% Polarizacion = "Horizontal"
Polarizacion = "Vertical"

R0  = 6370000;
K   = 4/3;
Re  = K*R0;
h1  = 277;
h2  = 91;

Distancia = 35e3;
%
% Ptx_dBw = 2;
% Ptx_W   = 10^(Ptx_dBw/10);

Ptx_dBm = 55;
Ptx_W   = (1/1000)*10^(Ptx_dBm/10);

% Cadena de potencias
Lt_dB = 1;
    Lt = 10^(Lt_dB/10);
% G_dB = 15-5;
%     G = 10^(G_dB/10);

G1_dB = 15-5;
    G1 = 10^(G1_dB/10);
G2_dB = 50;
    G2 = 10^(G2_dB/10);

G_LNA_dB = 25;
   G_LNA = 10^(G_LNA_dB/10);
F_LNA_dB =5;
   F_LNA = 10^(F_LNA_dB/10);
Lmezclador_dB = 12;
  Lmezclador = 10^(Lmezclador_dB/10);

% en S/m
Conductividad =5;
Permeavilidad_terreno=70;

% Si dan rugosidad:
    Rugosidad =0;
    
%  LLuvias   
     K_lluvia =0.2646 
     R_001 =18;% mm/Km
     Alpha = 0.8981;     %Tabulando casi a 20 en PV
% horas
MTTR1=8;
MTBF1 = 3.2e5;

MTTR2 = 4;
MTBF2 = 1e6;

% Ruidos
T0 = 290;
Boltzman = 1.381e-23;
Degradacion = 1.5;
M           = 16;
CNR_dB      = 11;
Rb_bps      = 64e6;
Bn          = Rb_bps/(log2(M));
% Pérdidas

 gamma_gases = 0.09;
 Lgases_dB   = gamma_gases*Distancia/1000;
 Lbf_dB      = 20*log10(4*pi*Distancia/lambda);


%-----------------------Rugosidad

P = (2/3^0.5)*(((K*R0*(h1+h2)+(Distancia^2)/4)))^0.5; 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*Distancia)/P^3);
    d1 = Distancia/2+P*cos((pi+Thau)/3);
    d2=Distancia-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*Distancia)/P^3);
    d2 = Distancia/2+P*cos((pi+Thau)/3);
    d1=Distancia-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi_comparativo = 1000*atan(H1/d1);
Phi_lim = (5400/(f/1e6))^(1/3);
Phi     = Phi_comparativo/1000;

Epsilon0    = Permeavilidad_terreno -1i*60*Conductividad*lambda;

if(Polarizacion == "Horizontal")    
    numerador   = Epsilon0*sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    denominator = Epsilon0*sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    Rv =numerador/denominator;
else
    numerador   = sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    denominator = sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    Rh =numerador/denominator;    
end

if(Phi_comparativo>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"
%     Rugosidad = 4*pi*Rho*sin(Phi)/lambda;    
    if(Rugosidad>0.3)
        %Las pérdidas por refelxión son cero;
        "Consideramos suelo liso"
        Lref = 0;
    else
        "Tengo en cuenta la rugosidad"
        Dcaminos    = sqrt( Distancia*Distancia + abs(H1+H2)^2 ) - sqrt( Distancia*Distancia + abs(H1-H2)^2 );        
        Divergencia = ( 1 + (5*(d1/1000*d1/1000*d2/1000)/(16*K*(Distancia/1000)*H1)) )^(-0.5);
        Refectivo   = Rh*Divergencia*exp(-((Rugosidad*Rugosidad)/2));
        exponente   = (-1i*(((2*pi)/lambda))*Dcaminos);
        Lref_dB     = -20*log10(norm( 1 + (Refectivo*exp(exponente)) )) 
    end
else    
%Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
    if(Polarizacion == "Horizontal") % Caso en el que Beta =1, por eso no está
      X  = ((pi/(lambda*R*R))^(1/3))*Distancia;
      Y2 = 2*(((pi*pi)/(lambda*lambda*R))^(1/3))*h2
      Y1 = 2*(((pi*pi)/(lambda*lambda*R))^(1/3))*h1
       if(X>=1.6)
         F = 11 + log10(X) -17.6*X
       else
         F = -20*log10(X) - 5.6488*(X^(1.425))
       end
       
       if(Y1>2)
         G1 = 17.6*sqrt(Y2-1.1) -5*log10(Y2-1.1) - 8          
       else
         G1 = 20*log10(Y1+0.1*Y1*Y1*Y1)
       end
       if(G1<(2 +20*log10(K)))
         G1 = 2 +20*log10(K);
       end
       
       if(Y2>2)
          G2 = 17.6*sqrt(Y1-1.1) -5*log10(Y-1.1) - 8          
       else
          G2 = 20*log10(Y2+0.1*Y2*Y2*Y2)
       end
       
       if(G2<(2 + 20*log10(K)))
          G2 = 2 + 20*log10(K);
       end
       
    Ldif_dB = - F - G1 - G2   
    end
end
    
% --------------LLuvia
Distancia = Distancia/1000; f=f/(1e9);

Gamma_r  = K_lluvia* R_001^Alpha %dB/Km
Deff     = (Distancia)/(0.477*(Distancia^0.633)*(R_001^(0.073*Alpha))*(f^(0.123))-10.579*(1-exp(-0.024*Distancia))) %Km

F_001    = Gamma_r * Deff % dB
q = 0.01;
MD_dB = F_001;

 U_equipo1 = (MTTR1/MTBF1)*100
 U_equipo2 = (MTTR2/MTBF2)*100
 
G_LNA_dB = 25;
   G_LNA = 10^(G_LNA_dB/10);
F_LNA_dB =5;
   F_LNA = 10^(F_LNA_dB/10);
Lmezclador_dB = 12;
  Lmezclador = 10^(Lmezclador_dB/10);
 
 
T_antes_dispositivo = T0*(1/Lt) + T0*(Lt-1)*(G_LNA/Lt) + T0*(F_LNA-1)*G_LNA + T0*(Lmezclador-1)

T_despues_lt =  T0*(1/Lt) + T0*(Lt-1)*(1/Lt) + T0*(F_LNA-1) +T0*(Lmezclador-1)*(1/G_LNA)

Thx_dBm  = CNR_dB + 10*log10(T_despues_lt*Boltzman*Bn) +30
Prx_dBm = Ptx_dBm + G1_dB + G2_dB - Lb_dB -Lt1_dB -Lt2_dB 