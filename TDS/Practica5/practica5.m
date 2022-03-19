clc;clear; close all;

%%%%%%%%%%%%%%%%%%%%%%APARTADO A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 2^11;

Bk = [1 -0.1535 -0.8082 0.2953 -0.0500];
Ak = [1 -0.6470 -0.3819 -0.1464 0.4356];

Noise_var =5;
vn = randn(1,N)*sqrt(Noise_var);

xn =filter(Bk,Ak,vn);

%%%%%%%%%%%%%%%%%%%%%%APARTADO B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
[h,w]=freqz(Bk,Ak,N);

DEP_Xn_real = abs(Noise_var*(h.^2));
plot(w/pi,DEP_Xn_real);title("DEP del proceso")


%%%%%%%%%%%%%%%%%%%%%%APARTADO C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resolucion_FFT = 2^ceil(log2(length(xn)));
transformada =(fft(xn,resolucion_FFT).^2)/N;

xn_fft = abs(transformada);
F = linspace(0,2,size(xn_fft,2));

figure(2);subplot(211);
plot(F,xn_fft/pi);title("Periodograma de con FFT");
xlim([F(1) F(end)/2]);

[prx, vx2] = pwelch(xn,rectwin(N),0,N);

subplot(212);
plot(vx2/pi,prx);title("Estimación empleando pwelch");


%%%%%%%%%%%%%%%%%%%%%%APARTADO D%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


L=128;
[prx, vx2] = pwelch(xn,hamming(L),L/2,N);

figure(3);
subplot(211);plot(vx2/pi,prx*pi);
title("Estimación empleando el promedio 50% solapamiento");


%%%%%%%%%%%%%%%%%%%%%%APARTADO E%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


longitud_xn =length(xn);
K = fix(longitud_xn/L);

Wn = hamming(L);
for i=0:(K-1)
   senial_en_tiempo=fft(xn.*Wn);
end
transformada = (1/K).*senial_en_tiempo; 

for i=0:L-1
   ventana_U = (Wn).^2; 
end
U = (1/L)*ventana_U;

salida = (1/(L*U))*abs(transformada);
subplot(212);plot(salida);
