% Comunicaciones digitales, Universidad de Alcalá, curso 2018-19
% Elaborado por Francisco J. Escribano; corregido por Pedro Amo

clear all; close all; clc;

% Initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PARTE 1. Codificacion de LBC.

%numBits=400; % Total number of bits
numBits=400;

n=7; % Length of the codeword
k=4; % Length of the info word

G=[1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1]; % Generator matrix

H=[1 1 0 1 1 0 0; 1 0 1 1 0 1 0; 0 1 1 1 0 0 1]; % Parity check matrix

infoBits=(rand(1,numBits)>0.5);
uncodedBlocks=reshape(infoBits,k,numBits/k)';

codedBlocks=mod(uncodedBlocks*G,2); % Coding
codedBits=reshape(codedBlocks',1,n*numBits/k);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PARTE 2. Decodificacion de LBC: deteccion y correccion.

p=0.1; % Transition probability for the BSC

receivedBits=bsc(codedBits,p); % BSC channel
receivedBlocks=reshape(receivedBits,n,n*numBits/(n*k))';

syndromesBin=mod(receivedBlocks*H',2); % Calculating the syndromes

syndromesDec=bi2de(syndromesBin,'right-msb');

fprintf('Number of received words with errors detected')

errors=size(find(syndromesDec ~= 0));

errors(1)
fprintf('Number of bits in error before correction')

errorsBU=size(find(codedBits ~= receivedBits));

errorsBU(2)

syndromeTable=zeros(1,2^(n-k)-1);

for i=1:(2^(n-k)-1)
    syndromeTable(bi2de(mod(de2bi(2^(i-1),2^(n-k)-1)*H',2)))=2^(i-1);
end

correctionVec=find(syndromesDec ~= 0);
correctedBlocks=receivedBlocks;

if size(syndromesDec(correctionVec))>0
    correctedBlocks(correctionVec,:)=mod(receivedBlocks(correctionVec,:)+de2bi(syndromeTable(syndromesDec(correctionVec)),7),2);
end

correctedBits=reshape(correctedBlocks',1,n*numBits/k);

fprintf('Number of codewords in error after correction')

errorsCC=sum(bi2de(codedBlocks ~= correctedBlocks) ~= 0);

errorsCC(1)

fprintf('Number of bits in error in the codewords after correction')

errorsBC=size(find(codedBits ~= correctedBits));

errorsBC(2)
