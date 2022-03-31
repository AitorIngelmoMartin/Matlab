% EJ 5.1
 clear
 clc
 close all
 frec=2.4e9;
 permi= 1;
 lambda_cero=3e8/frec;
 lambda_ef=lambda_cero/sqrt(permi);
 Lp=lambda_ef/2;
 Wp=lambda_ef/2;
 hs=0.01*lambda_ef;
 Ls=lambda_ef;
 Ws=lambda_ef;
 alimentacion=[0 0];
 PM = patchMicrostrip('Length',Lp, 'Width',Wp,'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion)
 PM.Tilt=90;
 PM.TiltAxis=[0 1 0];
 polarizacion='V';
 barrido=2e9:0.9e8:4e9;
 [Z_ANT] = estudiar_antena_completo(PM, frec, polarizacion, barrido)

% EJ 5.1
clear
clc
close all
frec=;
lambda_ef=;
Lp=;
Wp=;
hs=;
Ls=;
Ws=;
alimentacion=[0 0];
PM = patchMicrostrip('Length',Lp, 'Width',Wp,'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion);
PM.Tilt=90;
PM.TiltAxis=[0 1 0];
polarizacion=;
barrido=;
[Z_ANT] = estudiar_antena_completo(PM, frec, polarizacion, barrido)

%% EJ 5.2

% ALIMENTACION->tercera
clear
close all
clc
frec=2.45e9;
lambda_ef=3e8/frec;
Lp=lambda_ef/2;
Wp=lambda_ef/2;
hs=0.01*lambda_ef;
Ls=lambda_ef;
Ws=lambda_ef;
alimentacion=[0 0; 0.005 0; 0.01 0; 0.015 0];
for ind =1:4
    PM2 =  patchMicrostrip('Length',Lp, 'Width',Wp,'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion(ind,:));
    PM2.Tilt=90;
    PM2.TiltAxis=[0 1 0];
    polarizacion='V';
    barrido=2.4e9;
    [Z_ANT(ind)] = estudiar_antena_completo(PM2, frec, polarizacion, barrido);
end
Z_ANT

% LP->segunda
clear
close all
clc
frec=2.45e9;
lambda_ef=3e8/frec;
Lp=[0.47*lambda_ef 0.48*lambda_ef 0.49*lambda_ef 0.5*lambda_ef];
Wp=lambda_ef/2;
hs=0.01*lambda_ef;
Ls=lambda_ef;
Ws=lambda_ef;
alimentacion=[0.01 0];
for ind =1:4
    PM2 =  patchMicrostrip('Length',Lp(ind), 'Width',Wp,'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion);
    PM2.Tilt=90;
    PM2.TiltAxis=[0 1 0];
    polarizacion='V';
    barrido=2.4e9;
    [Z_ANT(ind)] = estudiar_antena_completo(PM2, frec, polarizacion, barrido);
end
Z_ANT

% WP->segunda
clear
close all
clc
frec=2.45e9;
lambda_ef=3e8/frec;
Lp=0.48*lambda_ef;
Wp=[0.48*lambda_ef 0.5*lambda_ef 0.52*lambda_ef];
hs=0.01*lambda_ef;
Ls=lambda_ef;
Ws=lambda_ef;
alimentacion=[0.01 0];
for ind =1:3
    PM2 =  patchMicrostrip('Length',Lp, 'Width',Wp(ind),'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion);
    PM2.Tilt=90;
    PM2.TiltAxis=[0 1 0];
    polarizacion='V';
    barrido=2.4e9;
    [Z_ANT(ind)] = estudiar_antena_completo(PM2, frec, polarizacion, barrido);
end
Z_ANT

%% EJ 5.3
clear
clc
close all
frec=2.45e9;
lambda_ef=3e8/frec;
Lp=0.48*lambda_ef;
Wp=0.5*lambda_ef;
hs=0.01*lambda_ef;
Ls=lambda_ef;
Ws=lambda_ef;
alimentacion=[0.01 0];
PM = patchMicrostrip('Length',Lp, 'Width',Wp,'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion);
PM.Tilt=90;
PM.TiltAxis=[0 1 0];
polarizacion='V';
barrido=2e9:0.9e8:4e9;
[Z_ANT] = estudiar_antena_completo(PM, frec, polarizacion, barrido)


%% EJ 5.4
clear
clc
close all
frec=2.45e9;
lambda_ef=3e8/frec;
Lp=0.48*lambda_ef;
Wp=0.5*lambda_ef;
hs=0.01*lambda_ef;
Ls=lambda_ef;
Ws=lambda_ef;
alimentacion=[0.01 0];
PM = patchMicrostrip('Length',Lp, 'Width',Wp,'Height',hs, 'Substrate',dielectric('Air'),'GroundPlaneLength',Ls, 'GroundPlaneWidth',Ws,'FeedOffset',alimentacion);
PM.Tilt=90;
PM.TiltAxis=[0 1 0];
xpd_antena(PM, frec, -180:180)

%% EJ 5.5
clear
clc
close all

frec=2.45e9;
lambda_ef=3e8/frec;
PIRE=11;%dBm
%P.V.
G60=0.101005;
G130=-13.9123;
G270=-10.8846;

d60=1.2e3;%m
d130=0.7e3;%m
d270=2.5e3;%m

%60 grados
Flujo1=PIRE-10*log10(4*pi*d60^2);
Sef1=lambda_ef^2/(4*pi)*10^(G60/10);%m
Prx60=Flujo1+10*log10(Sef1) %dBm

%130 grados
Flujo2=PIRE-10*log10(4*pi*d130^2);
Sef2=lambda_ef^2/(4*pi)*10^(G130/10);%m
Prx130=Flujo2+10*log10(Sef2) %dBm

%270 grados
Flujo3=PIRE-10*log10(4*pi*d270^2);
Sef3=lambda_ef^2/(4*pi)*10^(G270/10);%m
Prx270=Flujo3+10*log10(Sef3) %dBm