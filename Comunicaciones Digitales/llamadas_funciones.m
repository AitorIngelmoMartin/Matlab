clc;clear; close all;

secuenciaBinaria = [0 1 1 0 0 0 1 0 1 0 1 1 0 0 1 0];
frecuencia = 10000;

[signal,salidaBinaria]=modulacion_ASK(secuenciaBinaria,frecuencia,100);

figure(1);subplot(211);plot(signal);grid on;title("Modulación ASK");
axis([0 length(signal) -2.5 2.5]);

subplot(212);plot(salidaBinaria,"lineWidth",2.5);grid on;title("Señal binaria");
axis([0 length(signal) -2.5 2.5]);


% % % % % % % % % % % % % % % % % OOK % % % % % % % % % % % % % % % % % % %
secuenciaBinaria = [1 0 0 0 1 1 1 0 1 0 0 1 0 0 0];

[signal,salidaBinaria]=modulacion_OOK(secuenciaBinaria,frecuencia,100);

figure(2);subplot(211);plot(signal);grid on;title("Modulación OOK");
axis([0 length(signal) -2.5 2.5]);

subplot(212);plot(salidaBinaria,"lineWidth",2.5);grid on;title("Señal binaria");
axis([0 length(signal) -2.5 2.5]);

% % % % % % % % % % % % % % % % % FSK % % % % % % % % % % % % % % % % % % %
frecuenciaBaja =500;frecuenciaAlta=1500;
secuenciaBinaria = [1 1 0 1 0 0 0 1 0 1 0 0 0 1 1 1 0 1 0 1 0 0 0 1 1];

[signal,salidaBinaria]=modulacion_FSK(secuenciaBinaria,frecuenciaBaja,frecuenciaAlta,100);

figure(3);subplot(211);plot(signal);grid on;title("Modulación FSK");
axis([0 length(signal) -2.5 2.5]);

subplot(212);plot(salidaBinaria,"lineWidth",2.5);grid on;title("Señal binaria");
axis([0 length(signal) -2.5 2.5]);

% % % % % % % % % % % % % % % % BPSK % % % % % % % % % % % % % % % % % % %

secuenciaBinaria = [1 1 0 1 0 0 1 0 1 0 0 1 1 1 0 1 0 0];

[signal,salidaBinaria]=modulacion_BPSK(secuenciaBinaria,frecuencia,100);

figure(4);subplot(211);plot(signal);grid on;title("Modulación BPSK");
axis([0 length(signal) -2.5 2.5]);

subplot(212);plot(salidaBinaria,"lineWidth",2.5);grid on;title("Señal binaria");
axis([0 length(signal) -2.5 2.5]);

% % % % % % % % % % % % % % % % QPSK % % % % % % % % % % % % % % % % % % %

