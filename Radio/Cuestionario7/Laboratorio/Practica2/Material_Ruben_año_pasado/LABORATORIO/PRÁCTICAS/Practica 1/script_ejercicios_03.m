clear
close all
clc

%% EJEMPLO
frec=6675e6;
ANT_EJEMPLO = patchMicrostripEnotch;
ANT_EJEMPLO.Tilt=[90 90]; 
ANT_EJEMPLO.TiltAxis=[0 1 0;1 0 0];
polarizacion='H';
barrido=[5675e6:5e6:7675e6];
[Z_ANT_EJEMPLO] = estudiar_antena_completo(ANT_EJEMPLO, frec,polarizacion,barrido);
xpd_antena(ANT_EJEMPLO, frec, -180:180)

%% EJ 3.1
frec=98e6;
heigthDP=(3e8/frec)/2;

widthDP=0.03; 
DP=dipole('Length',heigthDP,'Width',widthDP,'Tilt',0,'TiltAxis',[1 0 0]);
polarizacion='V';
barrido=85e6:0.5e6:200e6;
[Z_ANT] = estudiar_antena_completo(DP, frec,polarizacion,barrido)

%% EJ 3.2
clear
close all
clc
frec=(108+88)*1e6/2;
DP_OPT=design(dipole,frec);
polarizacion='V';
barrido=85e6:0.5e6:200e6;
[Z_ANT] = estudiar_antena_completo(DP_OPT, frec,polarizacion,barrido)

% %% EJ 3.3
% clear
% close all
% clc
% frec=;
% DP_OPT=design(dipole,frec);
% DP_OPT.Tilt=90;
% polarizacion=;
% barrido=;
% [Z_ANT] = estudiar_antena_completo(DP_OPT, frec,polarizacion,barrido)
% 
%% EJ 3.4
clear
close all
clc
frec=98e6;
DP_OPT=design(dipole,frec);
xpd_antena(DP_OPT, frec, -180:180)

%% EJ 3.5
G=-76.2989
flujo=-80
lamda=(3e8/frec)
Sef=(lamda^2*10^(G/10))/(4*pi);
Potencia=10^(flujo/10)*Sef;

%% EJ 3.6 
clear
close all
clc
frec=98e6;
DP_DOBLADO=design(dipoleFolded,frec);
DP_DOBLADO.Tilt=90;
DP_DOBLADO.TiltAxis=[0 1 0];
polarizacion='V';
barrido=85e6:0.5e6:200e6;
[Z_ANT] = estudiar_antena_completo(DP_DOBLADO, frec,polarizacion,barrido)

