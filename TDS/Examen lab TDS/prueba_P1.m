clear;clc;close all;

L = randi(500)+100;

I = fix((rand*6+2)*10)/10;
Omega=pi/I;

K = randi(20)+15;

x = PassBandSig_4_DSP(L,Omega,K);

%Representación de la señal x[n] en el dom del tiempo
figure(1)
n = 0:L-1;
subplot(311), stem(n,x)
xlabel('n')
ylabel('x[n]')
title(['Señal en el dominio del tiempo: L = '...
num2str(L) ' y K=' num2str(K) '.'])
xlim([n(1) n(end)])
subplot(312), plot(n,x)
xlabel('n')
ylabel('x[n]')
title('x[n] representada con plot.')
xlim([n(1) n(end)])
% calculo y representación del espectro de la señal.
N = min([2^ceil(log2(L)+1) 2048]); % Resolución para el cálculo DFT

X_w = abs(fftshift(fft(x,N))).^2/L; % Cálculo del periodograma.
F = linspace(-1,1,size(X_w,2));
figure(1)
subplot(313), plot(F,X_w)
xlim([F(1) F(end)]), grid on
xlabel('Frecuencia normalizada ($F = \Omega/\pi$)',...
'Interpreter','latex','FontSize',13)
ylabel('$\left\vert X\left(e^{j\Omega} \right) \right\vert$',...
'Interpreter','latex','FontSize',13)
title(['Representación del espectro de x[n]: F_0 = '...
num2str(Omega/pi,'%.2f') '.'])