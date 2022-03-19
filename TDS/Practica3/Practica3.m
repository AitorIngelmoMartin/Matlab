clc;clear;close all;

%%%%%%%%%%%%%%%%%%%%%%EJERCICIO 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Apartado A
c1 = -1;c2 = -1;c5 = 0.5*exp((pi/4)*1i);c4 = conj(1/c5);c3 = conj(c4);
c6 = conj(c5);
p1 =0;p2=0;p3=0;p4=0;p5=0;p6=0;

A = [c1;c2;c5;c4;c3;c6];
B = [p1;p2;p3;p4;p5;p6];
Ak = poly(B);Bk = poly(A);
figure('Name','E2: H(Z)','NumberTitle','off'); 
zplane(Bk,Ak);title('Diagrama Polos/Ceros H(Z)');

figure('Name','E2: Retardo/Modulo H(Z))','NumberTitle','off'); 
subplot(211);grpdelay(Bk,Ak,1029);title('Retardo de grupo');

subplot(212);freqz(Bk,Ak,1029);title("Módulo respuesta en frecuencia H(Z)");

%Apartado B
c1ap= 2*exp((pi/4)*1i);c2ap= 2*exp((pi/4)*-1i);
p1ap = 0.5*exp((pi/4)*1i);p2ap= 0.5*exp((pi/4)*-1i);

num_PTodo = [c1ap;c2ap];
den_PTodo = [p1ap;p2ap];
Bk_Ptodo = poly(num_PTodo);
Ak_Ptodo = poly(den_PTodo);

figure('Name','E2: Sistema paso todo Hap(Z))','NumberTitle','off'); 
zplane(Bk_Ptodo,Ak_Ptodo);title("Sistema paso todo");
figure('Name','E2: Hap(Z)','NumberTitle','off');
subplot(221);grpdelay(Bk_Ptodo,Ak_Ptodo,1029);title("Retardo de grupo paso todo");
subplot(222);freqz(Bk_Ptodo,Ak_Ptodo,1029);title("Modulo respuesta en frecuencia Hap(Z)");

%Apartado C
c1fm= 0.5*exp((pi/4)*1i);c2fm= 0.5*exp((pi/4)*1i);
c3fm= 0.5*exp((pi/4)*-1i);c4fm= 0.5*exp((pi/4)*-1i);
c5fm= -1;c6fm= -1;
p1fm=0;p2fm=0;p3fm=0;p4fm=0;p5fm=0;p6fm=0;
num_FMinima = [c1fm;c2fm;c3fm;c4fm;c5fm;c6fm];
den_FMinima = [p1fm;p2fm;p3fm;p4fm;p5fm;p6fm];

Bk_Fmin = poly(num_FMinima);
Ak_Fmin = poly(den_FMinima);

figure('Name','E2: Sistema Fase mínima Hfmin(Z)','NumberTitle','off');
zplane(Bk_Fmin,Ak_Fmin);title("Sistema fase mínima");

figure('Name','E2: Hfmin(Z)','NumberTitle','off');
subplot(221);grpdelay(Bk_Fmin,A,1029);title("Retardo de grupo fase mínima");
subplot(222);freqz(Bk_Fmin,Ak_Fmin,1029);title("Modulo de la respuesta en frecuencia Hfmin(Z)");
 
%%%%%%%%%%%%%%%%%%%%%%EJERCICIO 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
%Apartado A
c1 =sqrt(2)*exp((pi/4)*i);c2 = -0.5*c1;
p1 =-c1;p2 = 0.5*c1;

Ceros = [c1; c2];
Polos = [p1; p2];
Bk = poly(Ceros);
Ak = poly(Polos);

%Apartado B
figure('Name','Ejercicio 1','NumberTitle','off');zplane(Bk,Ak);
title('Diagrama Polos/Ceros H(Z)');

%Apartado C
%H1(z)
c12 = 0.5+0.5i;c22 = -0.5-0.5i;
p12 = 1+1i;p22= -1-1i;

Ceros2 = [c12,c22];
Polos2 = [p12,p22];
Bk2 = poly(Ceros2);
Ak2 = poly(Polos2);

figure('Name','Ejercicio 1: C','NumberTitle','off');subplot(221);
zplane(Bk2,Ak2);title("Diagrama polos y ceros de H1(z)");

%H2(z)
c13 = 1+1i;c23 = -1-1i;
p13 = 0.5+0.5i; p23= -0.5-0.5i;
A3 = [c13,c23];
B3 = [p13,p23];

Bk3 = poly(A3);
Ak3 = poly(B3);

subplot(222);zplane(Bk3,Ak3);title("Diagrama polos y ceros H2(z)");

%H3(z)
c14 = 0.5+0.5i;c24 = -1-1i;
p14 = 1+1i;p24= -0.5-0.5i;

A4 = [c14,c24];
B4 = [p14,p24];

Bk4 = poly(A4);
Ak4 = poly(B4);
subplot(212);zplane(Bk4,Ak4);title("Diagrama polos y ceros H3(z)");

%Apartado D
c1c = 1+1i;c2c = -1-1i;c3c = 0.5+0.5i;c4c = -0.5-0.5i;
p1c = 1+1i;p2c= -1-1i;p3c = 0.5+0.5i;p4c= -0.5-0.5i;

num_Inv = [c1c;c2c;c3c;c4c];
den_Inv = [p1c;p2c;p3c;p4c];

Bk_Inv = poly(num_Inv);
Ak_Inv = poly(den_Inv);
figure('Name','Ejercicio 1: D','NumberTitle','off');
zplane(Bk_Inv,Ak_Inv);title('Diagrama Polos/Ceros C(Z)');