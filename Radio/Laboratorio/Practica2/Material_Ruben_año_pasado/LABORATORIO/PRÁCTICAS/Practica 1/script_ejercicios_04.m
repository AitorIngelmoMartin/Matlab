%% EJ 4.1
clear
clc
close all
frec=500e6;
lambda=3e8/frec;
DP_DOBLADO=design(dipoleFolded,frec);
L_E=DP_DOBLADO.Length;
L_D=0.95*L_E;
D_D=0.11*lambda;
L_R=1.05*L_E;
D_R=0.15*lambda;

Y6= yagiUda('Exciter',DP_DOBLADO,'NumDirectors',6,'DirectorLength',L_D,'DirectorSpacing',D_D,'ReflectorLength',L_R,'ReflectorSpacing',D_R);
Y6.Tilt=[90 90];
Y6.TiltAxis=[0 1 0;1 0 0];
polarizacion='H';
barrido=[480e6:200e3:540e6];
[Z_ANT] = estudiar_antena_completo(Y6, frec, polarizacion, barrido)

%% EJ 4.2
clear
clc
close all
frec=500e6;
Y6_OPT=design(yagiUda,frec);
Y6_OPT.Tilt=[90 90];
Y6_OPT.TiltAxis=[0 1 0;1 0 0];
polarizacion='H';
barrido=[480e6:200e3:540e6];
[Z_ANT] = estudiar_antena_completo(Y6_OPT, frec, polarizacion, barrido)

%% EJ 4.3
clear
clc
close all
frec=500e6;
Y6_OPT=design(yagiUda,frec);
Y6_OPT.Tilt=[90 90];
Y6_OPT.TiltAxis=[0 1 0;1 0 0];
xpd_antena(Y6_OPT, frec, -180:180)


%% EJ 4.4
clear 
close all
%Polarización vertical (acorde con antena, inclinada 5 grados)
frec=500e6;
G=10.0619
E=80 %dBu
e=10^(E/20)/1e6;%V/m
flujo=e^2/(120*pi);%W/m2
lambda=(3e8/frec);
Sef=(lambda^2*10^(G/10))/(4*pi);%m2
Potencia=10^(flujo/10)*Sef%W

%Polarización horizontal (contrapolar)
XPD5=10.0619+58.3804;
E_cont=80; %dBu
e_cont=10^(E_cont/20)/1e6;%V/m
flujo_cont=e_cont^2/(120*pi);%W/m2
lambda=(3e8/frec);
Sef_cont=(lambda^2*10^((G-XPD5)/10))/(4*pi);%(G-XPD5) al final es aplicar la ganarcia de la gráfica roja
Potencia_cont=10^(flujo_cont/10)*Sef_cont%W


