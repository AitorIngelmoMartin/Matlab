% Comunicaciones digitales, Universidad de Alcalá, curso 2015-16
% Elaborado por Francisco J. Escribano

clear all; close all; clc;
tic

% Initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trellisCC=poly2trellis(7, [171 133]); % Trellis of the CC
Eb=1.0; % Bit energy
Tb=1.0; % Bit period
Pb=Eb/Tb; % Bit power
n=2; % n parameter of the CC
k=1; % k parameter of the CC
Rc=k/n; % Rate of the CC
bitsperSymb=3; % 8-PSK
M=2^bitsperSymb; % 8-PSK
symbNum=10000; % Number of symbols per packet
bitsperPacket=bitsperSymb*symbNum; % Number of info bits per packet

EbN0dB=0.0:1.0:25.0; % EbN0 vector
BERc=zeros(size(EbN0dB)); % Coded BER vector
BERu=zeros(size(EbN0dB)); % Uncoded BER vector
sigma2_c=0.5*(1/(bitsperSymb*Rc))*10.^(-EbN0dB/10)*Pb; % Noise variance for the coded case
sigma2_u=0.5*(1/(bitsperSymb))*10.^(-EbN0dB/10)*Pb; % Noise variance for the uncoded case

BERmin=1e-4; % Stop criterion for simulation: minimum BER to reach
bitsErr=1000; % Stop criterion for each EbNo run: minimum number of error bits to count

maxnumPackets=100000000; % Time is limited: maximum number of packets to simulate
tblen=symbNum; % Block length for Viterbi algorithm
hModulator=comm.PSKModulator(M,'BitInput',true); % Modulator structure for 8-PSK
hDemod=comm.PSKDemodulator(M,'BitOutput',true); % Demodulator structure for 8-PSK

for i=1:size(EbN0dB,2) % EbN0 loop
    
   packets=0;
    
   while (BERc(i)<bitsErr) && (packets<maxnumPackets) % Packet loop
       
    bitsc=floor(rand(1,bitsperPacket)*2); % Source bits for the coded case
    bitsu=floor(rand(1,bitsperPacket)*2); % Source bits for the uncoded case
    
    codedBits=convenc(bitsc,trellisCC); % Convolutionally encode info bits
   
    modDatac=hModulator(codedBits'); % Modulate the coded bits
    modDatau=hModulator(bitsu'); % Modulate the uncoded bits
    
    noisyDatac=modDatac+sqrt(sigma2_c(i))*(randn(size(modDatac))+sqrt(-1)*randn(size(modDatac))); % Add noise to the symbols, coded case
    noisyDatau=modDatau+sqrt(sigma2_u(i))*(randn(size(modDatau))+sqrt(-1)*randn(size(modDatau))); % Add noise to the symbols, uncoded case
    
    demodDatac=hDemod(noisyDatac); % Demodulate received symbols for the coded case
    demodDatau=hDemod(noisyDatau); % Demodulate received symbols for the uncoded case
    
    decodedBits=vitdec(demodDatac',trellisCC,tblen,'trunc','hard'); % Hard decode CC with Viterbi algorithm
    
    BERu(i)=BERu(i)+size(find(bitsu ~= demodDatau'),2); % Compute error bits for the uncoded case
    
    BERc(i)=BERc(i)+size(find(bitsc ~= decodedBits),2); % Compute error bits for the coded case
    
    packets=packets+1; % Just another packet
       
   end
   
   BERu(i)=BERu(i)/(packets*bitsperPacket) % Compute uncoded BER
   BERc(i)=BERc(i)/(packets*bitsperPacket) % Compute coded BER
   
   if (BERc(i) <= BERmin) % Assess finish condition
       break;
   end
   
end

figure(2)
semilogy(EbN0dB,BERc,'r-x',EbN0dB,BERu,'g-+'); % Plot comparative results
axis([0 18 1e-8 1e0]); grid;
toc