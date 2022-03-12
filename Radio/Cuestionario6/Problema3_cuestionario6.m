clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
R0 = 6370000;
K  = 0.0374;
Re = K*R0;
hs = 368/1000;
h0 = 2.33; %Km

Lat  = 36.71;
Long = 5.7;
Angulo_elev = 27.3; %Grados
Distancia   = 38920; % Km
f       = 14;
R_001   = 38.89;% mm/H
Alpha   = 1.1396;
hr      = (h0+0.36) %Km

Lespecifica_lluvia = K * R_001^Alpha  % dB/Km

if(Angulo_elev>=5)
   Ls = (hr-hs)/sind(Angulo_elev) % metros 
else
   Ls = (2*(hr-hs)/(sqrt((sind(Angulo_elev))^2)+ (2*(hr-hs))/Re) +sind(Angulo_elev));
end

Lg       = Ls*cosd(Angulo_elev)
r_001    = 1/(1 + 0.78*sqrt((Lg*Lespecifica_lluvia)/(f)) - 0.38*(1-exp(-2*Lg)))
arcotang = atand((hr-hs)/(Lg*r_001));

if(arcotang >Angulo_elev)
    Lr = (Lg*r_001)/(cosd(Angulo_elev)) 
else
    Lr = (hr -hs)/(sind(Angulo_elev))
end

Lat = abs(Lat);

if(Lat<36)
    Epsilno  = 36 - Lat; 
else
    Epsilon  =0; 
end

termino3 = (31*(1-exp(-(Angulo_elev)/(1+Epsilon))*sqrt(Lr*Lespecifica_lluvia)))/(f*f)
V_001    = 1/(1+sqrt(sind(Angulo_elev))*(termino3-0.45))
Deff     = (Lr*V_001) %Km
F_001    = Lespecifica_lluvia*Deff %dB

q = 0.1;

if(q>=0.01 || Lat>=36)
   Beta=0
else
    if(q<0.01 && Lat< 36 && Angulo_elev>=25)
        Beta = -0.005*(Lat -36)
    end
    Beta = -0.005*(Lat -36) +18 -4.25*sind(Angulo_elev)
end

Fq =F_001*(q/0.01)^(-(0.655 + 0.033*log(q)-0.045*log(F_001)))
