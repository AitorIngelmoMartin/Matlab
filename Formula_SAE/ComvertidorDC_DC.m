Iin_max = 180; %En amperios

I0= 1;
V0=24;
F0= [1000:1000:20000]; %Array para hacer un análisis para determinar la Frec

VIN = [5:12];
VINmin = min(VIN);

D = (V0-VINmin)/V0; 
IL = I0/(1-D);
fin = size(F0);

%Bucle for para obtener valores en función de la frecuencia
%   No tiene sentido porque al ser inverdamente proporcional, cuanto menor
%   es la frecuencia mayor es la inductancia
for i=1:fin(1,2)    
   Ts(1,i) = 1/(F0(1,i));
   Inductancia(1,i) = ((Ts(1,i))/(2*I0))*(V0)*D*(1-D)^2;
end
Inductancia_Max = max(Inductancia)
Frec_Max =((find(Inductancia==Inductancia_Max))*1000)

%Esta línea es la prueba que hicimos con 20khz, ya que la bobina de
%0.04micro faradios no se puede comprar.

Inductancia_Prueba = (1/20000)/(2*I0)*(V0)*D*(1-D)^2

Ilb=(1/1000)/(2*Inductancia(1,1))*(V0)*D*(1-D)

%Frecuencia de corte de 10khs

%Es un FPS con un operacional / Cambio de la resistencia por un condensador

