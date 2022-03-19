clc;clear;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%Diseño de la señal%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L = 200;
Beta = 0.5;
Omega1 = pi/15;Omega2=pi/7;Omega3=2*pi/5;
K = 20;
n=0:(L-1);

x1 = PassBandSig_4_DSP(L,Omega1,K);
x2 = PassBandSig_4_DSP(L,Omega2,K);
x3 = PassBandSig_4_DSP(L,Omega3,K);

x = (x1+x2+x3);

xn = x+Beta*randn(1,L);  
%%%%%%%%%%%%%%%%%%%%%%Representacion de la señal%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);subplot(211);stem(n,xn);title("Señal X[n]");

N = max([2^ceil(log2(L)+1) 2048]); %puntos de la DFT.
Xk = fft(x,N);
F = linspace(0,pi,N/2);subplot(212);plot(F,abs(Xk(1:N/2)));xlim([0 F(end)]);
title("Módulo del espectro digital");

%%%%%%%%%%%%%%%%%%%%Representacion analógica de la señal%%%%%%%%%%%%%%%%%%%
fs = 350; Ts = 1/fs; f = F/Ts;

figure(2)
subplot(211);plot(n*Ts,xn);title("Señal X(t) con fs=0.35khz");

subplot(212);plot(f,Ts*abs(Xk(1:N/2)));
xlim([0 1/Ts*F(end)]);grid on;
xlabel("Frecuencia f(HZ)");ylabel('Amplitud');
title('Módulo del espectro de X(t)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PARTE 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Phir = (pi-(-pi)).*rand(1,1)-pi; %Hacer que valgan números decimales tambien
fr =50;
A =10;
v_PLI =A*cos(2*pi*fr*n*Ts+Phir);
x_PLI = x + v_PLI;

figure(3)
subplot(211);plot(n*Ts,x_PLI);title("Señal x_PLI(t)");

x_PLIk = fft(x_PLI,N);
subplot(212);plot(f,Ts*abs(x_PLIk(1:N/2)));
xlim([0 1/Ts*F(end)]);grid on;
xlabel("Frecuencia f(HZ)");ylabel('Amplitud');
title('Modulo del espectro de x_PLI(t)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTE 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pulsacion_ruido = 2*pi*fr*Ts;

c1 = 1*exp((pulsacion_ruido)*1i);c2 = conj(c1);
p1 = 0.9*exp((pulsacion_ruido)*1i);p2 = conj(p1);

A = [c1;c2];
B = [p1;p2];

Ak = poly(B);Bk = poly(A);
factor_multiplicativo = ((1-p1)*(1-p2))/((1-c1)*(1-c2));

figure('Name','H(Z) notch','NumberTitle','off'); 
subplot(211);zplane(Bk,Ak);title('Diagrama Polos/Ceros H(Z) filtro notch');

salida_sin_ruido = factor_multiplicativo*filter(Bk,Ak,x_PLI);
espectro_salida_sin_ruido = fft(salida_sin_ruido,N);

subplot(212); xlim([0 1/Ts*F(end)]);grid on;
plot(f,Ts*abs(espectro_salida_sin_ruido(1:N/2)));
xlabel("Frecuencia f(HZ)");ylabel('Amplitud');
title('Modulo del espectro de x_PLI(t) sin ruido');

function [x] = PassBandSig_4_DSP(L,Omega_0,K)
%Dominio de definición 
    n=0:(L-1);
    x=cos(Omega_0*n);
    alphaK=(0.02)*randn(1,1);

   for k=1:K      
     sigma_k=(1+(k/25))^-1;

     A1=sigma_k*randn(1,1);
     A2=sigma_k*randn(1,1);

     Phi1=-pi+(pi-(-pi))*rand(1,1);
     Phi2=-pi+(pi-(-pi))*rand(1,1);

     Omega_K=Omega_0*(1+(alphaK*k));

     x1=cos((Omega_K*n)+Phi1);
     x2=cos(((((Omega_0)^2)/Omega_K)*n)+Phi2);

     x=x+A1*x1+A2*x2;
    end
end