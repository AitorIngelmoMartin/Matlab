                               %% Tema 4 test 1

%% EJERCICIO 3. CALCULO DEL ANCHO DE BANDA

clear
close all

Rb= 7e6 %Una señal de... [bps] (e6 porque esta en Mbps)
M=128 %Orden de modulacion
roll_off=0.3 

B_filtrado=(1+roll_off)*(Rb/log2(M)) %Resultado en Hz
B_filtrado_MHz=B_filtrado/1e6

%% EJERCICIO 6. CALCULO DE TEMPERATURA EQUIVALENTE (Ateneador)

clear
close all

L=4 %[dB]
To=290
K=1.38e-23

l=10^(L/10)
Teq=To*(l-1)

%% EJERCICIO 8. CALCULO TEMPERATURA EQUIVALENTE (Factor ruido y ganancia)

clear
close all

G=10 %[dB]
F=3 %[dB]
To=290 %Temperatura ambiente
K=1.38e-23

g=10^(G/10)
f=10^(F/10)
Teq=To*(f-1)


n_int=K*Teq
n_out=n_int*g*f
N_out=10*log10(n_out)+30 %Le sumo 30 para tenerlo en dBm, si no lo tengo en dB)

 
%% EJERCICIO 11. CALCULO DE LA POTENCIA A TRANSMITIR

clear 
close all

%ESTACION 1
r1=0.95;%rendimiento. supongo que será la eficiencia (e)
D1=6; %Dato directividad en  dB
d1=10^(D1/10) %Dato directividade en UN 
long1=10; %[m]
aten_cable=0.076; %[dB/m]
Lt1=aten_cable*long1

g1=r1*d1; %Ganancia es el rendimiento por la directividad, pero en UN)
G1=10*log10(g1); %Dato de la ganancia 1 en dB


%ESTACION 2 (dipolo lambda/2)
G2=2.15;
long2=2;%m
Lt2=aten_cable*long2

d=35; %Distancia del enlace
f=450e6; %Frecuencia de trabajo [Hz] (e9 porque esta en MHz)
Lad=20; %Perdidas en dB
Flujo=-109; %Flujo incidente de potencia en ambas estaciiones [dBW/m2] 

lambda=3e8/f;

%Ptx=PIRE+Lt1-G1
%PIRE=FLUJO+10*log10(4*pi*(d*1e3)^2)+Lad
%Ptx=FLUJO + 10*log10(4*pi*(d*1e3)^2) * Lad + Lt1 - G1

Ptx1=Flujo+10*log10(4*pi*(d*1e3)^2)+Lt1-G1+Lad %dBW %Dato de distancia en [m]
Ptx2=Flujo+10*log10(4*pi*(d*1e3)^2)+Lt2-G2+Lad %dBW %Dato de distancia en [m]


%% EJERCICIO 12. CALCULO DE LA DEGRADACION DEL FILTRO

clear 
close all

%Con la funcion de berawgn obtengo en dato DEGRADADO

CNRmin=17.5 %Dato en dB {Eb/No(min)}
%Eb_No_min=CNRmin
BER=1e-3 
%Modulacion de 64QAM
M=64;

CNR_deg=CNRmin;%CNR degradada la igualo a la minima, esto seria en el mejor de los casos
%Ahora calculo cuanto es la CNR degradada, para eso
BER_deg=-1;%por poner algo que cumpla la condición de entrada al bucle.

while(BER>=BER_deg)
 CNR_deg=CNR_deg-0.01; %El valor de CNR va decayendo hasta ser el que cumple BER=1e-3
 BER_deg=berawgn(CNR_deg,'qam',M);
end

Atenu_filtro=CNR_deg-CNRmin %Degradada = min + altenuacion filtro
BER1=berawgn(CNRmin+Atenu_filtro,'qam',M);

% berawgn(Eb/No[dB],'qam',M_numerodeniveles de la modulacion)


%% EJERCICIO 13. CALCULO DEL MARGEN DINAMICO DEL ATENUADOR

clear
close all

d=10 %Distancia del enlace en [km]
frec=13e9 %Frecuencia de trabajo en Hz (e9 porque esta en GHz)
ptx=25 %Expresado en mW
Ptx=10*log10(25)
Lt1=1.5 %[dB]
G1=28 %[dB]
g1=10^(G1/10)

G2=23 %[dB]
Lt2=1.2 %[dB]
F=8.5 %[dB]
lt2=10^(Lt2/10) %Perdidas del atenuador en UN
f=10^(F/10) %Factor de ruido en UN

Bn=5e6 %Ancho de banda de trabajo en Hz
%Modulacion 16-PSK
M=16
Roll_off=0.3 
Atenu_filtro=1 %Atenuacion del filtro en dB
Eb_No_min=18 %[dB]
BER=10*1e-3

K=1.38*1e-23
To=290
gamma_g=0.15
lambda=3e8/frec

%Necesito el Rb y la T_total para calcular la U
T_in=To
T1=To*(f-1)
T2=To*(lt2-1)
T_total=T_in*g1/lt2 + T1*g1/lt2 + T2/lt2
Rb=Bn*log2(M)/(1+Roll_off)

Eb_No_degr=Eb_No_min+Atenu_filtro
Umbral=Eb_No_degr+10*log10(K*T_total*Rb)

Lad=0
Lbf=20*log10(4*pi*d/lambda)
L_gases=gamma_g*d
PIRE=Ptx-Lt1-G1
Prxcn=PIRE-Lad-Lbf-L_gases-Lt2+G2
MD=Prxcn-Umbral %L_vble: Prxcn=U+MD



%% Ej 7 (ENRIQUE)
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
Tx=Ta*grx + To*(fr-1) + To*(lt2-1);

EbNodeg=EbNomin-Delta_filtro;
U=EbNodeg+10*log10(K*Tx*Rb);%imagino que son dBW
Lb=20*log10(4*pi*d/lambda)+gammaO*d*1e-3;
Prxcn=10*log10(ptx)+30-Lt1+Gtx-Lb+Grx-Lt2;%dBW


MD=Prxcn-U