Tx=3;%dBW
G=24;%dB
U=-96;%dBm
alphaC=10*0.076;%m*dB/m=dB
R_001=28.64% mm/h
f=18%GHz
lambda=3e8/f;
d=35000%m
alpha=1.0025;
lambdaR=0.0606;%dB/km
k=0.771;
MTBF=10e6;%horas
MTTR=40%horas
URtransc=MTTR/MTBF;
Lbf=20*log10(4*pi*d/(lambda));
PIRE=Tx-alphaC+G;%dBW
Prx=PIRE