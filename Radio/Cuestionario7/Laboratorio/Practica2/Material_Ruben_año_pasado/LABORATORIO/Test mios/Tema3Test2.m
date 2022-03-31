                                
                                %% Tema 3 test 2 
 %% EJERCICIO 1. Campo recibido y la XPI 

close 
clear all

%Radioenlace terrenal.
d=23 %Distancia entre estaciones [km]
f=38e9; %Frecuencia de trabajo en [Hz] (e9 porque esta en GHz)
Grx=27; %Ganancia de la antena receptora [dbi]
Gtx=27; %Ganancia de la antena transmisora [dBi]
%P.V.
Lt=1.5; %Perdidas entre terminales 
Umbral=-98; %Umbral de recepcion [dBm]
Ptx=25 ; %dBW
XPD_ant=30 %[dB]

q=0.01; %en tanto por cien
XPD_ant=30;
gamma_g=0.125; %Atenuacion especifica por gases [db/km]
R_001=24.42; %mm/h
k=0.3884; 
alpha=0.8552;
lambda=3*1e8/f

%Desvanecimiento por lluvia:
Ro=6370;
K=4/3;

%PASO 2
gamma_R_H=k*R_001^(alpha)%dB/km 

%PASO 3 ENLACES TERRENALES
r_H=(0.477*d^(0.633)*R_001^(0.073*alpha)*(f/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff_h=d/r_H;

%PASO 4 
F_001=gamma_R_H*deff_h;

% %PASO 5 (No tengo que hacer el paso 5 porquemi q ya vale 0,01%)
% if(f<10e9)
%     Co=0.12;
% else
%     Co=0.12+0.4*log10((f/10)^0.8);   
% end 
% 
% C1=(0.07^(Co))*(0.12^(1-Co));
% C2=(0.855*Co)+0.546*(1-Co);
% C3=(0.139*Co)+0.043*(1-Co);
% 
% Fq=F_001*C1*q^(-(C2+C3*log10(q)));

L_gases=gamma_g*d;%atenuación por gases
Lbf=10*log10(4*pi*d^2/lambda)
PIRE=Ptx-Lt+Gtx %[dBm]
Prxcn=PIRE-Lbf-L_gases+Grx-Lt
MD=Prxcn-Umbral

U=15+30*log10(f/1e9)
if f>20e9
    V=22.6
else 
    V=12.6*f^(0.18)
end
XPD_ll=U-V*log10(F_001)

pire=10^(PIRE/10)
eo=sqrt(30*pire)/(d*1e3) %Campo recibido en espacio libre sin atenuaciones [V/m]
Eo=20*log10(eo*1e6) %Pasar el campo a [dBu]
%Al campo en esapcio libre + atenuacio por gases + desvanecimiento por lluvia    
Erx_V=Eo-F_001-L_gases; %Campo que recibo en VERTICAL [dBu]
%Para el campo Horizontal tengo que sumarle el desvamecimiento por lluvia
Erx_H=Erx_V-XPD_ll %Campo que recibo en HORIZONTAL [dbu]

%Aislamiento copolar
Sef_V=10*log10((lambda^2)/(4*pi))+Grx
Prx_V1=Erx_V + 20*log10(1e-6) - 10*log10(120*pi) + Sef_V - Lt + 30 %+30 para tenerlo en [dBm]
Prx_V2=Erx_H + 20*log10(1e-6) - 10*log10(120*pi) + Sef_V - XPD_ant - Lt + 30 

XPI=Prx_V1-Prx_V2 %Hay que calcularlo en funcion de la Prx_V1 y la Prx_V2
%XPI=XPD_ant + XPD_ll

%% EJERCICIO 2 CALCULAR LA INDISPONIBILIDAD

close
clear all

d=35 %[km]
ptx=2 %[W]
Ptx=10*log10(ptx)+30 %dbm
d_cable=10 %[m]
aten=0.076 %[dB/km]
Lt=d_cable*aten
G=24  %[dB]
%P.V
frec=18e9 %[Hz] (e9 porque esta en GHz)
Umbral=-96 %[dBm]

MTBF=10^6 %Horas
MTTR=40 %Horas
gamma_g=0.0606 %Atenuacion especifica de los gases
R_001=28,64 %mm/h
k=0.0711
alpha=1.0025

lambda=3e8/frec
L_gases=gamma_g*d
Lbf=20*log10(4*pi*d*1e3/lambda)

PIRE=Ptx+G-Lt
Prxcn=PIRE-Lbf-L_gases+G-Lt
MD=Prxcn-Umbral
 
%PASO 2 (Depende de la frecuencia, polarización y R_001)
gamma_R_H=k*R_001^(alpha) %[dB/km] 

%PASO 3 ENLACES TERRENALES
r_H=(0.477*d^(0.633)*R_001^(0.073*alpha)*(frec/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))))
deff_h=d/r_H;

%PASO 4 Calculo de F_001
F_001=gamma_R_H*deff_h;

%PASO 5 Calculo de Fq
if(frec<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((frec/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=MD
q_exponente=MD/(F_001*C1)
 xa=(C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 xb=(C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 q1=10^xa
 q2=10^xb

 if q1<q2
     q=q2
 else 
     q=q1
 end 
 UR_ll=q
   

UR_equi=2*(MTTR/MTBF)* 100

UR=UR_ll+UR_equi


%% EJERCICIO 4 CALCULO DE LA XPD_u
close
clear all

f=24e9 %Frecuencia de trabajo [Hz] (e9 porque esta en GHz)
%PH
Fq=14,7 %Desvanecimiento por lluvia [db]

U=15+30*log10(f/1e9)
if f<20
    V=12.8*f^(0.18)
else 
    V=22.6
end  
XPD_u=U-V*log10(Fq)

%% EJERCICIO 5 CALCULO DE LA PROFUNDIDAD Y DE LA PROBABILIDAD

close 
clear all

d=30 %[km]
frec=13e9 %Frecuencia de trabajo [Hz] (e9 porque esta en GHz)
%P.H
q=0.01 %Expresada en tanto por ciento
R_001=32 %[mm/h]
k=0.0304
alpha=1.1586 

Ro=6370
K=4/3
MD=10

%PASO 2
gamma_R_H=k*R_001^(alpha)%dB/km 

%PASO 3 ENLACES TERRENALES
r_H=(0.477*d^(0.633)*R_001^(0.073*alpha)*(frec/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff_h=d/r_H;

%PASO 4 
F_001=gamma_R_H*deff_h;

% %PASO 5 (No tengo que hacer el paso 5 porquemi q ya vale 0,01%)
% if(frec<10e9)
%     Co=0.12;
% else
%     Co=0.12+0.4*log10((frec/10)^0.8);   
% end 
% 
% C1=(0.07^(Co))*(0.12^(1-Co));
% C2=(0.855*Co)+0.546*(1-Co);
% C3=(0.139*Co)+0.043*(1-Co);
% 
% Fq=F_001*C1*q^(-(C2+C3*log10(q)));


% %PASO 5
if(frec<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10((frec/10)^0.8);   
end 

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);
Fq=MD

q_exponente=Fq/(F_001*C1)
 xa=(C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 xb=(C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 q1=10^xa
 q2=10^xb
 
  if q1<q2
     q=q2
 else 
     q=q1
 end 
 


%% EJERCICIO 6 CALCULAR LOS VALORES DE POLARIZACION V Y H; Y LA PIRE EN PV

close 
clear all

frec=11.2*1e9 %Frecuencia de trabajo en [Hz] (e9 porque esta en GHz)
d=10 %[km]
%PV y PH
Ptx_H=20 %[dBm]
Lt_H=2 %[dB]

gamma_g=0.1023
q=0.05 %Expresada en tanto por ciento
R_001=41 %mm/h
k_H=0.0189
alpha_H=1.2069
k_V=0.0187
alpha_V=1.1528
lambda=3e8/frec
G=40.4 %Dato de la hojas decaracteristicas
XPD_ant=40 %Dato de las hojas de caracteristicas

%CALCULO PARA LA HORIZONTAL
%PASO 2
gamma_R_H=k_H*R_001^(alpha_H)%dB/km 

%PASO 3 ENLACES TERRENALES
r_H=(0.477*d^(0.633)*R_001^(0.073*alpha_H)*(frec/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff_h=d/r_H;

%PASO 4 
F_001_h=gamma_R_H*deff_h;

% %PASO 5 (No tengo que hacer el paso 5 porquemi q ya vale 0,01%)
if(frec<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10((frec/10)^0.8);   
end 

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq_H=F_001_h*C1*q^(-(C2+C3*log10(q)));

%Calculo la atenuacion debido a la lluvia
U_h=15+30*log10(frec/1e9)
if frec<20
    V=12.8*frec^(0.18)
else 
    V=22.6
end  
XPD_uh=U_h-V*log10(Fq_H)

%Calculo las perdidas
Lbf=20*log10(4*pi*d*1e3/lambda)
L_gases=gamma_g*d
%Calculo de la potencia recibida con maximo desvanecimiento
%PrxcmdH_V, potencia recibida por la seña en Horizontal en la antena Vertical
PIRE=Ptx_H+G-Lt_H
PrxcmdH_H=PIRE-Lbf-L_gases-Fq_H-Lt_H+G
PrxcmdV_H=PIRE-Lbf-L_gases-Fq_H-XPD_uh-XPD_ant-Lt_H+G
PrxcmdH_V=PIRE-Lbf-L_gases-Fq_H-XPD_ant-Lt_H+G
PrxcmdV_V=PIRE-Lbf-L_gases-Fq_H-XPD_uh-Lt_H+G


%APARTADO 2. CALCULAR LA PIRE

Umbral=-47

%CALCULO PARA LA VERTIVAL
%PASO 2
gamma_R_V=k_V*R_001^(alpha_V)%dB/km 

%PASO 3 ENLACES TERRENALES
r_V=(0.477*d^(0.633)*R_001^(0.073*alpha_V)*(frec/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))));
deff_v=d/r_V;

%PASO 4 
F_001_v=gamma_R_V*deff_v;

% %PASO 5 (No tengo que hacer el paso 5 porquemi q ya vale 0,01%)
if(frec<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10((frec/10)^0.8);   
end 

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq_V=F_001_v*C1*q^(-(C2+C3*log10(q)));

Prxcn_v=Fq_V+Umbral %MD=Fq_V=Umbral-Fq_V
PIRE=Prxcn_v+Lbf+L_gases+Lt_H-G %Dato de la PIRE en dBm

%% EJERCICIO 7 CALCULAR LA Prxcn, LA INDISPONIBILIDAD DEBIDA A LA LLUVIA Y MTTR

close
clear all

ptx=2 %[w]
Ptx=10*log10(ptx)+30 %Dato en dBm
Aten_cable=0.076 %[dB/m]
Long_cable=10 %[m]
Lt=Aten_cable*Long_cable
d=35 %[km]
Gtx=24 %[dBi]
frec=18e9 %Frecuencia de trabajo [Hz] (e9 porque esta en GHz)
Umbral=-96 %[dBm]
MTBF=1500000 %[horas]
Lambda_gases=0.09

K=4/3
Ro=6370 %[km]
k=0.0708
alpha=1.0818
R_001=32 %[mm/h]
lambda=3e8/frec

h1=15 %[m]
e1=220 %[m]
h2=5 %[m]
e2=307 %[m]
Ht1=h1+e1
Ht2=h2+e2
ho1=0 %[m]
eo1=238 %[m]
ho2=0 %[m] 
eo2=240 %[m]
ho3=0 %[m]
eo3=277 %[m]

%e1_______[d1]_____o1______[d2]_____o2_____[d3]_______o3_____[d4]_______e2
%e1________[d1]________o1__________________[do12]___________________e2
%e1________[do21]______o2__________________[do22]___________________e2
%e1________[do31]______o3__________________[d4]_____________________e2


d1=8 % Distancia entre ESTACION 1 y el OBSTACULO 1
do12=27 %Distancia entre ESTACION 2 y el OBSTACULO 1
do21=14 %Distancia entre ESTACION 1 y el OBSTACULO 2
do22=21 %Distancia entre ESTACION 2 y el OBSTACULO 2
do31=26 %Distancia entre ESTACION 1 y el OBSTACULO 3
d4=9 %Distancia entre OBSTACULO 4 y el ESTACION 2
d2=6 %Distancia entre OBSTACULO2 1 y el OBSTACULO 2
d3=12 %Distancia entre OBSTACULO 1 2 el OBSTACULO 3


[c_1,R1_1,V1] = PF(e1,e2,eo1,h1,h2,d1,do12,K,frec)
[c_2,R1_2,V2] = PF(e1,e2,eo2,h1,h2,do21,do22,K,frec)
[c_3,R1_3,V3] = PF(e1,e2,eo3,h1,h2,do31,d4,K,frec)

% flec_1=(d1*do12*1e3)/(2*K*Ro)
% elev_1=eo1
% alt_rayo_1=((h2+e2-h1-e1)*d1/d)+Ht1
% c1=flec_1+elev_1-alt_rayo_1
% R1_1=sqrt(lambda*((d1*do12)*1e3/d))
% v1=sqrt(2)*(c1/R1_1)
% 
% flec_2=(do21*do22*1e3)/(2*K*Ro)
% elev_2=eo2
% alt_rayo_2=((h2+e2-h1-e1)*do21/d)+Ht1
% c2=flec_2+elev_2-alt_rayo_2
% R1_2=sqrt(lambda*((do21*do22)*1e3/d))
% v2=sqrt(2)*(c2/R1_2)
% 
% flec_3=(do31*d4*1e3)/(2*K*Ro)
% elev_3=eo3
% alt_rayo_3=((h2+e2-h1-e1)*do31/d)+Ht1
% c3=flec_3+elev_3-alt_rayo_3
% R1_3=sqrt(lambda*((do31*d4)*1e3/d))
% v3=sqrt(2)*(c3/R1_3)

%Como me sale solo el Obstaculo 2 con v<-0.78, no es obstaculo, solo tengo
%dos obstaculos OBSTACULO 1 y el OBSTACULO 3,y como ambos tienen la v<0,
%METODO 1. v3>v1, Obstaculo 3 el dominante.

%Hay que calcular el parametro de difraccion modificado del obstaculo 1 y 3

%e1_______[d1]_____o1______[d2]_____o2_____[d3]__________o3______[d4]______e2
%e1________[d1]________o1__________________[d2+d3]_______o3
%o1________[d2+d3]______o3__________________[d4]__________e2
%e1________[do31]______o3
%Rayo 1: Desde Estacion 1 hasta Obstaculo 3
%Rayo 2: Desde Obstaculo 1 hasta la Estacion 2
[cp_1,R1p_1,Vp1] = PF(e1,eo3,eo1,h1,ho3,d1,(d2+d3),K,frec)
[cp_3,R1p_3,Vp3] = PF(eo1,e2,eo3,ho1,h2,(d2+d3),d4,K,frec)

%Calulo las perdidas de difraccion (solo cuando v>-0.78)
Ldif_Vp1=6.9+20*log10(sqrt((Vp1-0.1)^2+1)+Vp1-0.1)
Ldif_Vp3=6.9+20*log10(sqrt((Vp3-0.1)^2+1)+Vp3-0.1)

Lad=Ldif_Vp1+Ldif_Vp3+10*log10((do31*(d2+d3+d4))/((d2+d3)*d))
Lbf=20*log10(4*pi*d*1e3/lambda)
L_gases=d*Lambda_gases
PIRE=Ptx+Gtx-Lt
Prxcn=PIRE-Lbf-Lad-L_gases+Gtx-Lt

%Apartado b. Indisponibilidad por lluvia: q
Prxcn=-80.82
MD=Prxcn-Umbral

%PASO 2 (Depende de la frecuencia, polarización y R_001)
gamma_R=k*R_001^(alpha) %[dB/km] 

%PASO 3 ENLACES TERRENALES
r=(0.477*d^(0.633)*R_001^(0.073*alpha)*(frec/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))))
deff=d/r;

%PASO 4 Calculo de F_001
F_001=gamma_R*deff;

%PASO 5 Calculo de Fq
if(frec<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((frec/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=MD
 q_exponente=MD/(F_001*C1)

 
 xa=(C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 xb=(C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
 q1=10^xa
 q2=10^xb
  if q1<q2
     q=q2
 else 
     q=q1
  end 
 
%Apartado c). Calculo del MTTR
UR=0.113
UR_ll=q
UR_equi=UR-UR_ll %UR=UR_equi+UR_ll

%UR_equipos=2*(MTTR/MTBF)*100
MTTR=UR_equi*MTBF/(2*100) %Profe da 6.46dbB
 %UR_equipo=MTTR/MTBF
 


%% EJERCICIO 11 Calculo de la PIRE requerida 

close 
clear all

frec=55e9 %Frecuencia de trabajo [Hz] (e9 porque esta en GHz)
h1=5
e1=500
H1=h1+e1
h2=15
e2=330
H2=h2+e2
d=18 %[km]
%Terrano muy plano
rho=0.01
sigma=0.1 %[s/m]
epsilon_r=20
G=61
%P.V.
Umbral=-130
MTTR=4 %[horas]
MTBF=4e6 %[horas]
Lt=0
K=4/3
Ro=6370 %[km]
%De las graficas tengo el valor de k y de alpha
k=0.7
alpha=0.78
R_001=32 %[mm/h]
UR=0.1 %Expresada en porcentaje
lambda=3e8/frec
lambda_gases=4.34

%Se que UR=UR_equi+UR_ll; UR_ll=q
UR_equi=2*(MTTR/MTBF)*100
UR_ll=UR-UR_equi
q=UR_ll
%PASO 2 (Depende de la frecuencia, polarización y R_001)
gamma_R=k*R_001^(alpha) %[dB/km] 

%PASO 3 ENLACES TERRENALES
r=(0.477*d^(0.633)*R_001^(0.073*alpha)*(frec/1e9)^(0.123)-(10.579*(1-exp(-0.024*d))))
deff=d/r;

%PASO 4 Calculo de F_001
F_001=gamma_R*deff;

%PASO 5 Calculo de Fq
if(frec<10e9)
    Co=0.12;
else
    Co=0.12+0.4*log10(((frec/1e9)/10)^0.8);   
end

C1=(0.07^(Co))*(0.12^(1-Co));
C2=(0.855*Co)+0.546*(1-Co);
C3=(0.139*Co)+0.043*(1-Co);

Fq=F_001*C1*q^(-(C2+C3*log10(q)))
%MD=Fq_001=Prxcn-Umbral
Ptxcn=Umbral+Fq

%Se cuanta potencia tenfo que transmitir, pero ahora tengo que ver cuantas
%perdidas hay en el camino.

%Tengo que saber si mi d es mayor/menor que 10% de Dmax para aplicar Tierra
%Plana o Tierra Curva
dmax=sqrt(2*K*Ro*H1) + sqrt(2*K*Ro*H2);
dlim=0.1*dmax; %Tierra curva


%H2<H1  %CASO DE H2<H1
p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4)); %caluclo de la p
Phi=acos((2*K*Ro*(abs(H1-H2))*d)/p^3); %calculo de Phi (rad)
d1=d/2+p*cos((pi+Phi)/3); %obtengo el dato de d1 "bueno"

d2=d-d1; %[m] 
hp1=H1-(d1^2/(2*K*Ro)); %altura modificada de h1 [m]
hp2=H2-(d2^2/(2*K*Ro)); %altura modificada de h2 [m]
tan_phi_r=hp1/d1; %tengo que sacar el angulo de reflexion
phi_r=atan(tan_phi_r); %obtengo el angulo de reflexion {phi_r} 


%%H2>H1   %CASO DE H2>H1
%p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4)); %calulo de la p
%Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3); %calculo de Phi (rad)
%d2=d/2+p*cos((pi+Phi)/3); %obtengo el dato de d1 "bueno" 

%d1=d-d2; %[m]
%hp1=H1-(d1^2/(2*K*Ro)); %altura modificada de h1 [m]
%hp2=H2-(d2^2/(2*K*Ro)); %altura modificada de h2 [m]
%tan_phi_r=hp1/d1; %tengo que sacar el angulo de refexion {phi_r}
%phi_r=atan(tan_phi_r); %obtengo el angulo de reflexion {phi_r}

%Ahora tengo que comprobar si hay DIFRECCION y REFLEXION:
phi_r_lim=((5400/(frec/1e6))^(1/3))/(1e3); %obtengo el angulo de reflexion límite [mrad]
%phi_r_lim=6.1691e-4 < phi=0.0106 -> REFLEXION TIERRA CURVA

lambda=3*10^8/frec;
epsilon_o=epsilon_r-1j*60*sigma*lambda; %formula epsilon_o


Al=(2*hp1*hp2)/(d);%incremento de longitud

%Factor de Rugosidad
Gamma=(4*pi*rho*sin(phi_r))/(lambda);

%Factor de Reflexión
Rv=(epsilon_o*sin(phi_r)-sqrt(epsilon_o-cos(phi_r)^2))/(epsilon_o*sin(phi_r)+sqrt(epsilon_o-cos(phi_r)^2))

%Factor de Divegencia
D=1/sqrt(1+((5/(16*K))*(((d1/1e3)*(d2/1e3)^2)/((d/1e3)*hp1)))); %Las ditancias en[km] y la altura en [m]

%Formula del COEFICIENTE DE REFLEXIÓN
Re=Rv*D*exp(-(Gamma^2)/2);


lad=1/abs(1+Re*exp(-1i*2*pi*Al/lambda))^2 
Lad=10*log10(lad)
L_gases=d*lambda_gases
Lbf=20*log10(4*pi*d*1e3/lambda)
%(Umbral de recepcion) U=PIRE+G-Lad-L_gases-Lbf-Fq
PIRE=Umbral+Lbf+Lad+L_gases+Fq-G %dBm
