% Comunicaciones digitales, Universidad de Alcalá, curso 2016-17
% Elaborado por Francisco J. Escribano

clear all; close all; clc;

% Initialization

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SN0=-20:30;
B=3000;

C_1=B*log2(1+10.^(SN0/10)/B);

plot(SN0,C_1);
grid;
xlabel('S/N_0 (dB)');
ylabel('Capacity (bit/s)');

SN0=25;
B=0:100000;

C_2=B.*log2(1+10.^(SN0/10)./B);

figure;
plot(B,C_2);
grid;
xlabel('B (Hz)');
ylabel('Capacity (bit/s)');