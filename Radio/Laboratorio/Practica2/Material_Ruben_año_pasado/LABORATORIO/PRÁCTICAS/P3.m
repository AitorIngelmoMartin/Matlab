close all
clear 

n=5;
Flujo=-94;%dBW/m^2
PIREsaturacion=48;%dBW
GTsatelite=7.5;
GTterrena= 21;
Lad=0.2;
Lpol=0.2;

theta=25;

R_001=35;%mm/h

d=38223e3;
Luplink=0.17;
Ldownlink=0.12;
Inclinacion=25;
Latitud=46;

IBO= -5;
OBO= -1.908;

% IBO=[-4 -5 -6 -7 -8];
% OBO=[-1.504 -1.908 -2.383 -2.925 -3.531];

c=3e8;
fAsc=14e9;
fDesc=11e9;

landaAsc=c/fAsc;
landaDesc=c/fDesc;

Lbfa=20*log10((4*pi*d)/landaAsc);
Lbfd=20*log10((4*pi*d)/landaDesc);

Ma=Lad+Lpol+Luplink;
Md=Lad+Lpol+Ldownlink;

gammaO = 0.018;
Lgases = gammaO/sind(theta);

Lb_asc = Lbfa+Ma+Lgases;
Lb_desc = Lbfd+Md+Lgases;

K=1.38e-23;

CI = 11.248;
% CI = [10.098 11.248 12.440 13.624 14.756];
ci=10^(CI/10);

Rbreal=5e6*(7/4);
BER=10^-6;

anchobandatranspo= 1.4*BER;
anchobandaruido=Rbreal/2;

cio=ci*anchobandaruido;
CIo=10*log10(cio);

PIREtotal=Flujo+10*log10(4*pi*(d^2))+Lad+Luplink+Lpol;
PIREasc=PIREtotal-10*log10(n);
PIREdesc=PIREsaturacion-10*log10(n);

CNa=PIREasc-IBO-Lbfa-Ma+GTsatelite-10*log10(K);
cna=10^(CNa/10);

CNd=PIREdesc-OBO-Lbfd-Md+GTterrena-10*log10(K);
cnd=10^(CNd/10);

cnt=1/((1/cna)+(1/cnd)+(1/cio));
CNt=10*log10(cnt);

alpha = 1.1396
k = 0.03738
q=0.01
ho= 2.96;
hS=0,
Lat =46;
 
%PASO 2 (Depende de la frecuencia, polarizaci√≥n y R_001)
gamma_R = k*R_001^(alpha)%dB/km 
 
 
%PASO 3 ENLACE ESPACIAL
hR = ho+0.36; %[km]
 
%Para el calculo de la Ls
if(theta>=5)
   L_s = (hR-hS)/(sind(theta)); %seno de angulo, pero como esta en grados sind
else
    Re = Ro*K;
    L_s = (2*(hR-hS))/(sqrt(sind(theta)^2+(2*(hR-hS)/Re))+sind(theta));   
end
LG = L_s*cosd(theta);
 
%Calculo de la r_0.01
r_001 = 1/(1+0.78*sqrt(LG*gamma_R/(fDesc/1e9))-0.38*(1-exp(-2*LG)));
 
%Calculo de la L_r
if(atand((hR-hS)/(LG*r_001))>theta)
   L_r = LG*r_001/cosd(theta);
else
   L_r = (hR-hS)/sind(theta);   
end
 
%Calculo de epsilon
if(abs(Lat)<36)
   epsilon = 36-abs(Lat);
else
   epsilon = 0;   
end
 
V_001 = 1/(1+sqrt(sind(theta))*(((31*(1-exp(-theta/(1+epsilon)))*sqrt(L_r*gamma_R))/(4/1e9)^2-0.45)))
deff = L_r*V_001;
 
%PASO 4
F_001 = gamma_R*deff;
 
%PASO 5
if(q>=1 || abs(Lat)>=36)
   beta = 0;  
elseif (q<1 && abs(Lat)<36 && theta>=25)
   beta = -0.005*(abs(Lat)-36);   
else
   beta = -0.005*(abs(Lat)-36)+1.8-4.25*sind(theta); 
end
 
%ATENUACION=Fq
Fq = F_001*(q/0.001)^(-(0.655+0.033*log(q)-0.045*log(F_001)-beta*(1-q)*sind(theta)))



%% 
close all
clear

n=5;
Flujo=-94;%dBW/m^2
PIREsaturacion=48;%dBW
GTsatelite=7.5;
GTterrena= 21;
Lad=0.2;
Lpol=0.2;

theta=25;

R_001=35;%mm/h

d=38223e3;
Luplink=0.17;
Ldownlink=0.12;
Inclinacion=25;
Latitud=46;
K = 1.35*10^-23;

IBO= -6;
OBO= -2.383;

c=3e8;
fAsc=14e9;
fDesc=11e9;

landaAsc=c/fAsc;
landaDesc=c/fDesc;

Lbfa=20*log10((4*pi*d)/landaAsc);
Lbfd=20*log10((4*pi*d)/landaDesc);

Ma=1.5;
Md=1.5;

La=Lad+Lpol+Luplink;
Ld=Lad+Lpol+Ldownlink;

L = Lad+Lpol+Luplink+Ldownlink;

PIREtotal = Flujo + 10*log10(4*pi*d^2)+L;

PIREasc = PIREtotal - 10*log(n);

CNoasc = PIREasc-IBO-Lbfa-La-Ma+GTsatelite-10*log10(K);

PIREdesc = PIREsaturacion-10*log(n);

CNodesc = PIREdesc-OBO-Lbfd-Ld-Md+GTterrena-10*log10(K);
