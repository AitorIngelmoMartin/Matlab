                         
                            %% Tema 2-Test 1
                            
  %% Ejercio 6. Pire, Lbf, Flujo, E, S_ef, Prx
clear 
close all

d=34e3; % Distancia entre las estaciones
f=15e9; %frecuencia de trabajo [hz] (e9 porque esta en GHz)
G=38; % ganacia de las estaciones 1 y 2
Ptx=0;% Potencia entregada de la Estacion 1 [dbW]
long=38; % Distancia de la guia de onda [m]

alfa=5.5/100 %Perdidas de la Gui de onda [dB/m]
Lalim=0.2; %Perdidas del alimentador
lambda=3e8/f;

Lt=long*alfa+Lalim; %Perdidas de la guia de onda [db]
PIRE=Ptx-Lt+G %Calculo de la PIRe [dBW]
Lbf=20*log10(4*pi*d/lambda) %Perdidas espacio libre [db]
Flujo=PIRE-10*log10(4*pi*d^2) %Calculo del flujo [dBW/m2]
e=sqrt(10^(Flujo/10)*120*pi); %Calculo del campo unidades naturales
E=20*log10(e*1e6) %Campo en unidades logaritmicas [dBu]
Sef=lambda^2/(4*pi)*10^(G/10) %Calculo de la Superficie efectiva [m2]
Prx2a=PIRE-Lbf+G-Lt %Calculo de la Potecnia recibida Estacion 2 [dBW]
Prx2b=Prx2a+30 %Calculo de laPotencia recibida Estacion 2 [dBm]
 

%% Ejercicio 7. Perdidas adiccionales por REFLEXION

clear 
close all

h1=300; %dato de la altura antena 1 [m]
h2=150; %dato de la altura antena 2 [m]
cota1=0; %dato de la cota de antena 1 [m]
cota2=0; %dato de la cota de antena 2 [m]
H1=cota1+h1; %suma de altura+cota antena 1 [m]
H2=cota2+h2; %suma de alura+cota antena 2 [m]
d=38e3; %distancia entre estaciones [m]
f=6.2e9; %frecuencia de trabajo [Hz] (e9 porque esta en GHz)
sigma=5; %Conductividad [S/m] 
epsilon_r=70; %Permitividad relativa del terreno
rho=0.5; 
K=4/3; 
Ro=6370*1e3; %Radio de la Tierra [m]

%Tengo que saber si mi d es mayor/menor que 10% de Dmax para aplicar Tierra
%Plana o Tierra Curva
dmax=sqrt(2*K*Ro*H1) + sqrt(2*K*Ro*H2);
dlim=0.1*dmax; %Tierra curva


%H2<H1  %CASO DE H2<H1
p=(2/sqrt(3))*sqrt(K*Ro*abs(H2+H1)+(d^2/4)); %caluclo de la p
Phi=acos((2*K*Ro*abs(H1-H2)*d)/p^3); %calculo de Phi (rad)
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
phi_r_lim=((5400/(f/1e6))^(1/3))/(1e3); %obtengo el angulo de reflexion límite [mrad]
%phi_r_lim=6.1691e-4 < phi=0.0106 -> REFLEXION TIERRA CURVA

lambda=3*10^8/f;
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

lad=1/abs(1+Re*exp(-1i*2*pi*Al/lambda))^2 %saco las perdidas en Unidades Naturales
Lad=10*log10(lad) %obtengo las Lad en dBs

