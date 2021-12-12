% Comunicaciones digitales, Universidad de Alcalá, curso 2016-17
% Elaborado por Francisco J. Escribano

clear all; close all; clc;

% Initialization

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CB=0:0.1:40;

EbN0=(2.^CB-1)./CB;

semilogy(10*log10(EbN0),CB);
grid;
hold;
xlabel('E_b/N_0 (dB)');
ylabel('Efficiency (bit/s/Hz)');
axis([-10 50 1e-1 1e2]);

M=[4 8 16 32 64];
Pb=1e-5;

Eff_PSK=log2(M)/2;
EbN0_PSK=0.5*(qfuncinv(Pb*log2(M)/2)./sin(pi./M)).^2./log2(M);

semilogy(10*log10(EbN0_PSK),Eff_PSK,'k*--');

Eff_FSK=2*log2(M)./(M+3);
EbN0_FSK=(qfuncinv(Pb*(2.^log2(M)-1)./(2.^(log2(M)-1).*(M-1)))).^2./log2(M);

semilogy(10*log10(EbN0_FSK),Eff_FSK,'rs-.');
legend({'AWGN Capacity','PSK','FSK'},'FontSize',12)
legend('show');