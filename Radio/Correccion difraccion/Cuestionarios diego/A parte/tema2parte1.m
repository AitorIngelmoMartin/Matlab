%Tema 2 parte 1
clc;
clear;
d=35e3; %Distancia entre estaciones en metros
k=4/3; %Factor K
f=6e9; %Frecuencia de trabajo en Hz
er=70; %Permitividad relativa
ro=0.1; %Factor de rugosidad
polarizacion=1; %Polarizacion vertical 1, polarizacion horizontal 0
conductividad=5; %Conductividad del medio en S/m
R0=6370e3; %Radio terrestre en metros
h1=150; %Altura antena 1 en metros 
h2=300; %Altura antena 2 en metros
lambda=3e8/f; %Lambda = c/f
dh1 =2*k*R0*h1; %Linea de vista desde estacion 1 a mitad
dh2=2*k*R0*h2; %Linea de vista desde estacion 2 a mitad
dmax=sqrt(dh1)+sqrt(dh2); %Linea de vista (LOS) de est1 a est2

%Tierra Curva
if(d>0.1*dmax)
    p=(2/sqrt(3))*(k*R0*(h1+h2)+(d^2)/4)^(1/2);
    if(h1>h2)
        tetha=acos((2*k*R0*(h1-h2)*d)/p^3); 
        d1=(d/2)+p*cos((pi+tetha)/3);
        d2=d-d1;
    end
    if(h2>h1)
        tetha=acos((2*k*R0*(h2-h1)*d)/p^3);
        d2=(d/2)+p*cos((pi+tetha)/3);
        d1=d-d2;
    end
hp1=h1-(d1^2)/(2*k*R0);
hp2=h2-(d2^2)/(2*k*R0);
phi=atan(hp1/d1);
end
phi_lim = ((5400/(f/1e6))^(1/3))/1000;


%Reflexion
e0=er-1i*60*conductividad*lambda;
if polarizacion==1
RV=(e0*sin(phi)-sqrt(e0-(cos(phi))^2))/(e0*sin(phi)+sqrt(e0-(cos(phi))^2));
R=RV;
end
if polarizacion==0
RH=(sin(phi)-sqrt(e0-(cos(phi))^2))/(sin(phi)+sqrt(e0-(cos(phi))^2));
R=RH;
end
D=(1+(5/(16*k))*(((d1/10^3)^2)*(d2/10^3))/((d/10^3)*hp1))^(-1/2);%distancias en km y altura en metros
gamma=(4*pi*ro*sin(phi))/lambda;
RE=R*D*exp(-(gamma^2)/2);
difcaminos=(2*hp1*hp2)/d;%todo en metros
Lad=-20*log10(abs(1+RE*exp(-1i*((2*pi)/lambda)*difcaminos)));