% Comunicaciones digitales, Universidad de Alcalá, curso 2018-19
% Elaborado por Francisco J. Escribano

clear all; close all; clc;

% Initialization

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numSymbols=20;
Bits = round(rand(2,numSymbols));
tmp = Bits*2 - 1;
inputSymbols = (tmp(1,:) + i*tmp(2,:))/sqrt(2);

tmp = randn(2, numSymbols);       
complexNoise = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
noisePower = 2.0;

RxSymbols = inputSymbols + sqrt(noisePower)*complexNoise;

% Hard demodulation and decision

tmp = RxSymbols;
estSymbols = sign(real(tmp))+ i*sign(imag(tmp));
estSymbols = estSymbols/sqrt(2);

estBits = zeros(2,numSymbols);
estBits(1,:) = real(estSymbols) > 0;
estBits(2,:) = imag(estSymbols) > 0;

figure(1)
subplot(3,1,1); plot(estBits(1,:),'bo'); hold on; plot(abs(Bits(1,:)-estBits(1,:)),'m*'); hold on; grid on;
figure(2)
subplot(3,1,1); plot(estBits(2,:),'ko'); hold on; plot(abs(Bits(2,:)-estBits(2,:)),'c*'); hold on; grid on;

% Soft demodulation

s11=(1+i*1)/sqrt(2);
s10=(1+i*(-1))/sqrt(2);
s00=((-1)+i*(-1))/sqrt(2);
s01=((-1)+i*1)/sqrt(2);

LLR = zeros(2,numSymbols);

LLR(1,:)=log(exp(-abs(RxSymbols-s11).^2/(2.0*noisePower))+exp(-abs(RxSymbols-s10).^2/(2.0*noisePower)))-log(exp(-abs(RxSymbols-s00).^2/(2.0*noisePower))+exp(-abs(RxSymbols-s01).^2/(2.0*noisePower)));
LLR(2,:)=log(exp(-abs(RxSymbols-s11).^2/(2.0*noisePower))+exp(-abs(RxSymbols-s01).^2/(2.0*noisePower)))-log(exp(-abs(RxSymbols-s00).^2/(2.0*noisePower))+exp(-abs(RxSymbols-s10).^2/(2.0*noisePower)));

figure(1);
subplot(3,1,2); plot(LLR(1,:)>=0,'ro'); hold on; plot(abs(Bits(1,:)-(LLR(1,:)>=0)),'m*'); hold on; grid on;
subplot(3,1,3); semilogy(abs(LLR(1,:)),'r'); hold on; grid on;
figure(2);
subplot(3,1,2); plot(LLR(2,:)>=0,'go'); hold on; plot(abs(Bits(2,:)-(LLR(2,:)>=0)),'c*'); hold on; grid on;
subplot(3,1,3); semilogy(abs(LLR(2,:)),'g'); hold on; grid on;