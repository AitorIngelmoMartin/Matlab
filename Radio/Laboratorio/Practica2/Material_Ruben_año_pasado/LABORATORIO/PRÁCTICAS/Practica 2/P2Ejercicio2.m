%Introduce los datos
close all
clear 

Ptrans=23; %dBm
BER= 10^-6; % UN
Gt= 19;  % Ganancia en dB
Gr= 19;
f=2500*10^6; %frecuencia de trabajo en Hz
c=3*10^8;   %Velocidad de la luz en m
margen= 3;  %dB.
dbosque=0; %distancia del bosque en m
Am=1.15*(f/10^6)^0.43;
gammav=0; %dato de la gráfica de vegetación
gammag=0; %dato de la gráfica de gases
landa=c/f;
k= [0.55 2/3 1 4/3]; %constante.

Ro=6370000;  %Radio de la tierra en m.
dtotal=15640;  %distancia total del enlace en m.
d1= [2600 4031 9007 12369];  %distancias a las que están colocados los obstáculos en m.  
d2= dtotal-d1; %distancia del obstáculo a la Estación 2 en m.
cota= [784 787 801 802]; % cotas de los obstáculos en m.
he1= 773+15; %altura estación 1 en m.
he2= 807+15; % altura de la estación 2 en m.

 %Cálculo del paramétro de difracción (coef) 
for i=1:length(k) 
flecha=(d1.*d2)/(2*k(i)*Ro);
rayo=((he2-he1)*d1/dtotal)+he1;
despej=cota+flecha-rayo;
R1=sqrt((landa*d1.*d2)/dtotal); %Primer radio de Fresnell
coef=despej*sqrt(2)./R1; %Parámetro de difracción
despejporcentaje=coef*100/sqrt(2);
 
%Pérdidas
Lt=1;  %Pérdidas del cable transmisor en dB
Lr=1;  %Pérdidas del cable transmisor en dB
Le=6.9+20*log10(sqrt((coef-0.1).^2+1)+coef-0.1); %pérdidas adicionales
Lbf=20*log10(4*pi*dtotal*f/c); %pérdidas espacio libre
Lveget=Am*(1-exp((-dbosque*gammav)/Am)); %perdidas por vegetación
Lad = Le + Lbf + Lveget;
end
 
figure()
plot(k,Le)
xlabel('K');
ylabel('Le');

 for i=1:length(coef)
     if coef>-0.78
         j=1;
         %j=j+1;
     end
 end
 if j==1
    if f>=6*10^9
        Lgases=dtotal*gammag;  %Pérdidas por gases
    else 
        Lgases=0;
    end
    Prx=Ptrans+Gt+Gr-Lt-Lt-Lbf-margen-Le-Lgases-Lveget;
end
 if j==2
     if f>=6*10^9
        Lgases=dtotal*gammag;  %Pérdidas por gases
     else 
         Lgases=0;
     end
 
     if abs(coef(1)-coef(2))<0.5 %aristas aisladas
         Lad1=aristasaisladas(dtotal,d1,d2,cot,he1,he2,k,landa);
     else %Uno dominante
         Lad1=multiplesobstaculos(dtotal,d1,d2,cot,he1,he2,k,landa,Le,R1);
     end
      
    Prx=Ptrans+Gt+Gr-Lt-Lr-Lbf-margen-Lad1-Lgases-Lveget;
 end
 
 

