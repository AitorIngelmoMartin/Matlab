% Comunicaciones digitales, Universidad de Alcalá, curso 2015-16
% Elaborado por Francisco J. Escribano

% clear all; close all; clc;

% Initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trellisCC=poly2trellis(7, [171 133]); % Trellis of the CC
n=2; % n parameter of the CC
k=1; % k parameter of the CC
Rc=k/n; % rate of the code
EbN0dB=0.0:1.0:25.0; % EbN0 vector
bitsperSymb=3; % 8-PSK
M=2^bitsperSymb; % 8-PSK

Pb=berawgn(EbN0dB+10*log10(Rc),'psk',M,'nondiff'); % Bit error rate approximation for the modulation BER, CC + 8-PSK
Pbu=berawgn(EbN0dB,'psk',M,'nondiff'); % Bit error rate approximation for the modulation BER, 8-PSK only

depth=10; % Number of terms to calculate in the CC distance spectrum
dspec=distspec(trellisCC,depth); % Distance spectrum of the CC
Ptbound=zeros(1,size(EbN0dB,2)); % Initialization of the bound vector

for i=1:size(EbN0dB,2)
    
    for l=1:depth
        
        if (dspec.event(l) ~= 0)
            Ptbound(i)=Ptbound(i)+dspec.weight(l)*(2.0*sqrt(Pb(i)*(1-Pb(i))))^((dspec.dfree+l-1)); % Truncated bound calculation
        end
        
    end
    
end

figure(1)
semilogy(EbN0dB,Pbu,'b-x',EbN0dB,Ptbound,'k-+') % Plot results: coded vs uncoded
axis([0 18 1e-8 1e0]); grid;