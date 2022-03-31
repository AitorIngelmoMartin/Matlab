
%% Tema 2-Test 1

%% Ej 1.

clear 
close all
h1=300;
h2=150;
cota1=0;
cota2=0;
H1=cota1+h1;
H2=cota2+h2;
d=38e3;%m
f=6.2e9;
sigma=5;% S/m
epsilon_r=70;
rho=0.5;
K=4/3;
Ro=6370*1e3;%m

dmax=sqrt(2*K*Ro*H1)+sqrt(2*K*Ro*H2);
dlim=0.1*dmax;


%H2<H1
p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4));
Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3);%PHI
d1=d/2+p*cos((pi+Phi)/3);

d2=d-d1;
hp1=H1-(d1^2/(2*K*Ro));
hp2=H2-(d2^2/(2*K*Ro));
tan_phi=hp1/d1;
phi=atan(tan_phi);%phi


% %H2>H1
% p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4));
% Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3);%PHI
% d2=d/2+p*cos((pi+Phi)/3);
% 
% d1=d-d2;
% hp1=H1-(d1^2/(2*K*Ro));
% hp2=H2-(d2^2/(2*K*Ro));
% tan_phi=hp1/d1;
% phi=atan(tan_phi);%phi

phi_lim=((5400/(f/1e6))^(1/3))/(1e3);%rad
%phi_lim=6.1691e-4 < phi=5.81e-2 -> reflexión MTC

lambda=3*10^8/f;
epsilon_o=epsilon_r-1j*60*sigma*lambda;


Ab=(2*hp1*hp2)/(d);%incremento de longitud
Gamma=(4*pi*rho*sin(phi))/(lambda);


Rv=(epsilon_o*sin(phi)-sqrt(epsilon_o-cos(phi).^2))/(epsilon_o*sin(phi)+sqrt(epsilon_o-cos(phi).^2))


D=1/sqrt(1+((5/(16*K))*(((d2/1e3)*(d1/1e3)^2)/((d/1e3)*hp1))));

Re=Rv*D*exp(-(Gamma^2)/2);

lad=1/abs(1+Re*exp(-1i*2*pi*Ab/lambda))^2
Lad=10*log10(lad)

%% Ej 12.
clear 
close all

d=34e3;
f=15e9;
G=38;
Ptx=0;%dBW
long=38;%m
alfa=5.5/100%dB/m
Lalim=0.2;
lambda=3e8/f;

Lt=long*alfa+Lalim;
PIRE=Ptx-Lt+G %dBW
Lbf=20*log10(4*pi*d/lambda)
Flujo=PIRE-10*log10(4*pi*d^2) %dBW/m2
e=sqrt(10^(Flujo/10)*120*pi);
E=20*log10(e*1e6) %dBu
Sef=lambda^2/(4*pi)*10^(G/10) %m2
Prx2a=PIRE-Lbf+G-Lt %dBW
Prx2b=Prx2a+30 %dBm

%% Tema 2 test 2

%% Ej 4
clear 
close all

f=38e9;
d=50e3;
cota1=150;
cota2=200;
h1=150;
h2=40;
cotao1=260;%O1. Obstáculo 1
cotao2=225;%O2.
dAo1=25e3;
dAo2=44e3;
K=4/3;
Ro=6370e3;


lambda=3e8/f;
%cálculo de las distintas separaciones:
%-h1-___________d1___________-O1-________d2_________-O2-______d3______-h2-
d1=dAo1;
d2=dAo2-d1;
d3=d-dAo2;

%cálculo del despejamiento (c) y el parámetro de difracción (V):
c1=(d1*(d2+d3)/(2*K*Ro)+cotao1)-((h2+cota2-h1-cota1)*d1/d+h1+cota1)
R1_1=sqrt(lambda*(d1*(d2+d3)/d))
V1=sqrt(2)*(c1/R1_1)

c2=(d3*(d2+d1)/(2*K*Ro)+cotao2)-((h2+cota2-h1-cota1)*(d1+d2)/d+h1+cota1)
R1_2=sqrt(lambda*(d3*(d2+d1)/d))
V2=sqrt(2)*(c2/R1_2)

%PREGUNTAR: V1=3.81 Y V2=-1.45->SERÍA METODO 2, NO 1 COMO DIJERON EN CLASE
%V1>V2-> O2 es el obstáculo secundario.
%V2<0->Para calcular Lad por difrac. corresponde usar el método 1. Pero
%piden c2p con el método 2:
%______________________-O1-________d2_________-O2-______d3______-h2-

cp2=(d2*d3/(2*K*Ro)+cotao2)-((h2+cota2-0-cotao1)*d2/(d2+d3)+0+cotao1)
Rp1_2=sqrt(lambda*(d3*d2/(d2+d3)))%no lo piden.
Vp2=sqrt(2)*(cp2/Rp1_2)%no lo piden.


%% Ej 10
clear 
close all

Ptx=5; %W
f=900e6;
Gtx=42;
Lt1=3;
lambda=3e8/f;

% Apartado 1: Calcular Flujo, E y Prx.
d=8e3;%m
Grx=35;
Lt2=1;

PIRE=10*log10(Ptx)-Lt1+Gtx;
flujo=10^(PIRE/10)/(4*pi*d^2) %W/m2
Flujo=10*log10(flujo) %dBW/m2

e=sqrt(flujo*120*pi) %V/m
E=20*log10(e*1e6) %dBu

Sef=lambda^2/(4*pi)*10^(Grx/10);
prx=flujo*Sef*(1/10^(Lt2/10)) %W
Prx=10*log10(prx) %dBW

% Apartado 2: Calcular Flujo, E y Prx.
d=11e3;%m
Grx=35;
Lt2=1;
Gtx=42-46%ganacia real a 30º -46.9dB

PIRE=10*log10(Ptx)-Lt1+Gtx;
flujo=10^(PIRE/10)/(4*pi*d^2) %W/m2
Flujo=10*log10(flujo) %dBW/m2

e=sqrt(flujo*120*pi) %V/m
E=20*log10(e*1e6) %dBu

Sef=lambda^2/(4*pi)*10^(Grx/10);%m2
prx=flujo*Sef*(1/10^(Lt2/10)) %W
Prx=10*log10(prx) %dBW


%% Ej 12
clear 
close all

f=100e6;
d=10e3;
ptx=100; %mW
G=6;
Lcrf=2;
long=25; %m
Lad=2;
lambda=3e8/f;
alfa=0.001*f/1e6 %dB/m

%calcular PIRE, Prx y Ltotal entre TX y RX

Ptx=10*log10(ptx); %dBm
Ltx=alfa*long+Lcrf;
PIRE=Ptx-Ltx+G %dBm

%OJO cuando pide pérdida total entre TX y RX, hay que considerar las
%ganancias también. Lo mismo para Gtotal, considerar las pérdidas.
Lrx=Ltx;
Lb=20*log10(4*pi*d/lambda)+Lad;
Ltotal=Ltx-G+Lb+Lrx-G

Flujo=PIRE-10*log10(4*pi*d^2)-Lad;
Sef=lambda^2/(4*pi)*10^(G/10);%m2
Prx=Flujo+10*log10(Sef)-Lrx %dBm

%% Tema 3 test 1

%% Ej 2 Ok
clear 
close all

f=38e9;
G=27;
Lt1=1.5;
Lt2=1.5;
%P.V.
U=-98;%dBm
Ptx=25;%dBW
%Atenuador variable
d=23;%km
R_001=24.42;%mm/h
k=0.3884;
alpha=0.8552;
gammaO=0.125;%dB/km

lambda=3e8/f;
Ro=6370;
K=4/3;

%PASO 2
gammaR=k*R_001^(alpha)%dB/km 

%PASO 3 ENLACES TERRENALES
r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff=d*r;

%PASO 4
F_001=gammaR*deff;
%PASO 5
if(f<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((f/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

% Fq=F_001*C1*q^(-(C2+C3*log10(q)));
Fq=Ptx+30-Lt1+G-U-gammaO*d-20*log10(4*pi*d*1e3/lambda)+G-Lt2;%Lbf(de en metros). Lo(d en km)
q_exponente=Fq/(F_001*C1)
%log10(q^(-(C2+C3*log10(q))))=log10(q_exponente)
%log10(q)*(-(C2+C3*log10(q))))=log10(q_exponente)
%-log10(q)*C2-C3*log10(q)^2=log10(q_exponente)
%x=log10(q)
%-x*C2-x^2*C3=log10(q_exponente) 
%-x*C2-x^2*C3-log10(q_exponente)=0 
%x=(C2(+/-)sqrt(C^2-4*C3*log10(q_exponente))/(-2*C3)

xa=(C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
xb=(C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
q1=10^xa
q2=10^xb
%otra solución despeje q:
solucion=roots([C3 C2 log10(Fq/(F_001*C1))]);
q3=10^(max(solucion))

q4=MDTinv(Fq,d,f,R_001,k,alpha)

%% Ej 6- revisar V_001 no sale 0.999 como al profe
clear 
close all

f=14e9;%en Hz aquí, ya los pasamos a otras unidades cuando haga falta más abajo
d=39000;%km para los cálculos de atenuación
hS=2.280;%cota sobre el nivel del mar en km (hs en enlaces espaciales)
Lat=19.421383 %N
Long=-99.181863;%E
theta=20;%grados
R_001=38.89;%mm/h
k=0.0374;
alpha=1.1396;
ho=4.7477;%km
Ro=6370;
K=4/3;
q=1;%en tanto por ciento, que se usa más abajo
%PASO 2
gammaR=k*R_001^(alpha)%dB/km 


%PASO 3 ENLACE ESPACIAL
hR=ho+0.36;%km
if(theta>=5)
   LS=(hR-hS)/sind(theta);%km
else
    Re=Ro*K;
    LS=(2*(hR-hS))/(sqrt(sind(theta)^2+(2*(hR-hS)/Re))+sind(theta));   
end
LG=LS*cosd(theta);%km
r_001=1/(1+0.78*sqrt(LG*gammaR/(f/1e9))-0.38*(1-exp(-2*LG)));

if(atand((hR-hS)/(LG*r_001))>theta)
   LR=LG*r_001/cosd(theta);
else
   LR=(hR-hS)/sind(theta);   
end

if(abs(Lat)<36)
   epsilon=36-abs(Lat);
else
   epsilon=0;   
end

V_001=1/(1+sqrt(sind(theta))*(((31*(1-exp(-theta/(1+epsilon)))*sqrt(LR*gammaR))/(f/1e9)^2-0.45)))
deff=LR*V_001;

%PASO 4
F_001=gammaR*deff;

%PASO 5
if(q>=1 || abs(Lat)>=36)
   beta=0;  
elseif (q<1 && abs(Lat)<36 && theta>=25)
   beta=-0.005*(abs(Lat)-36);   
    else
       beta=-0.005*(abs(Lat)-36)+1.8-4.25*sind(theta); 
end

Fq=F_001*(q/0.001)^(-(0.655+0.033*log(q)-0.045*log(F_001)-beta*(1-q)*sind(theta)))

%% Ej 7 ok
close all
f=770e6;
Ptx=35;%dBm
G=23;
Lt1=2;
Lt2=2;
cota1=75;%e(0)
cota2=60;%e(50)
h1=35;
h2=5;
cotao1=112;%e(11)
cotao2=48;%e(37)
K=4/3;
Ro=6370e3;

lambda=3e8/f;

%Apartado 1:
%calculo separaciones:
%-h1-___________d1___________-O1-_______d2________-O2-_______d3_______-h2-
d=50e3;%m
d1=11e3;
d2=37e3-d1;
d3=d-37e3;

%cálculo del despejamiento (c) y el parámetro de difracción (V):
c1=(d1*(d2+d3)/(2*K*Ro)+cotao1)-((h2+cota2-h1-cota1)*d1/d+h1+cota1)
R1_1=sqrt(lambda*(d1*(d2+d3)/d))
V1=sqrt(2)*(c1/R1_1)

c2=(d3*(d2+d1)/(2*K*Ro)+cotao2)-((h2+cota2-h1-cota1)*(d1+d2)/d+h1+cota1)
R1_2=sqrt(lambda*(d3*(d2+d1)/d))
V2=sqrt(2)*(c2/R1_2)

%V2<0->Para calcular Lad por difrac.->Método 1.


%MÉTODO 1

%Nuevo rayo de E1 a O2 :
%-h1-__________d1___________-O1-________d2_________-O2-_______d3_______-h2-

[cp1,Rp1_1,Vp1] = PF(cota1,cotao2,cotao1,h1,0,d1,d2,K,f);
[cp2,Rp1_2,Vp2] = PF(cotao1,cota2,cotao2,0,h2,d2,d3,K,f);

LadVp1=6.9+20*log10(sqrt((Vp1-0.1)^2+1)+Vp1-0.1);
LadVp2=6.9+20*log10(sqrt((Vp2-0.1)^2+1)+Vp2-0.1);
correccion=10*log10(((d1+d2)*(d2+d3))/(d2*d));
Lad=LadVp1+LadVp2+correccion

%FORMULAS DEL METODO 2
% p=V1;
% q=V2;
% tan_alpha=((d*d2)/(d1*d3))^(0.5);
% alpha=atan(tan_alpha);%debe estar en rad.
% Tc=(12-20*log10(2/(1-alpha/pi)))*(q/p)^(2*p);
% 
% LadVp2=6.9+20*log10(sqrt((Vp2-0.1)^2+1)+Vp2-0.1);
% LadV1=6.9+20*log10(sqrt((V1-0.1)^2+1)+V1-0.1);
% Lad=LadVp2+LadV1-Tc

%cálculo de potencias:
PIRE=Ptx-Lt2+G;%dBm
Lbf=20*log10(4*pi*d/lambda);
Prx=PIRE-Lbf-Lad+G-Lt1 %dBm

%Apartado 2: h2 para despejamiento suficiente.
   
h2mod=h2;
V1mod=V1;
 while (V1mod > -0.78)
       
      h2mod = h2mod+0.01;
      [c1mod,R1_1mod,V1mod] = PF(cota1,cota2,cotao1,h1,h2mod,d1,d2+d3,K,f);
      end 
    

%% Ej 12
clear 
close all

f=200e6;
Ptx=27; % dBm
d2=500;%m
E=57; %dBu
Am=1.15*(f/1e6)^0.43 %f en MHz
%P.V.
G=15;
Lt1=2;

gamma=7e-2 %dB/m. De la gráfica correspondiente.
Lv=Am*(1-exp((-d2*gamma)/Am))
E1=E+Lv
PIRE=Ptx-Lt1+G; %dBm
pire=10^(PIRE/10)/1e3; %W
e1=10^(E1/20)/1e6; %V/m
d1=sqrt(30*pire)/e1;
d=d1+d2
%otra forma:
%E(dBu)=74.8+PIRE(dBW)-20*lg(d(km))-Lad
dist=10^((E-74.8-(PIRE-30)+Lv)/20)

%% Tema 3 test 2

%% Ej 1 ok
clear 
close all

%Radioenlace terrenal.
d=23;%km para los cálculos de lluvia
f=38e9;
Grx=27;
Gtx=27;
%P.V.
Lt1=1.5;
Lt2=1.5;
U=-98;%dBm
Ptx=25;%dbW

lambda=3e8/f;

q=0.01;%en tanto por cien
XPDant=30;
gammaO=0.125;%dB/km
R_001=24.42;%mm/h
k=0.3884;
alpha=0.8552;

%Desvanecimiento por lluvia:
Ro=6370;
K=4/3;

%PASO 2
gammaR=k*R_001^(alpha)%dB/km 

%PASO 3 ENLACES TERRENALES
r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/10^9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff=d*r;

%PASO 4
F_001=gammaR*deff;
%PASO 5
if(f<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((f/10^9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=F_001*C1*q^(-(C2+C3*log10(q)));

PIRE=Ptx-Lt1+Gtx %dBW
Lo=gammaO*d;%atenuación por gases
Flujo=PIRE-10*log10(4*pi*(d*1e3)^2)-Lo-Fq;%dBW
flujo=10^(Flujo/10);%W/m2
e=sqrt(flujo*120*pi) %V/m
E=20*log10(e*1e6) %dBu
Erxv=E;%dBu, el campo deseado desvanecido (antes de amplificar)

XPDll=15+30*log10(f/1e9)-22.6*log10(Fq);
Erxh=Erxv-XPDll %dBu Componente parásita provocada por XPDll

erxh=10^(Erxh/20)/1e6;%V/m
flujoH=erxh^2/(120*pi);%W/m2
FlujoH=10*log10(flujoH);%dBW
Sefxpd=lambda^2/(4*pi)*10^((Grx-XPDant)/10);%m2
Prxv_p=FlujoH+10*log10(Sefxpd)-Lt2 %dBW Potencia vertical parásita por Eh
                                   %(-163.2841dBm)-> OK
                                  
erxv=10^(Erxv/20)/1e6;%V/m
flujoV=erxv^2/(120*pi);%W/m2
FlujoV=10*log10(flujoV);%dBW
Sef=lambda^2/(4*pi)*10^(Grx/10);%m2
Prxv_d=FlujoV+10*log10(Sef)-Lt2;%dBW Potencia deseada (-111.6308dBm)->OK

XPI=Prxv_d-Prxv_p %dB. también XPI=XPDll+XPDant (51.6533dB)-> OK


%% Ej 2 OK
clear 
close all

d=35;%km
ptx=2;%W
long=10;%m
alphacoax=0.076;%dB/m
%P.H.
Gtx=24;
Grx=24;
f=18e9;
U=-96;%dBm
%Atenuador variable en RX
MTBF=1e6;%horas
MTTR=40;%horas

gammaO=0.0606;%dB/km
R_001=28.64;%mm/h
k=0.0771;
alpha=1.0025;

Ro=6370;%km
K=4/3;

lambda=3e8/f;

%determino el MD:
PIRE=10*log10(ptx)+30-alphacoax*long+Gtx;%dBm
Lbf=20*log10(4*pi*d*1e3/lambda);
Lo=gammaO*d;
Lt2=alphacoax*long;
Fq=PIRE-U-Lbf-Lo+Grx-Lt2;%MD



%PASO 2
gammaR=k*R_001^(alpha);%dB/km 

%PASO 3 ENLACES TERRENALES
r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff=d*r;

%PASO 4
F_001=gammaR*deff;
%PASO 5
if(f<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((f/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);


solucion=roots([C3 C2 log10(Fq/(F_001*C1))]);
q=10^(max(solucion));

URlluvia=q;

URequipos=2*(MTTR/MTBF)*100;

UR=URlluvia+URequipos % (%) Indisponibilidad.

%% Ej 4 
clear 
close all

f=24e9;
Fq=14.7;

U=15+30*log10(f*1e-9)
if f>20e9
    V=22.6;
else
    V=12.8*(f*1e-9)^0.19;
end
XPDll=U-V*log10(Fq)
%% Ej 5 ok
clear 
close all

d=30;%km
%P.H.
f=13e9;
R_001=32;%mm/h
k=0.0304;
alpha=1.1586;
q=0.01;% tanto por ciento.

%Parte 1: Cálculo de Fq.

%PASO 2
gammaR=k*R_001^(alpha);%dB/km 

%PASO 3 ENLACES TERRENALES
r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff=d*r;

%PASO 4
F_001=gammaR*deff;
%PASO 5
if(f<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((f/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=F_001*C1*q^(-(C2+C3*log10(q)))%dB

%Apartado 2

Fq10=10;
q10=MDTinv(Fq10,d,f,R_001,k,alpha)

 %% Ej 6 Ni caso o revisar porque ha cambiado el enunciado del apartado b
 %Sale bien planteado en el siguiente test
 clear
 close all
 
 d=10e3;
 f=11.2e9;
 %P.V. y P.H.
 Ptxh=20;%dBm
 Lt1=2;
 Lt2=2;
 %Atenuador variable
 R_001=41;%mm/h
 kh=0.0189;
 alphah=1.2069;
 kv=0.0187;
 alphav=1.1528;
 U=-47;%dBm
 lambda=3e8/f;
 gammaO=0.008;%de la gráfica correspondiente
 
 %Datasheet antena:
%  Gtxh=40;
%  Gtxv=40;
 Gtx=40.4;
 Grx=40.4;
 XPDant=40;
 FBR=70;
 
 
 %Apartado a: Determinar los valores de las potencias recibidas copolares y 
 %contrapolares superados en el 0,05% de un año en el receptor asociado a la 
 %polarización horizontal y en el receptor asociado a la polarización vertical. 
 %Se asume que únicamente se producen desvanecimientos por lluvia.

 q=0.05;%
 Fqv = MDT(q,d/1e3,f,R_001,kv,alphav);
 Fqh = MDT(q,d/1e3,f,R_001,kh,alphah);

 %cálculos con Fqh: 
 PIRE=Ptxh-Lt1+Gtx %dBm
 Lo=gammaO*(d/1e3);%atenuación por gases
 Flujo=PIRE-U-10*log10(4*pi*d^2)-Lo-Fqh;%dBm
 flujo=10^(Flujo/10);%mW/m2
 e=sqrt(flujo*120*pi) %mV/m
 E=20*log10(e*1e3) %dBu
 Erxh=E;%dBu, el campo deseado desvanecido (antes de amplificar)

 XPDll=15+30*log10(f/1e9)-12.8*(f/1e9)^0.19*log10(Fqh);
 Erxv=Erxh-XPDll %dBu

 erxv=10^(Erxv/20)/1e6;%W
 flujoV=erxv^2/(120*pi);%W/m2
 FlujoV=10*log10(flujoV);%dBW
 Sefxpd=lambda^2/(4*pi)*10^(-XPDant/10);%m2
 Prxh_p=FlujoV+10*log10(Sefxpd)-Lt2 %dBW Potencia horizontal parásita por Ev (contrapolar)

 erxh=10^(Erxh/20)/1e6;%W
 flujoH=erxh^2/(120*pi);%W/m2
 FlujoH=10*log10(flujoH);%dBW
 Sef=lambda^2/(4*pi)*10^(Grx/10);%m2
 Prxh_d=FlujoH+10*log10(Sef)-Lt2;%dBW Potencia deseada 


 %cálculos con Fqv: 
 Ptxv=Ptxh;%SUPONGO Ptxv=Ptxh
 PIRE=Ptxv-Lt1+Gtx %dBm 
 Lo=gammaO*(d/1e3);%atenuación por gases
 Flujo=PIRE-U-10*log10(4*pi*d^2)-Lo-Fqv;%dBm
 flujo=10^(Flujo/10);%mW/m2
 e=sqrt(flujo*120*pi) %mV/m
 E=20*log10(e*1e3) %dBu
 Erxv=E;%dBu, el campo deseado desvanecido (antes de amplificar)

 XPDll=15+30*log10(f/1e9)-12.8*(f/1e9)^0.19*log10(Fqh);
 Erxh=Erxv-XPDll %dBu

 erxh=10^(Erxh/20)/1e6;%W
 flujoH=erxh^2/(120*pi);%W/m2
 FlujoH=10*log10(flujoH);%dBW
 Sefxpd=lambda^2/(4*pi)*10^((Grx-XPDant)/10);%m2
 Prxv_p=FlujoH+10*log10(Sefxpd)-Lt2 %dBW Potencia horizontal parásita por Ev (contrapolar)

 erxv=10^(Erxv/20)/1e6;%W
 flujoV=erxv^2/(120*pi);%W/m2
 FlujoV=10*log10(flujoV);%dBW
 Sef=lambda^2/(4*pi)*10^(Grx/10);%m2
 Prxv_d=FlujoV+10*log10(Sef)-Lt2;%dBW Potencia deseada 

 %Apartado b:Asumiendo que el margen de variación del atenuador variable es igual para
 %ambas polarizaciones, determinar la PIRE en polarización vertical para garantizar la misma
 %probabilidad de recibir una potencia menor al umbral debida a los desvanecimientos por lluvia. 
 %La potencia umbral es de -47 dBm.
 Fll=Fqv;
 Lbf=20*log10(4*pi*d/lambda);
 Lo=gammaO*(d/1e3);
 PIREv=U-30+Lbf+Lo+Fll-Grx+Lt2%dBW ->ok
 
%% Ej 7 Ok (aunque los apartados 2 y 3 salen diferentes si se considera o no Lo)

clear
close all


ptx=2;%W
d=35e3;%km
long=10;%m
alphacoax=0.076;%dB/m
Lt1=long*alphacoax;
Lt2=Lt1;
%P.H.
Gtx=24;
Grx=24;
f=18e9;
U=-96;%dBm
MTBF=1.5e6;%h

lambda=3e8/f;

%Terminales:
cota1=220;
h1=15;
cota2=307;
h2=5;

%Aristas:
cotao1=238;
cotao2=240;
cotao3=277;

distancias=[8 14 26]*1e3;%distancias de E1 a obstáculos en m.
%-h1-_____d1_____-O1-____d2____-O2-_____d3____-O3-_____d4____-h2-
d1=distancias(1);
d2=distancias(2)-d1;
d3=distancias(3)-distancias(2);
d4=d-distancias(3);

K=4/3;
Ro=6370e3;
R_001=32;%mm/h
k=0.0708;
alpha=1.0818;
%Lo despreciables.

%Apartado 1: Prx en condiciones normales (K=4/3 sin lluvia)

[c1,R1_1,V1] = PF(cota1,cota2,cotao1,h1,h2,d1,d2+d3+d4,K,f)
[c2,R1_2,V2] = PF(cota1,cota2,cotao2,h1,h2,d1+d2,d3+d4,K,f)
[c3,R1_3,V3] = PF(cota1,cota2,cotao3,h1,h2,d1+d2+d3,d4,K,f)
%O2 tiene despejamiento suficiente-> No es obstáculo, se descarta
%solo hay dos obstáculos y tienen V<0 -> método 1

%-h1-_____d1_____-O1-____d2____-O2-_____d3____-O3-____d4_____-h2-
[cp1,Rp1_1,Vp1] = PF(cota1,cotao3,cotao1,h1,0,d1,d2+d3,K,f)
[cp3,Rp1_3,Vp3] = PF(cotao1,cota2,cotao3,0,h2,d3+d2,d4,K,f)


LadVp3=6.9+20*log10(sqrt((Vp3-0.1)^2+1)+Vp3-0.1);
LadVp1=6.9+20*log10(sqrt((Vp1-0.1)^2+1)+Vp1-0.1);
correccion=10*log10(((d1+d2+d3)*(d2+d3+d4))/((d2+d3)*d));
%correccion=10*log10(((dE1_Olejano)*(dE2_Olejano))/((d_entreOs)*d));
Lad=LadVp1+LadVp3+correccion

PIRE=10*log10(ptx)-Lt1+Gtx+30;%dBm
flujo=(10^(PIRE/10))/((4*pi*d^2)*(10^(Lad/10))) %mW/m2
Sef=lambda^2/(4*pi)*10^(Grx/10);
prx=flujo*Sef*(1/10^(Lt2/10)) %mW
Prx=10*log10(prx) %dBm


%Apartado 2: Determinar la indisponibilidad debida a los desvanecimientos por lluvia
%del enlace.

Lbf=20*log10(4*pi*d/lambda);
Fq=PIRE-U-Lbf-Lad+Grx-Lt2;%MD (el profe considera Lo y le da 15)
q = MDTinv(Fq,d/1e3,f,R_001,k,alpha);%tanto por ciento.(le da 0.1121)
URlluvia=q

%Apartado 3: Determinar el MTTR máximo asociado a cada transceptor para cumplir una indisponibilidad total de 0,085%

%UR=URequipos+URlluvia=0.113%
UR=0.113;
URequipos=UR-URlluvia;
%URequipos=2*MTTR*100/MTBF
 MTTR=URequipos*MTBF/(2*100)%(Le da 6.4657 horas)
 
 
%% Ej 11 ok
clear 
close all

f=55e9;
cota1=500;%m
h1=5;%m
cota2=330;%m
h2=15;%m
d=18e3;%m
rho=0.01;
sigma=0.1;%S/m
epsilon_r=20;
G=61;
Grx=G;
%P.V.
%de las gráficas:
alpha=0.78;
k=0.7;

%de las gráficas de gases:
gammaO=4.34;%es la suma de gases y agua.

lambda=3e8/f;

MTTR=4;%horas
MTBF=4e6;%horas
U=-130;%dBm
R_001=32;%mm/h
UR=0.1;

%UR=q+MTTR*100/MTBF=0.1
q=UR-2*MTTR*100/MTBF

Fll = MDT(q,d/1e3,f,R_001,k,alpha);%dB

%Prx_d=PIRE-Lb-Fll+Grx-Ltx=U
%PIRE=U+Lb+Fll-Grx
%Lb=Lbf+Lad por reflexión
Lbf=20*log10(4*pi*d/lambda);

%Cálculo de pérdidas por reflexión:

H1=cota1+h1;
H2=cota2+h2;
K=4/3;
Ro=6370*1e3;%m

dmax=sqrt(2*K*Ro*H1)+sqrt(2*K*Ro*H2);
dlim=0.1*dmax;
%dlim<d-->MTC


%H2<H1
p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4));
Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3);%PHI
d1=d/2+p*cos((pi+Phi)/3);

d2=d-d1;
hp1=H1-(d1^2/(2*K*Ro));
hp2=H2-(d2^2/(2*K*Ro));
tan_phi=hp1/d1;
phi=atan(tan_phi);%phi


phi_lim=((5400/(f/1e6))^(1/3))/(1e3);%rad


epsilon_o=epsilon_r-1j*60*sigma*lambda;


Ab=(2*hp1*hp2)/(d);%incremento de longitud
Gamma=(4*pi*rho*sin(phi))/(lambda);


Rv=(epsilon_o*sin(phi)-sqrt(epsilon_o-cos(phi).^2))/(epsilon_o*sin(phi)+sqrt(epsilon_o-cos(phi).^2))


D=1/sqrt(1+((5/(16*K))*(((d2/1e3)*(d1/1e3)^2)/((d/1e3)*hp1))));

Re=Rv*D*exp(-(Gamma^2)/2);

lad=1/abs(1+Re*exp(-1i*2*pi*Ab/lambda))^2
Lad=10*log10(lad)

Lo=gammaO*d*1e-3;
Lb=Lbf+Lad+Lo;
PIRE=U+Lb+Fll-Grx%dBm

%% Tema 4 test 1

%% Ej 1

clear
close all

Rb=7e6;
M=128;
roll_off=0.3;

B_filtrada=(1+roll_off)*(Rb/log2(M))

%% Ej 2

clear
close all

ptx=2;%W
d=35e3;%km
long=10;%m
alphacoax=0.076;%dB/m
Lt1=long*alphacoax;
Lt2=Lt1;
%P.H.
Gtx=24;
Grx=24;
f=18e9;
U=-96;%dBm
MTBF=1.5e6;%h

lambda=3e8/f;

%Terminales:
cota1=220;
h1=15;
cota2=307;
h2=5;

%Aristas:
cotao1=238;
cotao2=240;
cotao3=277;

distancias=[8 14 26]*1e3;%distancias de E1 a obstáculos en m.
%-h1-_____d1_____-O1-____d2____-O2-_____d3____-O3-_____d4____-h2-
d1=distancias(1);
d2=distancias(2)-d1;
d3=distancias(3)-distancias(2);
d4=d-distancias(3);

K=4/3;
Ro=6370e3;
R_001=32;%mm/h
k=0.0708;
alpha=1.0818;
%Lo despreciables.

%Apartado 1: Prx en condiciones normales (K=4/3 sin lluvia)

[c1,R1_1,V1] = PF(cota1,cota2,cotao1,h1,h2,d1,d2+d3+d4,K,f)
[c2,R1_2,V2] = PF(cota1,cota2,cotao2,h1,h2,d1+d2,d3+d4,K,f)
[c3,R1_3,V3] = PF(cota1,cota2,cotao3,h1,h2,d1+d2+d3,d4,K,f)
%O2 tiene despejamiento suficiente-> No es obstáculo, se descarta
%solo hay dos obstáculos y tienen V<0 -> método 1

%-h1-_____d1_____-O1-____d2____-O2-_____d3____-O3-____d4_____-h2-
[cp1,Rp1_1,Vp1] = PF(cota1,cotao3,cotao1,h1,0,d1,d2+d3,K,f)
[cp3,Rp1_3,Vp3] = PF(cotao1,cota2,cotao3,0,h2,d3+d2,d4,K,f)


LadVp3=6.9+20*log10(sqrt((Vp3-0.1)^2+1)+Vp3-0.1);
LadVp1=6.9+20*log10(sqrt((Vp1-0.1)^2+1)+Vp1-0.1);
correccion=10*log10(((d1+d2+d3)*(d2+d3+d4))/((d2+d3)*d));
%correccion=10*log10(((dE1_Olejano)*(dE2_Olejano))/((d_entreOs)*d));
Lad=LadVp1+LadVp3+correccion

PIRE=10*log10(ptx)-Lt1+Gtx+30;%dBm
flujo=(10^(PIRE/10))/((4*pi*d^2)*(10^(Lad/10))) %mW/m2
Sef=lambda^2/(4*pi)*10^(Grx/10);
prx=flujo*Sef*(1/10^(Lt2/10)) %mW
Prx=10*log10(prx) %dBm


%Apartado 2: Determinar la indisponibilidad debida a los desvanecimientos por lluvia
%del enlace.

Lbf=20*log10(4*pi*d/lambda);
Fq=PIRE-U-Lbf-Lad+Grx-Lt2;%MD (el profe considera Lo y le da 15)
q = MDTinv(Fq,d/1e3,f,R_001,k,alpha);%tanto por ciento.(le da 0.1121)
URlluvia=q%0.0854%

%Apartado 3: Determinar el MTTR máximo asociado a cada transceptor para cumplir una indisponibilidad total de 0,085%

%UR=URequipos+URlluvia=0.113%
UR=0.085;
URequipos=UR-URlluvia;
%URequipos=2*MTTR*100/MTBF
 MTTR=URequipos*MTBF/(2*100)%(Le da 6.4657 horas)



%% Ej 3 
clear
close all
G=10;
F=3;
To=290;
K=1.38e-23;

g=10^(G/10);
f=10^(F/10);
Ta=(f-1)*To;%ESTO ES Tequivalente
Teq=To+Ta %Esto dice que es a la salida, si hay un gnerador de ruido a To en la entrada
nin=K*Teq;

nout=nin*g;
Nout=10*log10(nout)+30%dBm

%% Ej 4
 
 clear
 close all
 
 d=10e3;
 f=11.2e9;
 %P.V. y P.H.
 Ptxh=20;%dBm
 Lt1=2;
 Lt2=2;
 %Atenuador variable
 R_001=41;%mm/h
 kh=0.0189;
 alphah=1.2069;
 kv=0.0187;
 alphav=1.1528;
 U=-47;%dBm
 lambda=3e8/f;
 gammaO=0.008;%de la gráfica correspondiente
 
 %Datasheet antena:
%  Gtxh=40;
%  Gtxv=40;
 Gtx=40.4;
 Grx=40.4;
 XPDant=40;

 
 
 %Apartado a: Determinar los valores de las potencias recibidas copolares y 
 %contrapolares superados en el 0,05% de un año en el receptor asociado a la 
 %polarización horizontal y en el receptor asociado a la polarización vertical. 
 %Se asume que únicamente se producen desvanecimientos por lluvia.

 q=0.05;%
 Fqv = MDT(q,d/1e3,f,R_001,kv,alphav);
 Fqh = MDT(q,d/1e3,f,R_001,kh,alphah);

 %cálculos con Fqh: 
 PIRE=Ptxh-Lt1+Gtx-30; %dBW
 Lo=gammaO*(d/1e3);%atenuación por gases
 Flujo=PIRE-10*log10(4*pi*d^2)-Lo-Fqh;%dBW
 flujo=10^(Flujo/10);%W/m2
 e=sqrt(flujo*120*pi); %V/m
 E=20*log10(e*1e6); %dBu
 Erxh=E;%dBu, el campo deseado desvanecido (antes de amplificar)

 XPDll=15+30*log10(f/1e9)-12.8*(f/1e9)^0.19*log10(Fqh);
 Erxv=Erxh-XPDll; %dBu

 %Receptor P.V.
 erxv=10^(Erxv/20)/1e6;%V/m
 flujoV=erxv^2/(120*pi);%W/m2
 FlujoV=10*log10(flujoV);%dBW
 Sefv=lambda^2/(4*pi)*10^(Grx/10);%m2
 Prxv_d=FlujoV+10*log10(Sefv)-Lt2%dBW Potencia deseada

 %Receptor P.H.( Erxh mismo valor de partida porque se emite P.H.)
 erxh=10^(Erxh/20)/1e6;%V/m
 flujoH=erxh^2/(120*pi);%W/m2
 FlujoH=10*log10(flujoH);%dBW
 Sefh=lambda^2/(4*pi)*10^(Grx/10);%m2
 Prxh_d=FlujoH+10*log10(Sefh)-Lt2%dBW Potencia deseada 

 %contrapolares
 Sefxpd=lambda^2/(4*pi)*10^((Grx-XPDant)/10);%m2
 Prxv_p=FlujoH+10*log10(Sefxpd)-Lt2 %dBW Potencia horizontal parásita por Ev (contrapolar)
 Prxh_p=FlujoV+10*log10(Sefxpd)-Lt2 %dBW

 

 %Apartado b:Asumiendo que el margen de variación del atenuador variable es igual para ambas
 %polarizaciones, determinar la PIRE en polarización vertical para garantizar la misma probabilidad
 %de recibir una potencia menor al umbral debida a los desvanecimientos por lluvia. La potencia 
 %umbral es de -47 dBm.
 
%  piden cuanto tiene que ser la PIRE en vertical para tener la misma indisponibilidad que
%  para horizontal, por lo tanto, primero hay que calcular MD=PrxcnH-U, determinar la q correspondiente
%  y determinar el nuevo valor de MD para vertical que sale 9.56 dB.
 
 Lbf=20*log10(4*pi*d/lambda);
 Lo=gammaO*(d/1e3);
 PrxcnH=PIRE+30-Lbf-Lo+Grx-Lt2;%dBm
 MD=PrxcnH-U;
 qh = MDTinv(MD,d,f,R_001,kh,alphah);
 Fll = MDT(qh,d,f,R_001,kv,alphav);
 PIREv=U-30+Lbf+Lo+Fll-Grx+Lt2%dBW 
%% Ej 5

clear 
close all

e1=0.95;%rendimiento. supongo que será la eficiencia (e)
D1=6;
long1=10;%m
alphacoax=0.076; %dB/m

G2=2.15;
long2=2;%m

d=35e3;
f=450e6;
Lad=20;
Flujo=-109;%dBW/m2

% lambda=3e8/f;
Lt1=long1*alphacoax;
Lt2=long2*alphacoax;
g1=e1*10^(D1/10);
G1=10*log10(g1);

% Lbf=20*log10(4*pi*d/lambda);
% PIRE1=Pt1-Lt1+G1
% Flujo=PIRE-10*log10(4*pi*d^2)-Lad %dBW/m2
% Flujo=Pt1-Lt1+G1-10*log10(4*pi*d^2)-Lad %dBW/m2
% Pt1=Flujo+Lt1-G1+10*log10(4*pi*d^2)+Lad %dBW
Pt1=Flujo+Lt1-G1+10*log10(4*pi*d^2)+Lad %dBW

Pt2=Flujo+Lt2-G2+10*log10(4*pi*d^2)+Lad %dBW


%% Ej 6
clear 
close all
CNRmin=17.5;
BER=1e-3;
%64QAM
M=64;
CNRdeg=CNRmin;%CNR degradada, como mínimo sería esto si el filtro no degradara.
BERdeg=-1;%por poner algo que cumpla la condición de entrada al bucle.
while(BER>=BERdeg)
 %El valor de CNR va decayendo hasta ser el que cumple BER=1e-3
 CNRdeg=CNRdeg-0.01;
 BERdeg=berawgn(CNRdeg,'qam',M);
end

Delta_filtro=CNRdeg-CNRmin
BER1=berawgn(CNRmin+Delta_filtro,'qam',M);

% berawgn(EbN0_endB,'qam',M_numerodeniveles de la modulacion)


%% Ej 7
clear
close all
d=10e3;
f=13e9;
ptx=25;%mW
Lt1=1.5;
Lt2=1.2;
Gtx=28;
Grx=23;
F=8.5;%dB
B=5e6;%Hz
%16PSK;
M=16;
roll_off=0.3;%->Delta_filtro = 1 dB
Delta_filtro=1;%dB
EbNomin=18;
BER=1e-3;
%Atenuador variable
K=1.38e-23;
To=290;%ºK

gammaO=0.008+0.007;%aprox de las gráficas

lambda=3e8/f;
%B=(1+roll_off)*(Rb/log2(M))=(1+roll_off)*Rs-->Rb=B*log2(M)/(1+roll_off)
Rb=B*log2(M)/(1+roll_off);
fr=10^(F/10);%mejor fr, f puede confundirse con freq.
grx=10^(Grx/10);
lt2=10^(Lt2/10);
Ta=To;
Tx=Ta*grx+To*(fr-1)+To*(lt2-1);

EbNodeg=EbNomin-Delta_filtro;
U=EbNodeg+10*log10(K*Tx*Rb);%imagino que son dBW
Lb=20*log10(4*pi*d/lambda)+gammaO*d*1e-3;
Prxcn=10*log10(ptx)-30-Lt1+Gtx-Lb+Grx-Lt2;%dBW


MD=Prxcn-U

%% Ej 13 
clear 
close all

L=4;%dB
To=290;%ºK
l=10^(L/10);

T=To*(l-1)