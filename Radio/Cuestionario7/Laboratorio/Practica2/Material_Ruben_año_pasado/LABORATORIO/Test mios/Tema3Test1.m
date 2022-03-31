
                            %% Tema 3. Test 1
 %% EJERCICIO 3. Calculo de la Prx y la altura.

clear 
close all

f=770e6; %Frecuencia de trabajo [Hz] (e6 porque esta en GHz)
Ptx=35; %Potencia de transmision [dBm]
G=23; %Ganancia de la antena [dB]
Lt=2; %Perdidas de los terminales [dB]

d=50 %Distancia entre las estaciones[km]
d1=11 %Distancia entre OBSTACULO 1 y ESTACION 1[km]
do2=d-d1 %Distancia entre OBSTACULO 1 y ESTACION 2[km]
do1=37 %Distncia entre OBSTACULO 2 y ESTACION 1[km]
d2=do1-d1 %Distancia entre OBSTACULO 1 y OBSTACULO 2[km]
d3=d-do1 %Distancia entre OBSTACULO 2 y ESTACION 2[km]

e1=75; %Elevación de la estacion 1 [m]
e2=60; %Elevacion de la estacion 2 [m]
h1=35; %Altura de la estacion 1 [m]
h2=5; %Altura de la estacion 2 [m]
Ht1=e1+h1
Ht2=e2+h2
eo1=112; % Elevacion del Obstáculo 1 [m]
eo2=48; %Elevacion del Obstaculo 2 [m]
ho1=0; %Altura del Obstaculo 1 [m]
ho2=0; %Altura del Obstaculo 2 [m]

k=4/3;
Ro=6370

lambda=3e8/f;

%Apartado 1:

%cálculo de las distintas separaciones:
%-e1-______[d1]______-O1-______[d2]_____-O2-______d3______-e2
% e1_____[do1]_____O2
% O1_____[do2]_____e2
% e1_________________________[d]____________________e2

%cálculo del despejamiento (c) y el parámetro de difracción (V):
%Entre estaciones y obstaculo 1
flec_1=(d1*do2*1e3)/(2*k*Ro)
elev_1=eo1
alt_rayo_1=((h2+e2-h1-e1)*d1/d)+Ht1
c1=flec_1+elev_1-alt_rayo_1
R1_1=sqrt(lambda*((d1*do2)*1e3/d))
v1=sqrt(2)*(c1/R1_1)

%Entre estaciones y obstaculo 2
flec_2=(do1*d3*1e3/(2*k*Ro))
elev_2=eo2
alt_rayo_2=((h2+e2-h1-e1)*do1/d)+Ht1
c2=(flec_2+elev_2)-alt_rayo_2
R1_2=sqrt(lambda*((do1*d3)*1e3/d))
v2=sqrt(2)*(c2/R1_2)

%v1=0.9088(->v1>0) y v2=-0.0089(->v2<0) -> SERÍA METODO 1
%V1>V2-> O1 es el OBSTACULO DOMINANTE.
%Uso rayo alternativo que va desde OBSTACULO 1 hasta la ESTACION 2 ->cp_2

%Tengo que calcular el despejamiento modificado del OBSTACULO 2. 
%-O1-______[d2]_____-O2-______d3______-e2
% % e1_____[d2]_____O2
% % O1_____[do2]_____e2
% % o1_________________________[dp=d02]____________________e2
% 
d1= 11 %Distancia de la ESTACION 1 al OBSTACULO 1
do1=37; %Distancia al ESTACION 1 y OBSTACULO 2 [km]
do2=d-d1; %Distancia al OBSTACULO 1 y ESTACION 2 [km]
d2= do1-d1 %Distancia entre OBSTACULO 1 y OBSTACULO 2
d3= d-do1 %Distancia entre OBSTACULO 2 y ESTACION 2
 
flecp_2=(d2*d3*1e3/(2*k*Ro))
elevp_2=eo2
altp_rayo_2=((h2+e2-ho1-eo1)*d2/do2)+eo1
cp2=(flecp_2+elevp_2)-altp_rayo_2 %Calculo del DESPEJAMIENTO MODIFICADO
R1p_2=sqrt(lambda*((d2*d3)*1e3/do2))
vp2=sqrt(2)*(cp2/R1p_2)

%Tengo que calcular el despejamiento modificado del OBSTACULO 1. 
%-e1-______[d1]_____-O1-______d2______-02
% % e1_____[do1]_____O1
% % O1_____[d2]_____02
% % e1_________________________[dp=d01]____________________02
% 
d1= 11 %Distancia de la ESTACION 1 al OBSTACULO 1
do1=37; %Distancia al ESTACION 1 y OBSTACULO 2 [km]
do2=d-d1; %Distancia al OBSTACULO 1 y ESTACION 2 [km]
d2= do1-d1 %Distancia entre OBSTACULO 1 y OBSTACULO 2
d3= d-do1 %Distancia entre OBSTACULO 2 y ESTACION 2
 
flecp_1=(d1*d2*1e3/(2*k*Ro))
elevp_1=eo1
altp_rayo_1=((ho2+eo2-h1-e1)*d1/do1)+eo1
cp1=(flecp_1+elevp_1)-altp_rayo_1 %Calculo del DESPEJAMIENTO MODIFICADO
R1p_1=sqrt(lambda*((d1*d2)*1e3/do1))
vp1=sqrt(2)*(cp1/R1p_1)

%Solo hay perdidas de diifraccion si vp>-0.78
%vp1=0.9080 -> mayor que -0.78. Hay perdidas
%Ldif_vp1=0
Ldif_vp1=6.9+20*log10((sqrt((vp1-0.1)^2)+1)+vp1-0.1)
%vp2=-0.3108 -> mayor que -0.78. Hay perdidas
%Ldif_vp2=0
Ldif_vp2=6.9+20*log10((sqrt((vp2-0.1)^2)+1)+vp2-0.1)

Lad=Ldif_vp1+Ldif_vp2+10*log10((d1*do2)/(d2*d))

%Una vez que ya tengo las Lad, calculo la Prx
Lbf=20*log10((4*pi*d*1000)/lambda)
Lb=Lbf+Lad
Prx=Ptx-Lt+G-Lb+G-Lt


%Apartado 2: h2 para que v1 sea -0.78, para ello uso los datos del Rayo
%entre ESTACION 1 y la ESTACION 2 en funcion del OBSTACULO 1

vpp1=-0.78
cpp1=vpp1*R1_2/sqrt(2)
altpp_rayo_1=flec_1+elev_1-cpp1
hp2=((altpp_rayo_1-eo1)*d/d1)-e2+h1+e1

%% EJERCICIO 4. Calculo de la distancia del enlace

clear 
close all

f=200e6; %Frecuencia de trabajo [Hz] (e6 porque esta en MHz)
Ptx=57; %Potencia del transmisor [dBm]
d2=500; %Distancia de bosque [m]
E2=57; %Campo electrico en la estacion 2 [dBu]
Am=1.15*(f/1e6)^0.43 %f en MHz
%P.V.
G=15; %Ganancia de las antenas [dB]
Lt=2; %Perdidas de los terminales [dB] 

gamma=0.07 %[dB/m] De la gráfica del Tema 3.

Lv=Am*(1-exp((-d2*gamma)/Am))

PIRE=Ptx-Lt+G; %Calculo de la PIRE [dBm]
pire=10^(PIRE/10)/1e3; %Calculo de la pire [W]
E1=E2+Lv %Campo 1, es el campo 2 + las perdidas por bosque
e1=10^(E1/20)/1e6; %Calculo del campo 1 [V/m]

d1=sqrt(30*pire)/e1; %Distancia entre ESTACION 1 y el bosque
d=d1+d2 %Distancia entre ESTACION 1 y la ESTACION 2.

%% EJERCICOIO 7. Probabilidad de recibir menor potencia

close
clear all

f=38e9; %Frecuencia en [Hz] (e9 porque esta en GHz)
G=27; %Ganancia de las antenas [dB]
Lt=1.5; %Perdidas de los terminales
%P.V.
Umbral=-98; %Umbral [dBm]
Ptx=25; %Potencia del transmisor [dBW]->[dBm]
%Atenuador variable
d=23; %Distancia entre estaciones [km]
R_001=24.42; %mm/h
k=0.3884;
alpha=0.8552;
alpha=0.125; %Atenueacion especifica por gases [dB/km]

lambda=3e8/f;
Ro=6370;
K=4/3;

%Calculo de la potencia recibida sin tener en cuenta la lluvia
L_gases=alpha*d
Lbf=20*log10(4*pi*d*1000/lambda)
Prxcn=Ptx+G-Lt-Lbf-L_gases+G-Lt
MD=Prxcn-Umbral

%PASO 2 (Depende de la frecuencia, polarización y R_001)
gamma_R=k*R_001^(alpha) %[dB/km] 

%PASO 3 ENLACES TERRENALES
r=(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))))
deff=d/r;

%PASO 4 Calculo de F_001
F_001=gamma_R*deff;

%PASO 5 Calculo de Fq
if(f<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((f/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=MD
%solucion=roots ([C3 C2 log10(MD/(F_001*C1))]) %Para sacar las raices de
%log10(q)
%q=10^(max(solucion))

 %MD=F_001*C1*q^(-(C2+C3*log10(q)))
 q_exponente=MD/(F_001*C1)
 %log10(q^(-(C2+C3*log10(q))))=log10(q_exponente) %Aplico log10 a ambos lados
 %log10(q)*(-C2-C3*log10(q))= log10(q_exponente) %"Pego" la patada al exponente
 %-log10(q)*C2-C3*log10(q)^2=log10(q_exponente)
 %x=log10(q)
 %-x*C2-x^2*C3=log10(q_exponente) 
 %-x*C2-x^2*C3-log10(q_exponente)=0 
 %x=(C2(+/-)sqrt(C^2-4*C3*log10(q_exponente))/(-2*C3)
 
 xa=(C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 xb=(C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 q1=10^xa
 q2=10^xb

 %% EJERCICIO 9. Calculo de la atenuacion por lluvia superada
clear 
close all

f=14e9; %en [Hz] (e9 porque esta en GHz)
d=39000; %[km] para los cálculos de atenuación
hS=2.280; %cota sobre el nivel del mar en km (hs en enlaces espaciales)
Lat=19.421383 %N
Long=-99.181863;%E

theta=20; %Angulo de elvacion [grados]
R_001=38.89; %[mm/h]
k=0.0374; %valor de la k 
alpha=1.1396; 
ho=4.7477; %Altura [km]

Ro=6370;
K=4/3;
q=1 %En porcentaje (1%)

%PASO 2 (Depende de la frecuencia, polarización y R_001)
gamma_R=k*R_001^(alpha)%dB/km 


%PASO 3 ENLACE ESPACIAL
hR=ho+0.36; %[km]

%Para el calculo de la L_s
if(theta>=5)
   L_s=(hR-hS)/(sind(theta)); %seno de angulo, pero como esta en grados sind
else
    Re=Ro*K;
    L_s=(2*(hR-hS))/(sqrt(sind(theta)^2+(2*(hR-hS)/Re))+sind(theta));   
end
LG=L_s*cosd(theta);

%Calculo de la r_0.01
r_001=1/(1+0.78*sqrt(LG*gamma_R/(f/1e9))-0.38*(1-exp(-2*LG)));

%Calculo de la L_r
if(atand((hR-hS)/(LG*r_001))>theta)
   L_r=LG*r_001/cosd(theta);
else
   L_r=(hR-hS)/sind(theta);   
end

%Calculo de epsilon
if(abs(Lat)<36)
   epsilon=36-abs(Lat);
else
   epsilon=0;   
end

V_001=1/(1+sqrt(sind(theta))*(((31*(1-exp(-theta/(1+epsilon)))*sqrt(L_r*gamma_R))/(f/1e9)^2-0.45)))
deff=L_r*V_001;

%PASO 4
F_001=gamma_R*deff;

%PASO 5
if(q>=1 || abs(Lat)>=36)
   beta=0;  
elseif (q<1 && abs(Lat)<36 && theta>=25)
   beta=-0.005*(abs(Lat)-36);   
else
   beta=-0.005*(abs(Lat)-36)+1.8-4.25*sind(theta); 
end

%ATENUACION=Fq
Fq=F_001*(q/0.001)^(-(0.655+0.033*log(q)-0.045*log(F_001)-beta*(1-q)*sind(theta)))


