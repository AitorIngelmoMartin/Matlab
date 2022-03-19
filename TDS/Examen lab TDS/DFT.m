clear;clc;close all;

X = [1 2 1];
H = X;

fft(X)
y = cconv(X,H);

fft(y)
cconv(X,X)

ydes=[0 0 1 4 6 4 1];
y = [1 4 6 4 1 0 0];

X0 = y + ydes

%%%%%%%%%%%%%%%%%%%%%%%%%%%EJERCICIO 4 DFT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 =[1 0 1];


xo = desplazamientoPeriodico(x0,0,6);
x1 = desplazamientoPeriodico(x0,1,6);
x2 = desplazamientoPeriodico(x0,2,6);
x3 = desplazamientoPeriodico(x0,3,6);
x4 = desplazamientoPeriodico(x0,4,6);

x = xo+x1+x2+x3+x4







h = [8 7 14 15 3 9 8 12 13 14];
j = [7 14 15 3 9 8 12 13 14 0];

k = h.*j

k = sum(k)