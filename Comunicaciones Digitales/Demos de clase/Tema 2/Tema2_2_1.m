% Comunicaciones digitales, Universidad de Alcalá, curso 2016-17
% Elaborado por Francisco J. Escribano

clear all; close all; clc;

% Initialization

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CB=0:0.1:20;

EbN0=(2.^CB-1)./CB;

semilogy(10*log10(EbN0),CB);
grid
xlabel('E_b/N_0 (dB)');
ylabel('Efficiency (bit/s/Hz)');
axis([-10 50 1e-1 1e2]);

