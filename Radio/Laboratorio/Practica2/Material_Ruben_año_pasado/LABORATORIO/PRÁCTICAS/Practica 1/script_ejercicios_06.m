%% EJ 6.1
clear 
close all
clc
frec=6.525e9;
BOC=design(horn,frec);
polarizacion='V';
estudiar_antena_incompleto(BOC,frec,polarizacion)

%% EJ 6.2
clear 
close all
clc
frec=6.525e9;
BOC=design(horn,frec);
BOC.Tilt=90;
BOC.TiltAxis=[0 1 0];
PBL=design(reflectorParabolic,frec);
PBL.Exciter=BOC;
PBL.Tilt=90;
PBL.TiltAxis=[0 1 0];
PBL.Radius=1.8/2;
PBL.FocalLength=PBL.Radius;
polarizacion='V';
estudiar_antena_incompleto(PBL,frec,polarizacion)

%% EJ 6.3
clear 
close all
clc
frec=6.525e9;
BOC=design(horn,frec);
BOC.Tilt=90;
BOC.TiltAxis=[0 1 0];
PBL=design(reflectorParabolic,frec);
PBL.Exciter=BOC;
PBL.Tilt=90;
PBL.TiltAxis=[0 1 0];
PBL.Radius=1.8/2;
PBL.FocalLength=PBL.Radius;
xpd_antena(PBL, frec, -180:180)

%% EJ 6.4

Ptx=30;%dBW
Lt1=1;
G_3=31.5601;
G=38.6161;
d=39000e3;%m
PIRE_margen=[0 0]
PIRE_margen=[Ptx-Lt1+G_3 Ptx-Lt1+G];%dBW
flujo=10^(PIRE_margen(2)/10)/(4*pi*d^2) %W/m2
Flujo=10*log10(flujo) %dBW/m2

e=sqrt(flujo*120*pi) %V/m
E=20*log10(e*1e6) %dBu
