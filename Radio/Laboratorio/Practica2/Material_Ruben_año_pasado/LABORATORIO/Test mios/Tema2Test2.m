                            %% Tema 2 test 2


 %% Ejercicio 2 Calculo de flujo, campo y potencia recibida
clear 
close all

Ptx=5; %Potencia estacion [w]
f=900e6; %Frecuencia de trabajo [Hz] (e6 porque esta en MHz)
Gtx=42; %Ganacia de las antenas
Lt1=3; %Perdidas de los terminales 1 [dB]
lambda=3e8/f;

% APARTADO 1: Calcular Flujo, E y Prx.
d=8e3; %Distancia entre las estaciones [m]
Grx=35; %Ganancia de la antena receptora [dB]
Lt2=1; %Perdidas de los terminales 2 [dB]

PIRE=10*log10(Ptx)-Lt1+Gtx; %Calulo PIRE (Ptx hay que ponerla en dB)
flujo_1=10^(PIRE/10)/(4*pi*d^2) %Calculo del flujo [W/m2]
Flujo_1=10*log10(flujo_1) %Calculo del flujo en [dBW/m2]

e_1=sqrt(flujo_1*120*pi) %Calculo del campo en [V/m]
E_1=20*log10(e_1*1e6) %Calculo del campo en [dBu]

Sef_1=lambda^2/(4*pi)*10^(Grx/10); %Calculo de la S_ef [m^2]
prx_1=flujo_1*Sef_1*(1/10^(Lt2/10)) %Calculo de la Potencia Recibida 2 [W]
Prx_1=10*log10(prx_1) %Calculo de la Potencia Recibida 2 [dBW]

% Apartado 2: Calcular Flujo, E y Prx.
d=11e3; %Distancia entre las estaciones [m]
Grx=35; %Ganancia de la antena 2 [db]
Lt2=1; %Perdidas del terminal 2 [dB]
Gtx_2=42-46 %ganacia real a 30º -46.9dB (Lo miramos en la gráfica)

PIRE_2=10*log10(Ptx)-Lt1+Gtx_2; %Calulo PIRE (Ptx hay que ponerla en dB)
flujo_2=10^(PIRE_2/10)/(4*pi*d^2) %Calculo del flujo [W/m2]
Flujo_2=10*log10(flujo_2) %Calculo del Flujo en [dBW/m2]

e_2=sqrt(flujo_2*120*pi) %Calculo del campo en [V/m]
E_2=20*log10(e_2*1e6) %Calculo del campo en [dBu]

Sef_2=lambda^2/(4*pi)*10^(Grx/10);%Calculo de la S_ef [m2]
prx_2=flujo_2*Sef_2*(1/10^(Lt2/10)) %Calculo de la Potencia Recibida 2 [W]
Prx_2=10*log10(prx_2) %Calculo de la Potencia Recibida 2 [dBW]


 %% Ejercicio 3. PIRE, Perdidas totales y Potencia disponible entrada Rx
clear 
close all

f=100e6; %Frecuencia en [Hz] (e6 porque esta en MHz)
d=10e3; %Distancia entre enlaces [m]
ptx=100; %Potencia entregada [mW]
G=6; %Ganancia de la antena [dB]
Lt=2; %Perdidas de los terminaes [dB]
long=25; %Longitud del cable coaxial [m]
Lad=2; %Perdidas debida a la propagacion/reflexión [dB] (perdidas adiccionales)
lambda=3e8/f;
alfa=0.001*f/1e6 %Atenucaion del cable coaxil [dB/m]

%calcular PIRE, Prx y Ltotal entre TX y RX

Ptx=10*log10(ptx); %Calculo de la potencia transmitida en [dBm]
Ltx=alfa*long+Lt; %Calculo de las perdidas del transmisor [dB] (terminales + cable)
PIRE=Ptx+G-Ltx %Calculo de la PIRE en [dBm] (a la salida de la antena)

Lrx=Ltx; %Perdidas del transmisor y del receptor 
Lb=20*log10(4*pi*d/lambda)+Lad; %Calculo de las pertidas en "condiciones normales"

%Para calcular las perdidad totales hay que tener en cuenta las perdidas de
%los conectores, las ganancias de ambas antenas y las perdidas en
%condicciones normales.
Ltotal=Ltx-G+Lb+Lrx-G %Calculo de las Perdidas Totales [dB]

Flujo=PIRE-10*log10(4*pi*d^2)-Lad; %Calculo de flujo en [dBw/m^2]
Sef=lambda^2/(4*pi)*10^(G/10); %Calculo de la superficio efectiva [m^2]
Prx=Flujo+10*log10(Sef)-Lrx %Calculo de la Potencia recibida [dBm]

 
%% Ejercio 10. Calculas Parametro Difracción, perdidas difracción y  despejamiento modificado

clear 
close all

f=38e9; %Frecuencia de trabajo [Hz] (e9 porque son GHz)

d=50; %Distancia entre las ESTACIONES [km]
d1= 25 %Distancia de la ESTACION 1 al OBSTACULO 1
do1=44; %Distancia al ESTACION 1 y OBSTACULO 2 [km]
do2=d-d1; %Distancia al OBSTACULO 1 y ESTACION 2 [km]
d2= do1-do2 %Distancia entre OBSTACULO 1 y OBSTACULO 2
d3= d-do1 %Distancia entre OBSTACULO 2 y ESTACION 2

e1=150; %Elevación de la estacion 1 [m]
e2=200; %Elevacion de la estacion 2 [m]
h1=150; %Altura de la estacion 1 [m]
h2=40; %Altura de la estacion 2 [m]
Ht1=e1+h1
Ht2=e2+h2
eo1=260; % Elevacion del Obstáculo 1 [m]
eo2=225; %Elevacion del Obstaculo 2 [m]
ho1=0; %Altura del Obstaculo 1 [m]
ho2=0; %Altura del Obstaculo 2 [m]

K=4/3; 
Ro=6370; %Radio de la Tierra [km]


lambda=3e8/f;
%cálculo de las distintas separaciones:
%-e1-______[d1]______-O1-______[d2]_____-O2-______d3______-e2
% e1_____[do1]_____O2
% O1_____[do2]_____e2
% e1_________________________[d]____________________e2

%cálculo del despejamiento (c) y el parámetro de difracción (V):
%Entre estaciones y obstaculo 1
flec_1=(d1*do2*1e3)/(2*K*Ro)
elev_1=eo1
alt_rayo_1=((h2+e2-h1-e1)*d1/d)+Ht1
c1=flec_1+elev_1-alt_rayo_1
R1_1=sqrt(lambda*((d1*do2)*1e3/d))
v1=sqrt(2)*(c1/R1_1)

%Entre estaciones y obstaculo 2
flec_2=(do1*d3*1e3/(2*K*Ro))
elev_2=eo2
alt_rayo_2=((h2+e2-h1-e1)*do1/d)+Ht1
c2=(flec_2+elev_2)-alt_rayo_2
R1_2=sqrt(lambda*((do1*d3)*1e3/d))
v2=sqrt(2)*(c2/R1_2)

%v1=3.81(->v1>0) y v2=-1.45(->v2<0) -> SERÍA METODO 2
%V1>V2-> O1 es el OBSTACULO DOMINANTE.
%Uso rayo alternativo que va desde OBSTACULO 1 hasta la ESTACION 2 ->cp_2
%Tengo que calcular el despejamiento modificado del OBSTACULO 2.

%-O1-______[d2]_____-O2-______d3______-e2
% e1_____[d2]_____O2
% O1_____[do2]_____e2
% 01_________________________[dp=d02]____________________e2

d1= 25 %Distancia de la ESTACION 1 al OBSTACULO 1
do1=44; %Distancia al ESTACION 1 y OBSTACULO 2 [km]
do2=d-d1; %Distancia al OBSTACULO 1 y ESTACION 2 [km]
d2= do1-d1 %Distancia entre OBSTACULO 1 y OBSTACULO 2
d3= d-do1 %Distancia entre OBSTACULO 2 y ESTACION 2

flecp_2=(d2*d3*1e3/(2*K*Ro))
elevp_2=eo2
altp_rayo_2=((h2+e2-ho1-eo1)*d2/do2)+eo1
cp2=(flecp_2+elevp_2)-altp_rayo_2 %Calculo del DESPEJAMIENTO MODIFICADO
R1p_2=sqrt(lambda*((d2*d3)*1e3/do2))
vp2=sqrt(2)*(cp2/R1p_2)

%Ahora calculo las Perdidas Adiccionales (Lad), 

Ldif_v1=6.9+20*log10((sqrt((v1-0.1)^2)+1)+v1-0.1)
if (v1 <= -0.78)
    Ldif_v1=0
else 
    Ldif_v1=6.9+20*log10((sqrt((v1-0.1)^2)+1)+v1-0.1)
end 
    Lad_1=Ldif_v1

    
Ldif_vp2=6.9+20*log10((sqrt((vp2-0.1)^2)+1)+vp2-0.1)
if (vp2 <= -0.78)
    Ldif_vp2=0
else 
    Ldif_vp2=6.9+20*log10((sqrt((vp2-0.1)^2)+1)+vp2-0.1)
end
    Lad_2=Ldif_vp2
    
p=v1
q=v2
tg_alfa=((d*d2)/(do1*d3))^(0.5)
alfa=atan(tg_alfa)
Tc=(12-20*log10(2/(1-(alfa/pi)))*(q/p))^(2*p)
 
Lad=Ldif_v1+Ldif_vp2-Tc


%% EJERCICIO 12. Calculo de las perdidas adiccionales de absorción (GASES)

clear
close all

d=20 %[km]
frec=20e6 %[Hz] (e6 porque esta en GHz)

%Cojo el dado de las graficas (TEMA 2-02) Enlaces terrestres (GRIS)
gamma=0.1
Lad=gamma*d %Obtengo las perdidas adiccioneles en [dB]

%% EJERCICIO 13. Calculo de las perdidas adiccionales de absorcion (GASES)

clear
close all

d=390000 %[km]
frec=14e6 %[Hz] (e6 porque esta en GHz)
angulo=25

gamma=0.07 %Cojo el dato de las graficas (TEMA 2-02) Enlaces especiales (NEGRA)
Lad=gamma/sind(angulo)
