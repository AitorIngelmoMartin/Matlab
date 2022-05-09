% %% EJEMPLO
% clear
% close all
% clc
% frec=6675e6;
% ANT_EJEMPLO = patchMicrostripEnotch; 
% ANT_EJEMPLO.Tilt=[90 90]; 
% ANT_EJEMPLO.TiltAxis=[0 1 0;1 0 0];
% polarizacion='H';
% barrido=[5675e6:5e6:7675e6];
% [Z_ANT_EJEMPLO] = estudiar_antena_completo(ANT_EJEMPLO, frec,polarizacion,barrido);
% xpd_antena(ANT_EJEMPLO, frec, -180:180)
% 
% %% EJ 3.1
% clear
% close all
% clc
% frec=mean([1.625,2.110])*1e9;
% heigthDP=(3e8/frec)/2;
% widthDP=0.001;
% DP=dipole('Length',heigthDP,'Width',widthDP,'Tilt',0,'TiltAxis',[1 0 0]);
% polarizacion='V';
% barrido=frec-0.3e9:10e6:frec+0.3e9;
% [Z_DP] = estudiar_antena_completo(DP, frec,polarizacion,barrido);
% 
% %% EJ 3.2
% close all
% clc
% frec=mean([1.625,2.110])*1e9;
% heigthDP=(3e8/frec)/2;
% widthDP=0.001; 
% DP_OPT=dipole('Length',heigthDP,'Width',widthDP,'Tilt',0,'TiltAxis',[1 0 0]);
% [heigthDP_opt,~] = fminsearch(@antenna_optimization,heigthDP,optimset('Display','off'),'dipole',DP_OPT,frec);
% DP_OPT2=dipole('Length',heigthDP_opt,'Width',widthDP,'Tilt',0,'TiltAxis',[1 0 0]);
% [Z_DP_OPT] = estudiar_antena_completo(DP_OPT2, frec,polarizacion,barrido);
% 
% %% EJ 4.3
% clc
% close all
% xpd_antena(DP_OPT2, frec, -180:180)
%  
% %% EJ 4.1
% clear
% clc
% close all
% frec=mean([406 512])*1e6;
% DP_YAGI=design(dipoleFolded,frec);
% show(DP_YAGI)
% L_E=DP_YAGI.Length;
% L_D=0.95*L_E;
% D_D=0.15*3e8/frec;
% L_R=1.05*L_E;
% D_R=0.2*3e8/frec;
% Y5= yagiUda('Exciter',DP_YAGI,'NumDirectors',5,'DirectorLength',L_D,'DirectorSpacing',D_D,'ReflectorLength',L_R,'ReflectorSpacing',D_R);
% Y5.Tilt=[90 90];
% Y5.TiltAxis=[0 1 0;1 0 0];
% polarizacion='H';
% barrido=frec-60e6:10e6:frec+60e6;
% [Z_Y5] = estudiar_antena_completo(Y5, frec, polarizacion, barrido)
% 
% %% EJ 4.2
% clc
% close all
% L_D=0.95*L_E;
% D_D=0.15*3e8/frec;
% L_R=1.05*L_E;
% D_R=0.2*3e8/frec;
% Y5_OPT= yagiUda('Exciter',DP_YAGI,'NumDirectors',5,'DirectorLength',L_D,'DirectorSpacing',D_D,'ReflectorLength',L_R,'ReflectorSpacing',D_R);
% Y5_OPT.Tilt=[90 90];
% Y5_OPT.TiltAxis=[0 1 0;1 0 0];
% [param_opt,~] = fminsearch(@antenna_optimization,[L_D D_D L_R D_R],optimset('Display','off'),'yagiUda',Y5_OPT,frec);
% Y5_OPT2=yagiUda('Exciter',DP_YAGI,'NumDirectors',5,'DirectorLength',param_opt(1),'DirectorSpacing',param_opt(2),'ReflectorLength',param_opt(3),'ReflectorSpacing',param_opt(4));
% Y5_OPT2.Tilt=[90 90];
% Y5_OPT2.TiltAxis=[0 1 0;1 0 0];
% [Z_Y5_OPT2] = estudiar_antena_completo(Y5_OPT2, frec, polarizacion, barrido)
% 
% %% EJ 4.3
% clc
% close all
% xpd_antena(Y5_OPT, frec, -180:180)
% 
% %% EJ 5.1
% clear
% close all
% clc
% frec=mean([1575, 1602])*1e6;
% estrcutura_dielectrico=dielectric('FR4'); %aire
% lef=3e8/(sqrt(estrcutura_dielectrico.EpsilonR)*frec);
% Lpatch=0.5*lef;
% Wpatch=0.5*lef;
% grosor_patch=0.01*lef;
% Lmasa=lef;
% Wmasa=lef;
% alimentacion=[0 0]*1e-3;
% P = patchMicrostrip('Length',Lpatch, 'Width',Wpatch,'Height',grosor_patch, 'Substrate',estrcutura_dielectrico,'GroundPlaneLength',Lmasa, 'GroundPlaneWidth',Wmasa,'FeedOffset',alimentacion);
% P.Tilt=90;
% P.TiltAxis=[0 1 0];
% polarizacion='V';
% barrido=(frec-20e6:2e6:frec+20e6);
% [Z_P] = estudiar_antena_completo(P, frec, polarizacion, barrido)
% 
% %% EJ 5.2
% close all
% clc
% Lpatch=[0.3*lef 0.5*lef 0.7*lef];
% Wpatch=[0.3*lef 0.5*lef 0.7*lef];
% alimentacion=[-0.01 0 0.01; -0.01 0 0.01];
% P_OPT = patchMicrostrip('Length',0.5*lef, 'Width',0.5*lef,'Height',grosor_patch, 'Substrate',estrcutura_dielectrico,'GroundPlaneLength',Lmasa, 'GroundPlaneWidth',Wmasa,'FeedOffset',[0 0]);
% P_OPT.Tilt=90;
% P_OPT.TiltAxis=[0 1 0];
% [param_opt,Yfinal] = fmincon(@antenna_optimization,[Lpatch(2) Wpatch(2) alimentacion(1,2) alimentacion(2,2)],[],[],[],[],[Lpatch(1) Wpatch(1) alimentacion(1,1) alimentacion(2,1)],[Lpatch(3) Wpatch(3) alimentacion(1,3) alimentacion(2,3)],[],optimset('Display','off'),'patchMicrostrip',P_OPT,frec);
% Lpatch=param_opt(1);
% Wpatch=param_opt(2);
% alimentacion=param_opt(3:4);
% P_OPT2 = patchMicrostrip('Length',Lpatch, 'Width',Wpatch,'Height',grosor_patch, 'Substrate',estrcutura_dielectrico,'GroundPlaneLength',Lmasa, 'GroundPlaneWidth',Wmasa,'FeedOffset',alimentacion);
% P_OPT2.Tilt=90;
% P_OPT2.TiltAxis=[0 1 0];
% [Z_P_OPT] = estudiar_antena_completo(P_OPT2, frec, polarizacion, barrido)
% 
% 
% %% EJ 4.3
% clc
% close all
% xpd_antena(P_OPT2, frec, -180:180)

%% EJ 6.1
clear 
close all
clc
frec=mean([10.7,12.75])*1e9;
BOC=design(horn,frec);
BOC.Tilt=90;
BOC.TiltAxis=[0 1 0];

% PBL=design(reflectorParabolic,frec);
% PBL.Exciter=BOC;
% PBL.Tilt=90;
% PBL.TiltAxis=[0 1 0];
% PBL.Radius=0.6/2;
% PBL.FocalLength=(2*PBL.Radius);
% estudiar_antena_incompleto(PBL,frec,'V')

% %% EJ 6.2
% % 
PBL2=design(reflectorParabolic,frec);
PBL2.Exciter=BOC;
PBL2.Tilt=90;
PBL2.TiltAxis=[0 1 0];
PBL2.Radius=0.9/2;
PBL2.FocalLength=(2*PBL2.Radius);
estudiar_antena_incompleto(PBL2,frec,'V')

% %% EJ 6.3
% close all
% xpd_antena(PBL, frec, -180:180);

