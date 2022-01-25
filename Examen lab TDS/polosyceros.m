close all,clc;clear;

c5 = 0.5*exp((pi/4)*1i)

c1 = sqrt(2)*exp((pi/4)*i);


x=[1 2 3 3 3 3 2 1];
h=[1 2 3 2 1];

y=cconv(x,h)


x=[1 2 1]

y=cconv(x,x,4)


g = fft(y)