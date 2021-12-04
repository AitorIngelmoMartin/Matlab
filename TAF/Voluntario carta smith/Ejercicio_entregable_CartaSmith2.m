%Datos
Zc = 30;
ZL = 34.4585 +27.5274i;
ZLnorm = ZL/Zc;
Epsilon_R =4;
Longitud = 0.015; %En metros
f0=3e9;
c0=3e8;

%APARTADO A:---------------------------------------------------------------
coef_Reflex_ZL = (ZL - Zc)./(ZL +Zc);

%APARTADO B:---------------------------------------------------------------

%Cálculo de parámetros
Lambda = c0/(sqrt(Epsilon_R)*f0);
Beta = (2*pi)/Lambda;

%Coeficiente de reflexion a la entrada de la línea
coef_Reflez_Zin  = [coef_Reflex_ZL.*exp(-2*1*i*Beta*Longitud)]

%Impedancia a la entrada de la línea
Zin_linea=Zc*(1+coef_Reflez_Zin)./(1-coef_Reflez_Zin)



