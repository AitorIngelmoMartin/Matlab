% Comunicaciones digitales, Universidad de Alcalá, curso 2016-17
% Elaborado por Francisco J. Escribano

clear all; close all; clc;

% Initialization

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gamma=-20:20;
p=qfunc(sqrt(2*10.^(gamma/10)));

semilogy(gamma,p);
grid;
xlabel('\gamma (dB)');
ylabel('p');
axis([-20 15 1e-10 1e0]);

C=1+p.*log2(p)+(1-p).*log2(1-p);

figure;
plot(gamma,C);
grid;
xlabel('\gamma (dB)');
ylabel('Capacity (bits/channel use)');