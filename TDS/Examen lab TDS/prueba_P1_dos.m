clear;clc;close all;

L = randi(500)+100;

I= fix((rand*6+2)*10)/10;

K = randi(20)+15;
Omega = pi/I;

x = PassBandSig_4_DSP2(L,Omega,K);

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

function x = PassBandSig_4_DSP2(L,Omega_0,K)
    
    ak = rand*0.02;
    n=(0:L-1);
    
    for k=1:K
        Phi1=randn*(2*pi-pi);
        Phi2=randn*(2*pi-pi);
        
        OmegaK = Omega_0*(1+ak*k);
        SigmaK = (1+(k/25))^-1;
        A1 = randn*SigmaK;
        A2 = randn*SigmaK;
        
        sumatorio=A1*cos(OmegaK*n+Phi1)+A2*cos(((Omega_0^2)/OmegaK)*n + Phi2);
    end
    x = cos(Omega_0*n) + sumatorio;
end
