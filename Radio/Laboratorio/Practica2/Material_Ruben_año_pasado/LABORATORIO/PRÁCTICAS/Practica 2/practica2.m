%% Práctica 2
clear 
close all

d=15.6e3;%m
f=2500e6;
Ptx=23;%dBm
Mod=16;%16-QAM
U=-70.5;%dBm. Umbral para BER_máx=10^-6
Lcrf=1;
Mf=3;%margen de funcionamiento

cota1=767;%m
cota2=807;%m
h1=15;
h2=15;
cotao1=784;%m
cotao2=787;%m
cotao3=801;%m
cotao4=802;%m
dE1o=[2.600 4.031 9.007 12.369]*1e3;%distancia de los obstáculos a E1
K=4/3;
Ro=6370e3;

lambda=3e8/f;

%% 1.1 Calcular: despejamiento(%) y V de los obstáculos presentes

%calculo separaciones:
%-h1-____d1____-O1-___d2___-O2-___d3___-O3-__d4__-O4-__d5__-h2-
d1=dE1o(1);
d2=dE1o(2)-dE1o(1);
d3=dE1o(3)-dE1o(2);
d4=dE1o(4)-dE1o(3);
d5=d-dE1o(4);

%cálculo del despejamiento (c) y el parámetro de difracción (V):
c1=(d1*(d2+d3+d4+d5)/(2*K*Ro)+cotao1)-((h2+cota2-h1-cota1)*d1/d+h1+cota1)
R1_1=sqrt(lambda*(d1*(d2+d3+d4+d5)/d))
V1=sqrt(2)*(c1/R1_1)



c2=((d3+d4+d5)*(d2+d1)/(2*K*Ro)+cotao2)-((h2+cota2-h1-cota1)*(d1+d2)/d+h1+cota1)
R1_2=sqrt(lambda*((d3+d4+d5)*(d2+d1)/d))
V2=sqrt(2)*(c2/R1_2)

c3=((d1+d2+d3)*(d4+d5)/(2*K*Ro)+cotao3)-((h2+cota2-h1-cota1)*(d1+d2+d3)/d+h1+cota1)
R1_3=sqrt(lambda*((d4+d5)*(d1+d2+d3)/d))
V3=sqrt(2)*(c3/R1_3)

c4=((d1+d2+d3+d4)*d5/(2*K*Ro)+cotao4)-((h2+cota2-h1-cota1)*(d1+d2+d3+d4)/d+h1+cota1)
R1_4=sqrt(lambda*(d5*(d1+d2+d3+d4)/d))
V4=sqrt(2)*(c4/R1_4)

%% 1.2 Porcentajes de despejamiento
desp_porcent1=V1*100/sqrt(2)
desp_porcent2=V2*100/sqrt(2)
desp_porcent3=V3*100/sqrt(2)
desp_porcent4=V4*100/sqrt(2)

%% 1.3 Calcular las pérdidas por difracción.

%4 obstáculos->Metodo general

%-h1-____d1____-O1-___d2___-O2-___d3___-O3-__d4__-O4-__d5__-h2-

%trazamos dos nuevos rayos: h1 a O3(el dominante) y O3 a h2 y calculamos
%los parámetros de difracción modificados

%h1 a O3
%-h1-____d1____-O1-___d2___-O2-___d3___-O3-

cp1=(d1*(d2+d3)/(2*K*Ro)+cotao1)-((0+cotao3-h1-cota1)*d1/dE1o(3)+h1+cota1)
Rp1_1=sqrt(lambda*(d1*(d2+d3)/dE1o(3)))
Vp1=sqrt(2)*(cp1/Rp1_1)

cp2=((d3)*(d2+d1)/(2*K*Ro)+cotao2)-((0+cotao3-h1-cota1)*(d1+d2)/dE1o(3)+h1+cota1)
Rp1_2=sqrt(lambda*(d3*(d2+d1)/dE1o(3)))
Vp2=sqrt(2)*(cp2/Rp1_2)

%O3 a h2

%-O3-__d4__-O4-__d5__-h2-

cp4=((d4*d5)/(2*K*Ro)+cotao4)-((h2+cota2-0-cotao3)*d4/(d4+d5)+0+cotao3)
Rp1_4=sqrt(lambda*(d5*d4/(d4+d5)))
Vp4=sqrt(2)*(cp4/Rp1_4) %Vp4=-0.9<-0.78 --> en O4 hay despejamiento suficiente

%Seleccionamos V3 los Vp dominantes de cada lado de O3(solo Vp2 porque Vp4 <-078)
LadV3=6.9+20*log10(sqrt((V3-0.1)^2+1)+V3-0.1);
LadVp2=6.9+20*log10(sqrt((Vp2-0.1)^2+1)+Vp2-0.1);

T=1-exp(-LadV3/6);
C=10+0.04*(d/1e3);%d en km
Lad=LadV3+T*(LadVp2+C)


%% 2.1 Variación de Lad con K


Kvalores=[0.5 2/3 1 4/3];
Ladk=zeros(1,4);

for i=1:1:4

K=Kvalores(i);
%calculamos los valores que cambian del ej 1 y que se usan para Lad
c3=((d1+d2+d3)*(d4+d5)/(2*K*Ro)+cotao3)-((h2+cota2-h1-cota1)*(d1+d2+d3)/d+h1+cota1)
R1_3=sqrt(lambda*((d4+d5)*(d1+d2+d3)/d))
V3=sqrt(2)*(c3/R1_3)

%--------------------Para comprobar si siguen siendo obstáculos--------
c1=(d1*(d2+d3+d4+d5)/(2*K*Ro)+cotao1)-((h2+cota2-h1-cota1)*d1/d+h1+cota1)
R1_1=sqrt(lambda*(d1*(d2+d3+d4+d5)/d))
V1=sqrt(2)*(c1/R1_1)


c2=((d3+d4+d5)*(d2+d1)/(2*K*Ro)+cotao2)-((h2+cota2-h1-cota1)*(d1+d2)/d+h1+cota1)
R1_2=sqrt(lambda*((d3+d4+d5)*(d2+d1)/d))
V2=sqrt(2)*(c2/R1_2)


c4=((d1+d2+d3+d4)*d5/(2*K*Ro)+cotao4)-((h2+cota2-h1-cota1)*(d1+d2+d3+d4)/d+h1+cota1)
R1_4=sqrt(lambda*(d5*(d1+d2+d3+d4)/d))
V4=sqrt(2)*(c4/R1_4)

%-------------------Todos siguen siendo obstáculos con V>-0.78-------------
%-------------------O3 dominante siempre-------------------



cp2=((d3)*(d2+d1)/(2*K*Ro)+cotao2)-((0+cotao3-h1-cota1)*(d1+d2)/dE1o(3)+h1+cota1)
Rp1_2=sqrt(lambda*(d3*(d2+d1)/dE1o(3)))
Vp2=sqrt(2)*(cp2/Rp1_2)

cp4=((d4*d5)/(2*K*Ro)+cotao4)-((h2+cota2-0-cotao3)*d4/(d4+d5)+0+cotao3)
Rp1_4=sqrt(lambda*(d5*d4/(d4+d5)))
Vp4=sqrt(2)*(cp4/Rp1_4);%En todos los valores de K cumple desp. suficiente

LadV3=6.9+20*log10(sqrt((V3-0.1)^2+1)+V3-0.1);
LadVp2=6.9+20*log10(sqrt((Vp2-0.1)^2+1)+Vp2-0.1);
T=1-exp(-LadV3/6);
C=10+0.04*(d/1e3);%d en km
Lad=LadV3+T*(LadVp2+C)

Ladk(i)=Lad;

    
end
figure()
plot(Kvalores,Ladk,'LineWidth',1.5)
xlabel('K')
ylabel('L_{ad}(dB)')
title('Variación de las pérdidas por difracción con K')
grid minor

%% 2.2 Conclusiones

%% 3.1 

%-h1-____d1____-O1-___d2___-O2-___d3___-O3-__d4__-O4-__d5__-h2-

 fvalores=[500 1500 2500 3500 4500 7475 12650 17825 23000]*1e6;
 Ladf=zeros(1,9);
 difracion_freqs=zeros(9,4);%adicional para comprobar V dominante para cada freq.
 for i=1:1:9
    
     
     
    f=fvalores(i);
    
    %calculos adicionales de comprobación de obstáculo dominante siempre el
    %mismo (O3):
    [c1f,R1_1f,V1f] = PF(cota1,cota2,cotao1,h1,h2,d1,d2+d3+d4+d5,K,f);
    [c2f,R1_2f,V2f] = PF(cota1,cota2,cotao2,h1,h2,d1+d2,d3+d4+d5,K,f);
    [c3f,R1_3f,V3f] = PF(cota1,cota2,cotao3,h1,h2,d1+d2+d3,d4+d5,K,f);
    [c4f,R1_4f,V4f] = PF(cota1,cota2,cotao4,h1,h2,d1+d2+d3+d4,d5,K,f);
    difracion_freqs(i,:)=[V1f V2f V3f V4f];
    %----A partir de i=4 O4 deja de ser obstáculo----------
    lambda=3e8/f;
    
    %lado izquierdo de O3
    [cp1,Rp1_1f,Vp1] = PF(cota1,cotao3,cotao1,h1,0,d1,d2+d3,K,f);
    cp2=((d3)*(d2+d1)/(2*K*Ro)+cotao2)-((0+cotao3-h1-cota1)*(d1+d2)/dE1o(3)+h1+cota1)
    Rp1_2=sqrt(lambda*(d3*(d2+d1)/dE1o(3)))
    Vp2=sqrt(2)*(cp2/Rp1_2)
    
    %lado izquierdo de O3
    cp4=((d4*d5)/(2*K*Ro)+cotao4)-((h2+cota2-0-cotao3)*d4/(d4+d5)+0+cotao3)
    Rp1_4=sqrt(lambda*(d5*d4/(d4+d5)))
    Vp4=sqrt(2)*(cp4/Rp1_4)
    
    if (Vp1>-0.78 || Vp2>-0.78)
       if(Vp1>Vp2) 
          LadVp1=6.9+20*log10(sqrt((Vp1-0.1)^2+1)+Vp1-0.1); 
          LadVp2=0;
       else
          LadVp2=6.9+20*log10(sqrt((Vp2-0.1)^2+1)+Vp2-0.1);
          LadVp1=0;
       end
        
    else
            LadVp1=0;
            LadVp2=0;  
    end
    

    if (Vp4>-0.78)  
         LadVp4=6.9+20*log10(sqrt((Vp4-0.1)^2+1)+Vp4-0.1);% Vp4 obstaculiza en i=1,2
    else
        LadVp4=0;
    end
    
    LadV3f=6.9+20*log10(sqrt((V3f-0.1)^2+1)+V3f-0.1);   
    T=1-exp(-LadV3f/6);
    C=10+0.04*(d/1e3);%d en km
    Lad=LadV3f+T*(LadVp1+LadVp2+LadVp4+C)

    Ladf(i)=Lad;

    
end
figure()
plot(fvalores/1e9,Ladf,'LineWidth',1.5,'color','k');
grid minor
xlabel('F(GHz)')
ylabel('L_{ad}(dB)')
title('Variación de las pérdidas por difracción con la frecuencia')

%% 3.2
cotao3_mod=811;
fvalores=[500 1500 2500 3500 4500 7475 12650 17825 23000]*1e6;
 Ladf1=zeros(1,9);
 for i=1:1:9
     
    f=fvalores(i);
    lambda=3e8/f;
        
    %calculos adicionales de comprobación de obstáculo dominante siempre el
    %mismo (O3):
    [c1f,R1_1f,V1f] = PF(cota1,cota2,cotao1,h1,h2,d1,d2+d3+d4+d5,K,f);
    [c2f,R1_2f,V2f] = PF(cota1,cota2,cotao2,h1,h2,d1+d2,d3+d4+d5,K,f);
    [c3f,R1_3f,V3f] = PF(cota1,cota2,cotao3_mod,h1,h2,d1+d2+d3,d4+d5,K,f);
    [c4f,R1_4f,V4f] = PF(cota1,cota2,cotao4,h1,h2,d1+d2+d3+d4,d5,K,f);
    difracion_freqs(i,:)=[V1f V2f V3f V4f];
    %----A partir de i=4 O4 deja de ser obstáculo----------
    
    
    %lado izquierdo de O3
    [cp1,Rp1_1f,Vp1] = PF(cota1,cotao3_mod,cotao1,h1,0,d1,d2+d3,K,f);
    cp2=((d3)*(d2+d1)/(2*K*Ro)+cotao2)-((0+cotao3_mod-h1-cota1)*(d1+d2)/dE1o(3)+h1+cota1)
    Rp1_2=sqrt(lambda*(d3*(d2+d1)/dE1o(3)))
    Vp2=sqrt(2)*(cp2/Rp1_2)
    
    %lado izquierdo de O3
    cp4=((d4*d5)/(2*K*Ro)+cotao4)-((h2+cota2-0-cotao3_mod)*d4/(d4+d5)+0+cotao3_mod)
    Rp1_4=sqrt(lambda*(d5*d4/(d4+d5)))
    Vp4=sqrt(2)*(cp4/Rp1_4)
    
    if (Vp1>-0.78 || Vp2>-0.78)
       if(Vp1>Vp2) 
          LadVp1=6.9+20*log10(sqrt((Vp1-0.1)^2+1)+Vp1-0.1); 
          LadVp2=0;
       else
          LadVp2=6.9+20*log10(sqrt((Vp2-0.1)^2+1)+Vp2-0.1);
          LadVp1=0;
       end
        
    else
            LadVp1=0;
            LadVp2=0;  
    end
    

    if (Vp4>-0.78)  
         LadVp4=6.9+20*log10(sqrt((Vp4-0.1)^2+1)+Vp4-0.1);% Vp4 obstaculiza en i=1
    else
        LadVp4=0;
    end
    
    LadV3f=6.9+20*log10(sqrt((V3f-0.1)^2+1)+V3f-0.1);   
    T=1-exp(-LadV3f/6);
    C=10+0.04*(d/1e3);%d en km
    Lad=LadV3f+T*(LadVp1+LadVp2+LadVp4+C)
    Ladf1(i)=Lad;
end
figure()
plot(fvalores/1e9,Ladf1,'--','LineWidth',1.5,'color','k')
grid minor
xlabel('F(GHz)')
ylabel('L_{ad}(dB)')
title('Variación de las pérdidas por difracción con la frecuencia')

%% 4

h1=27;%m
h2=26;%m

%% 5.1 Calcular Prx con h1=x y h2=x


d=15.6e3;%m
f=2500e6;
Ptx=23;%dBm
Mod=16;%16-QAM
U=-70.5;%dBm. Umbral para BER_máx=10^-6
Lcrf=1;
Mf=3;%margen de funcionamiento
Gtx=19;
Grx=19;

%Opción 1: todo en dBs
lambda=3e8/f;
Lb=20*log10(4*pi*d/lambda);
Prx=Ptx-Mf+Gtx-2*Lcrf-Lb+Grx %dBm

%Opción 2: Paso a uds naturales y calculo flujo y Sef.
PIRE=Ptx-Lcrf+Gtx;%dBm
flujo=(10^(PIRE/10))/((4*pi*d^2)*(10^(Mf/10))); %mW/m2
Sef=lambda^2/(4*pi)*10^(Grx/10);
prx2=flujo*Sef*(1/10^(Lcrf/10)); %mW
Prx2=10*log10(prx2) %dBm
%% 5.2 Calcular Prx 


d=15.6e3;%m
f=2500e6;
Ptx=23;%dBm
Mod=16;%16-QAM
U=-70.5;%dBm. Umbral para BER_máx=10^-6
Lcrf=1;
Mf=3;%margen de funcionamiento
Gtx=19;
Grx=19;

h1=27;
h2=26;
K=2/3;

%-h1-____d1____-O1-___d2___-O2-___d3___-O3-__d4__-O4-__d5__-h2-

[c1,R1_1,V1] = PF(cota1,cota2,cotao1,h1,h2,d1,d2+d3+d4+d5,K,f);
[c2,R1_2,V2] = PF(cota1,cota2,cotao2,h1,h2,d1+d2,d3+d4+d5,K,f);
[c3,R1_3,V3] = PF(cota1,cota2,cotao3,h1,h2,d1+d2+d3,d4+d5,K,f);
[c4,R1_4,V4] = PF(cota1,cota2,cotao4,h1,h2,d1+d2+d3+d4,d5,K,f);
% solo O3 afecta:

Lad=6.9+20*log10(sqrt((V3-0.1)^2+1)+V3-0.1);

%Opción 1: todo en dBs
lambda=3e8/f;
Lb=20*log10(4*pi*d/lambda)+Lad;
Prx=Ptx-Mf+Gtx-2*Lcrf-Lb+Grx %dBm

%Opción 2: Paso a uds naturales y calculo flujo y Sef.
PIRE=Ptx-Lcrf+Gtx;%dBm
flujo=(10^(PIRE/10))/((4*pi*d^2)*(10^(Mf/10))*(10^(Lad/10))); %mW/m2
Sef=lambda^2/(4*pi)*10^(Grx/10);
prx2=flujo*Sef*(1/10^(Lcrf/10)); %mW
Prx2=10*log10(prx2) %dBm
%% 6.1
close all
clear

K=4/3;
f=450e6;
lambda=3e8/f;
Ro=6370e3;
d=6.843e3;
dt1=1644;
dt2=d-3265;
ht1=1763; 
ht2=1798; 
cota1=1652;
cota2=1678;
h1=10;
h2=50;
htx=cota1+h1; 
hrx=cota2+h2; 

Theta=((ht1-htx)/dt1)+((ht2-hrx)/dt2);
Beta=((hrx-htx)/d)+((ht2-hrx)/dt2);
dp=Beta*d/Theta;
hp=((ht1-htx)/dt1)*dp+htx;
R=(d-dt1-dt2)/Theta

%% 6.2

[cp,R1_p,Vp] = PFR(cota1,cota2,hp,h1,h2,dp,d-dp,f)

d1=sqrt(dp^2+(hp-htx)^2);
d2=sqrt((d-dp)^2+(hp-hrx)^2);


% %% 6.3
JVp = 6.9+20*log10(sqrt((Vp-0.1).^2+1)+Vp-0.1);


%Perdidas adiciolanes obstaculo redondeado
mnum=R*((d1+d2)/(d1*d2));
mden=((pi*R)/lambda)^(1/3);
m=mnum/mden;

nnum=cp*(((pi*R)/lambda)^(2/3));
nden=R;
n=nnum/nden;

condicion=n*m;

if condicion > 4
    Tm=-6-20*log10(m*n)+7.2*m^(1/2)-(2-17*n)*m+3.6*m^(3/2)-0.8*m^2;
else 
    Tm= 7.2*m^0.5 - (2-12.5*n)*m + 3.6*m^(3/2) - 0.8*m^2;
end

Lad = Tm + JVp

% %% 7.1
% clear
% close all
% 
% k=4/3;
% f=450*10^6;
% lamda=3e8/f;
% Ro=6370e3;
% d=6.8e3;
% dt1=1644;
% d2 = 3265;
% dt2=(d-(d2));
% ht1=1763; 
% ht2=1798; 
% htx=(10+1652); 
% hrx=(50+1678); 
% R=[0.5 50 5000 25000 50000];
% % R=1:1:50000;
% 
% Ladicional=zeros(1,length(R));
% a=1:1:length(R);
% for i=1:numel(a)
%    Ladicional1=0;
% phi=((ht1-htx)/dt1)+((ht2-hrx)/dt2);
% 
% 
% beta=((hrx-htx)/d)+((ht2-hrx)/dt2);
% dp=((beta*d)/phi);
% hp=((ht1-htx)/dt1)*dp+htx;
% 
% flecha=(dp*(d-dp))/(2*k*R0);
% rayoE1=htx; rayoE2=hrx;
% rayo=(rayoE2-rayoE1)*dp/(d)+rayoE1;
% desp=hp+flecha-rayo;
% R1=sqrt(lamda*(dp*(d-dp))/(d));
% J=100*desp/R1;
% Q=sqrt(2)*desp/R1;
% cp=hp-rayo;
% d1=sqrt(((0-dp)^2)+((htx-cp)^2));
% d2=sqrt(((d-dp)^2)+((hrx-cp)^2));
% 
% 
% %Perdidas adiciolanes obstaculo redondeado
% mnum=R(i)*(d1+d2)/(d1*d2);
% mden=((pi*R(i))/lamda)^(1/3);
% m=mnum/mden;
% 
% nnum=cp*(((pi*R(i))/lamda)^(2/3));
% nden=R(i);
% n=nnum/nden;
% 
% condicion=n*m;
% 
% if(condicion>4)
%     Ladicional1=-(-6-20*log10(m*n)+7.2*((m)^(1/2))-(2-17*m)*m+3.6*(m^(3/2))-0.8*(m^2));
% end
% 
% if(condicion<4)
%     Ladicional1=(7.2*sqrt(m)-((2-12.5*n)*m)+(3.6*(m^(3/2)))-(0.8*(m^2)));
% end
% Ladicional(i)=Ladicional1;
% end
% 
% figure()
% plot(R,Ladicional)
% title('Pérdidas en funcion del Radio de curvatura del obstáculo')
% xlabel('R')
% ylabel('L_{ad}(dB)')
% grid minor

%% 7.1 conclusiones