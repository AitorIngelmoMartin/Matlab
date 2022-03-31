% TEMA 3: TEST 2
%--------------------------------------------------------------------------


% PROBLEMA: Radioenlace fijo terrenal


close all
clear

Ptx = 25; %dBW
d = 23e3;
f = 38e9;
G = 27; %dBi
% POLARIZACIÓN VERTICAL
Lt = 1.5;
U = -98; %dBm

q = 0.01; % probabilidad de desvanecimiento

XPDant = 30; %dB
aten_gas = 0.125; %dB/km
R_001 = 24.42; %mm/h
k = 0.3884;
alpha = 0.8552;

% PIDE: CAMPO RECIBIDO 

% PASO 2
gammaR = k*R_001^(alpha)%dB/km 

% PASO 3 ENLACES TERRENALES
r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*f^(0.123)-(10.579*(1-exp(-0.024*d))));
deff = d*r;

% PASO 4
F_001 = gammaR*deff;

% PASO 5
if(f<10e9)
    Co = 0.12;
else
    Co = 0.12+0.4*log10((f/10)^0.8);   
end

C1 = (0.07^(Co))*(0.12^(1-Co));
C2 = (0.855*Co)+0.546*(1-Co);
C3 = (0.139*Co)+0.043*(1-Co);

Fq=F_001*C1*q^(-(C2+C3*log10(q)));

U = 15+30*log10(f);
if f<20
    V = 12.8*f^0.19;
else
    V = 22.6;
end

XPDll = U-V*log10(Fq);

PIRE = Ptx-Lt+G; %dBW
Flujo = PIRE-10*log10(4*pi*d^2) %dBW/m2
e = sqrt(10^(Flujo/10)*120*pi);
Erx_deseado =20*log10(e*1e6); %dBu

Erx_parasita = Erx_deseado - XPDll;

% PIDE el XPI
% Prx_deseado = 
% Prx_parasita = 
% 
% XPI = Prx_deseado-Prx_parasita;


% %--------------------------------------------------------------------------
% 
% 
% % PROBLEMA: Enlace radioeléctrico
% close all
% clear
% 
% d = 35e3;
% PIRE = 2; %W
% long = 10; %m
% aten_cable = 0.076; %dB/m
% G = 24; %dBi
% % polarizacion HORIZONTAL
% f = 18e9;
% % requiere al menos -96 dBm para extraer la info enviada
% U = -96;
% MTBF = 10^6; %horas
% MTTR = 40; %horas
% 
% gamma0 = 0.0606; %dB/km
% R_001 = 28.64; %mm/h
% k = 0.0771;
% alpha = 1.0025; 
% 
% Lt = 0; %terminal
% 
% % PIDE LA INDISPONIBILIDAD
% c = 3e8;
% lambda = c/f;
% L_cable = long*aten_cable;
% Lbf = 20*log10((4*pi()*d)/lambda);
% 
% URE1 = MTTR/MTBF*100; %URE1=URE2
% 
% PRX_CN = PIRE-Lbf-L_cable+G-Lt;
% % PRX_CN = U + MD
% MD = PRX_CN-U;
% Fq = MD;
% 
% % PASO 2
% gammaR = k*R_001^(alpha)%dB/km 
% 
% % PASO 3 ENLACES TERRENALES
% r = 1/(0.477*d^(0.633)*R_001^(0.073*alpha)*f^(0.123)-(10.579*(1-exp(-0.024*d))));
% deff = d*r;
% 
% % PASO 4
% F_001 = gammaR*deff;
% 
% % PASO 5
% if(f<10e9)
%     Co = 0.12;
% else
%     Co = 0.12+0.4*log10((f/10)^0.8);   
% end
% 
% C1 = (0.07^(Co))*(0.12^(1-Co));
% C2 = (0.855*Co)+0.546*(1-Co);
% C3 = (0.139*Co)+0.043*(1-Co);
% 
% % Fq=F_001*C1*q^(-(C2+C3*log10(q)));
% 
% %PIRE = Ptx-Lt+G; dBW
% Ptx = 10^((PIRE+Lt-G)/10); %dBW
% 
% Fq = Ptx+30-Lt+G-U-gamma0*d-20*log10(4*pi*d*1e3/lambda)+G-Lt; %Lbf(de en metros). Lo(d en km)
% q_exponente = Fq/(F_001*C1);
% 
% xa = (C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3);
% xb = (C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3);
% q1 = 10^xa;
% q2 = 10^xb;
% 
% if q1>q2
%     q = q1;
% else
%     q = q2;
% end
% 
% URE = URE1+URE1;
% UR = q + URE;
% 
% 
% %--------------------------------------------------------------------------
% 
% 
% % PROBLEMA: Radioenlace entre dos estaciones
% close all
% clear
% 
% d = 30e3;
% f = 13e9;
% % POLARIZACION HORIZONTAL
% q = 0.01;
% R_001 = 32;
% k = 0.0304;
% alpha = 1.1586;
% 
% % PIDE: PROFUNDIDAD DEL DESVANECIMIENTO POR LLUVIA
% % PASO 2
% gammaR = k*R_001^(alpha)%dB/km 
% 
% % PASO 3 ENLACES TERRENALES
% r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*f^(0.123)-(10.579*(1-exp(-0.024*d))));
% deff = d*r;
% 
% % PASO 4
% F_001 = gammaR*deff;
% 
% % PASO 5
% if(f<10e9)
%     Co = 0.12;
% else
%     Co = 0.12+0.4*log10((f/10)^0.8);   
% end
% 
% C1 = (0.07^(Co))*(0.12^(1-Co));
% C2 = (0.855*Co)+0.546*(1-Co);
% C3 = (0.139*Co)+0.043*(1-Co);
% 
% Fq=F_001*C1*q^(-(C2+C3*log10(q)));
% 
% % PIDE: MD = 10dB LA PROB DE RECIBIR UNA PRX<U DEBIDO A DESV POR LLUVIA
% MD = 10;
% UR_equipos = MD;
% UR_lluvia = q;
% UR = UR_lluvia+UR_equipos;
% P = UR;
% 
% 
% %--------------------------------------------------------------------------
% 
% 
% % PROBLEMA: Enlace radio entre 2 puntos
% close all
% clear
% 
% d = 10e3;
% f = 11.2e9;
% % POLARIZACION H Y V
% Ptx = 20; %dBm
% Lt = 2;
% 
% R_001 = 41;
% kh = 0.0189;
% alpha_h = 1.2069;
% kv = 0.0187;
% alpha_v = 1.1528;
% % NO despreciar atenuacion gases atmósfericos
% 
% % PIDE: PRX_copolares y contrapolares superados el 0.05%
% 
% 
% 
% %--------------------------------------------------------------------------
% 
% 
% % PROBLEMA: enlace radioeléctrico
% close all
% clear
% 
% pire = 2; %w
% long = 10; %m
% aten_cable = 0.076; %dB/m
% G = 24; %dBi
% d = 35e3;
% f = 18e9;
% U = -96; %dBm
% MTBF = 1500000; %horas
% 
% cotaE1 = 220;
% cotaE2 = 307;
% 
% hE1 = 15;
% hE2 = 5;
% 
% cotaO1 = 238;
% cotaO2 = 240;
% cotaO3 = 277;
% 
% dO1 = 8e3;
% dO2 = 14e3;
% dO3 = 26e3;
% 
% % E1 --(d1)-- O1 --(d2)-- O2 --(d3)-- O3 --(d4)-- E2
% d1 = dO1;
% d2 = dO2-d1;
% d3 = dO3-dO2;
% d4 = d-dO3;
% 
% K = 4/3;
% R0 = 6730e3;
% k = 0.0708;
% alpha = 1.0818;
% R_001 = 32;
% % desprecian absorción gases atm
% 
% % 1-PIDE: PRX
% c = 3e8;
% lambda = c/f;
% Lbf =20*log10(4*pi*d/lambda);
% Lt = long*aten_cable;
% 
% PIRE = 10*log10(pire);
% 
% PRX = PIRE-Lbf+G-Lt;
% 
% % 2-PIDE: indisponibilidad debida a desvanecimientos por lluvia
% % PASO 2
% gammaR = k*R_001^(alpha)%dB/km 
% 
% % PASO 3 ENLACES TERRENALES
% r=1/(0.477*d^(0.633)*R_001^(0.073*alpha)*f^(0.123)-(10.579*(1-exp(-0.024*d))));
% deff = d*r;
% 
% % PASO 4
% F_001 = gammaR*deff;
% 
% % PASO 5
% if(f<10e9)
%     Co = 0.12;
% else
%     Co = 0.12+0.4*log10((f/10)^0.8);   
% end
% 
% C1 = (0.07^(Co))*(0.12^(1-Co));
% C2 = (0.855*Co)+0.546*(1-Co);
% C3 = (0.139*Co)+0.043*(1-Co);
% 
% % Fq=F_001*C1*q^(-(C2+C3*log10(q)));
% Fq=Ptx+30-Lt1+G-U-gammaO*d-20*log10(4*pi*d*1e3/lambda)+G-Lt2;%Lbf(de en metros). Lo(d en km)
% q_exponente=Fq/(F_001*C1)
% 
% xa=(C2+sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
% xb=(C2-sqrt(C2^2-4*C3*log10(q_exponente)))/(-2*C3)
% q1=10^xa
% q2=10^xb
% 
% % 3-PIDE: MTTR? para que la URtotal=0.085%
% 
% URtotal = 0.085; %(%)
% 
% 
% %--------------------------------------------------------------------------
% 
% 
% % PROBLEMA: radioenlace entre dos estaciones
% 
% f = 55e9;


