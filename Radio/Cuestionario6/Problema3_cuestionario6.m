clear;close all;clc;

% **************** DESVANECIMIENTO POR LLUVIA *****************
<<<<<<< Updated upstream
f    = 14;
R0   = 6370000;
K    = 0.0374;
Re   = K*R0;
hs   = 368/1000; %Km
h0   = 2.33; %Km
=======
f  = 14e9;
c  = 3e8;
R0 = 6370000;
K  = 0.0374;
Re = K*R0;
hs = 368/1000;
h0 = 2.33; %Km
>>>>>>> Stashed changes
Lat  = 36.71;
Long = 5.7;
Angulo_elev = 27.3; %Grados
Distancia   = 38920; % Km
f           = 14;
G_dBi   = 27;
G_dB    = G_dBi - 2.14;
Ptx_dBw = 5;
R_001   = 38.89;% mm/H
Alpha   = 1.1396;
hr      = (h0+0.36) %Km
<<<<<<< Updated upstream
MD_dB   = 34;
=======
>>>>>>> Stashed changes

Lespecifica_lluvia = K * R_001^Alpha  % dB/Km

if(Angulo_elev>=5)
   Ls = (hr-hs)/sind(Angulo_elev) % metros 
else
<<<<<<< Updated upstream
   Ls = (2*(hr-hs)/(sqrt((sin(Angulo_elev))^2)+ (2*(hr-hs))/Re) +sind(Angulo_elev));
end

Lg       = Ls*cos(Angulo_elev)
r_001    = 1/(1 + 0.78*sqrt((Lg*Lespecifica_lluvia)/f) - 0.38*(1-exp(-2*Lg)))
arcotang = atan((1000*hr - hs)/(Lg*r_001));
=======
   Ls = (2*(ht-hs)/(sqrt((sind(Angulo_elev))^2)+ (2*(hr-hs))/Re) +sin(Angulo_elev))
end

Lg       = Ls*cosd(Angulo_elev)
r_001    = 1/(1 + 0.78*sqrt((Lg*Lespecifica_lluvia)/(f)) - 0.38*(1-exp(-2*Lg)))
arcotang = atand((hr-hs)/(Lg*r_001));
>>>>>>> Stashed changes

if(arcotang >Angulo_elev)
    Lr = (Lg*r_001)/(cosd(Angulo_elev)) 
else
<<<<<<< Updated upstream
    Lr = (1000*hr - hs)/sin(Angulo_elev)
=======
    Lr = (hr -hs)/(sind(Angulo_elev))
>>>>>>> Stashed changes
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
    Beta = -0.005*(Lat -36) +18 -4.25*sin(Angulo_elev)
end

Fq =F_001*(q/0.01)^(-(0.655 + 0.033*log(q)-0.045*log(F_001)))
