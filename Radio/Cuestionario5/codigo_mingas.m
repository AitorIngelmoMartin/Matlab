%%%% OBSTACULOS %%%
clear;close all;clc;
%Datos
d=38e3;              %Distancia entre estaciones en metros
d1O1=15e3;           %Distancia de la estacion 1 al obstaculo 1 en metros
d2O1=d-d1O1;         %Distancia de la estacion 2 al obstaculo 1 en metros
d1O2=29e3;           %Distancia de la estacion 1 al obstaculo 2 en metros
d2O2=d-d1O2;         %Distancia de la estacion 2 al obstaculo 2 en metros
eE1=150;             %Elevacion estacion 1 en metros
eE2=200;             %Elevacion estacion 2 en metros
eO1=261;             %Elevacion obstaculo 1 en metros 
eO2=239;             %Elevacion obstaculo 2 en metros 
h1=150;              %Altura estacion 1
h2=40;               %Altura estacion 2
f=23e9;              %Frecuencia de trabajo

%Calculos previos
lambda=3e8/f;        %Valor de lambda
k=4/3;               %Factor k
R0=6370e3;           %Radio terrestre

r1O1=sqrt(lambda*((d1O1*d2O1)/(d1O1+d2O1))); %Radio Fresnel obstaculo 1
r1O2=sqrt(lambda*((d1O2*d2O2)/(d1O2+d2O2))); %Radio Fresnel obstaculo 2

bO1=(d1O1*d2O1)/(2*k*R0);                    %Abultamiento obstaculo 1
bO2=(d1O2*d2O2)/(2*k*R0);                    %Abultamiento obstaculo 2

yO1=((h2+eE2-h1-eE1)*d1O1/d)+h1+eE1;         %Altura rayo en obstaculo 1
yO2=((h2+eE2-h1-eE1)*d1O2/d)+h1+eE1;         %Altura rayo en obstaculo 2

cO1=bO1+eO1-yO1;                             %Despejamiento obstaculo 1                
cO2=bO2+eO2-yO2;                              %Despejamiento obstaculo 2

v1=sqrt(2)*(cO1/r1O1);                       %Parametro difraccion obstaculo 1
v2=sqrt(2)*(cO2/r1O2);                       %Parametro difraccion obstaculo 2

%Despejamiento suficiente en obstaculo 1
if(v1<=-0.78)
    if(v2>-0.78)
        Lad=6.9+20*log10(sqrt(((v2-0.1)^2)+1)+v2-0.1);
    end
end

%Despejamiento suficiente en obstaculo 2
if(v2<=-0.78)
    if(v1>-0.78)
        Lad=6.9+20*log10(sqrt(((v1-0.1)^2)+1)+v1-0.1);
    end
end


if(v1>-0.78 && v2>-0.78)

    %Metodo obstaculos parecidos
    if((v1<0 && v2<0) || (abs(v1-v2)<0.5))

        dO1O2 = d1O2 - d1O1 %Distancia entre obstaculo 1 y 2

        bO1prima= (d1O1*dO1O2)/(2*k*R0); %Nuevo abultamiento obstaculo 1
        bO2prima= (dO1O2*d2O2)/(2*k*R0); %Nuevo abultamiento obstaculo 2

        yO1prima=((eO2-h1-eE1)*d1O1/d1O2)+h1+eE1;   %Nueva altura rayo en obstaculo 1
        yO2prima=((h2+eE2-eO1)*dO1O2/d2O1)+eO1;     %Nueva altura rayo en obstaculo 2

        cO1prima=bO1prima+eO1-yO1prima;             %Nuevo despejamiento obstaculo 1                
        cO2prima=bO2prima+eO2-yO2prima;             %Nuevo despejamiento obstaculo 2

        r1O1prima=sqrt(lamda*((d1O1*dO1O2)/(d1O1+dO1O2))); %Nuevo radio Fresnel obstaculo 1
        r1O2prima=sqrt(lamda*((dO1O2*d2O2)/(dO1O2+d2O2))); %Nuevo radio Fresnel obstaculo 2
        
        v1prima=sqrt(2)*(cO1prima/r1O1prima);              %Nuevo parametro difraccion obstaculo 1
        v2prima=sqrt(2)*(cO2prima/r1O2prima);                        %Nuevo parametro difraccion obstaculo 2


        Ldif_v1prima=6.9+20*log10(sqrt(((v1prima-0.1)^2)+1)+v1prima-0.1); %Perdidas por difraccion obstaculo 1
        Ldif_v2prima=6.9+20*log10(sqrt(((v2prima-0.1)^2)+1)+v2prima-0.1); %Perdidas por difraccion obstaculo 2
        Lad=Ldif1+Ldif2+10*log10((d1O2*d2O1)/(dO1O2*(d1O2+d2O2))); %Perdidas adicionales

    end
    
    %Dos aristas aisladas con una predominante
    if((v1>0 || v2>0) || (abs(v1-v2)>0.5))
        %Obstaculo 2 predominante
        if(v2>v1)
            dO1O2 = d1O2 - d1O1; %Distancia entre obstaculo 1 y 2
            bO1prima= (d1O1*dO1O2)/(2*k*R0); %Nuevo abultamiento obstaculo 1
            yO1prima=((eO2-h1-eE1)*d1O1/d1O2)+h1+eE1;   %Nueva altura rayo en obstaculo 1
            cO1prima=bO1prima+eO1-yO1prima;             %Nuevo despejamiento obstaculo 1
            r1O1prima=sqrt(lambda*((d1O1*dO1O2)/(d1O1+dO1O2))); %Nuevo radio Fresnel obstaculo 1
            v1prima=sqrt(2)*(cO1prima/r1O1prima);              %Nuevo parametro difraccion obstaculo 1

            vd=v2;
            vs=v1;
            p=vd;
            q=vs;
            alpha=atan(((d*dO1O2)/(d1O1*d2O2))^(1/2));

            Ldif_v1prima=6.9+20*log10(sqrt(((v1prima-0.1)^2)+1)+v1prima-0.1); %Perdidas por difraccion obstaculo 1
            Ldif_v2=6.9+20*log10(sqrt(((v2-0.1)^2)+1)+v2-0.1);                %Perdidas por difraccion obstaculo 2
            Tc=(12-20*log10(2/(1-(alpha/pi))))*((q/p)^(2*p));

            Lad=Ldif_v1prima+Ldif_v2-Tc;

        end
        if(v1>v2)
            dO1O2 = d1O2 - d1O1; %Distancia entre obstaculo 1 y 2
            bO2prima= (dO1O2*d2O2)/(2*k*R0); %Nuevo abultamiento obstaculo 2
            yO2prima=((h2+eE2-eO1)*dO1O2/d2O1)+eO1;     %Nueva altura rayo en obstaculo 2
            cO2prima=bO2prima+eO2-yO2prima; %Nuevo despejamiento obstaculo 2
            r1O2prima=sqrt(lambda*((dO1O2*d2O2)/(dO1O2+d2O2))) %Nuevo radio Fresnel obstaculo 2
            v2prima=sqrt(2)*(cO2prima/r1O2prima)                        %Nuevo parametro difraccion obstaculo 2

            vd=v1;
            vs=v2;
            p=vd;
            q=vs;
            alpha=atan(((d*dO1O2)/(d1O1*d2O2))^(1/2));

            Ldif_v1=6.9+20*log10(sqrt(((v1-0.1)^2)+1)+v1-0.1); %Perdidas por difraccion obstaculo 1
            Ldif_v2prima=6.9+20*log10(sqrt(((v2prima-0.1)^2)+1)+v2prima-0.1) %Perdidas por difraccion obstaculo 2
            Tc=(12-20*log10(2/(1-(alpha/pi))))*((q/p)^(2*p));

            Lad=Ldif_v1+Ldif_v2prima-Tc;

        end
    end
end