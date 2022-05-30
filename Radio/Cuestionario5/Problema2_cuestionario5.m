clear;close all;clc;

f           = 5e9;
lambda      = 3e8/f;
Prx_min_dBm =-80;
Ptx_dBw     = -15;
G_dB        = 27;

Epsilon_relativa = 15;
Conductividad    = 0.001;
Polarizacion     = "horizontal";

h1 = 10;
h2 = 8;
Distancia = 21000;
R0        = 6370000;

K = 4/3;
termino1 = K*R0+h1;
termino2 = K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;
Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

P = (2/3^0.5)*(((K*R0*(h1+h2)+(Distancia^2)/4)))^0.5; 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*Distancia)/P^3);
    d1   = Distancia/2+P*cos((pi+Thau)/3);
    d2=Distancia-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*Distancia)/P^3);
    d2   = Distancia/2+P*cos((pi+Thau)/3);
    d1=Distancia-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi = atan(H1/d1);
Phi_lim =(5400/(f/1000))^(1/3);

if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"  
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
    R=K*R0;    
    if(Polarizacion == "horizontal")
       X = ((pi/(lambda*R*R))^(1/3))*Distancia;
       Y2=2*(((pi*pi)/(lambda*lambda*R))^(1/3))*h2
       Y1=2*(((pi*pi)/(lambda*lambda*R))^(1/3))*h1
       if(X>=1.6)
          F = 11 + log10(X) -17.6*X
       else
          F = -20*log10(X) - 5.6488*(X^(1.425))
       end
       
       if(Y1>2)
          G1 = 17.6*sqrt(Y2-1.1) -5*log10(Y2-1.1) -8          
       else
          G1 = 20*log10(Y1+0.1*Y1*Y1*Y1)
       end
              if(G1<(2 +20*log10(K)))
                G1 = 2 +20*log10(K);
              end
       if(Y2>2)
          G2 = 17.6*sqrt(Y1-1.1) -5*log10(Y-1.1) -8          
       else
          G2 = 20*log10(Y2+0.1*Y2*Y2*Y2)
       end
              if(G2<(2 +20*log10(K)))
                G2 = 2 +20*log10(K);
              end       
    Ldif_dB = -F -G1 -G2   
    end   
end

PIRE_dBw = Ptx_dBw + G_dB;
Lbf_dB   = 20*log10((4*pi*Distancia)/lambda);
Lad_dB   = Lbf_dB + Ldif_dB;
Prx_dBw  = PIRE_dBw - Lad_dB + G_dB;

Prx_W = 10^(Prx_dBw/10);

Prx_necesaria_w   = (1/1000)*10^(-80/10);
Prx_necesaria_dBw = 10*log10(Prx_necesaria_w);

Prx_mW  = Prx_W*1000;
Prx_dBm = 10*log10(Prx_mW)

if(Prx_W<Prx_necesaria_w)
    "No es viable";
else
    "Es viable"
end

