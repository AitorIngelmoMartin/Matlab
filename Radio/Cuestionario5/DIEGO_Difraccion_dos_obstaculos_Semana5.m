clear;clc;

f = 880e6;
c=3e8;
lambda= c/f;

% Se establece un enlace radio punto a punto desde el emplazamiento A con cota de 252m al emplazamiento B cota de 855m. 
% Las alturas de las antenas son iguales a 40m, en el estacionamiento A, y 36, en el emplazamiento B. 

% Por un error en la instalación, las antenas se han orientado perfectamente en azimut pero con una elevación 
% paralela a la horizontal (ángulo de elevación, en ambos emplazamientos, 0°). 

% El terreno presenta dos obstáculos agudos: 
% O1: de cota 396m a 3km de la estación A 
% O2: de cota 642m a 10km de la estación A 

% Alturas, distancia y radio en metros

d = 34e3; %en Km
R0 =6370e3;

e = [230 248 205 236 195];
a = [51 0 0 33];
d1 = [0 8e3 16e3 25 d];
d2 = d - d1;

% -------------------------------------------------------------------------
k = 4/3;
Re = R0*k;
dmax = sqrt(2*Re)*(sqrt(e(1)+a(1))+sqrt(e(end)+a(end))); 

if(d<0.1*dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end
% -------------------------------------------------------------------------

%Como hay obstáculos, solo existen pérdidas por difracción
    "Hay pérdidas por difracción"


   %parámetros

    flecha = d1.*d2/(2*Re);
    altura_rayo = ((e(end)+a(end)-e(1)-a(1))/d) * d1 + e(1)+a(1);
    despejamiento = e + flecha - altura_rayo;

    R1 = sqrt(lambda*d1.*d2/d); %Altura del primer rayo de Fresnel
    uve = sqrt(2)*despejamiento./R1;

%--------------------------------------------------------------------------

    %Despejamiento suficiente en obstaculo 1

    if(uve(2)<=-0.78)
        if(uve(3)>-0.78)
             Lad=6.9+20*log10(sqrt(((uve(3)-0.1)^2)+1)+uve(3)-0.1);
        end
    end

    %Despejamiento suficiente en obstaculo 2

    if(uve(3)<=-0.78)
        if(uve(2)>-0.78)
            Lad=6.9+20*log10(sqrt(((uve(2)-0.1)^2)+1)+uve(2)-0.1);
         end
    end

%---------------------------------------------------------------------------

    if( ( (uve(2)<0) ||(uve(3)<0) ) && (abs(uve(2) - uve(3))<0.5) )
        "Método uno, obstáculos parecidos"
        
    end

    if( ( (uve(2)>0) && (uve(3)>0) ) && (abs(uve(2) -uve(3))>0.5) )
        "Método dos, obsáculo dominante"

        % Parámetros modificados

        %Obstaculo 1 predominante
        if(uve(2)>uve(3))
            "Obstáculo 1 dominante"

            do1_o2 = d1(3)-d1(2); %distancia entre obstaculos

             flecha_1p = do1_o2*d2(3)/(2*Re);
             altura_rayo_1p = ((a(end)+e(end)-e(2))*do1_o2/d2(2))+e(2);
             despejamiento_1p = e(3) + flecha_1p - altura_rayo_1p;

             R1_1p = sqrt(lambda*do1_o2*d2(3)/d2(2)); %Altura del primer rayo de Fresnel
             uve_2p = sqrt(2)*(despejamiento_1p/R1_1p);
%   R1_A_prima= sqrt(lambda*Distancia_entre_obstaculos*Distancia_E2_O1/Distancia_E1_O2);
%-------------------------------------------------------------------------------------



            tan_alfa = (d*do1_o2/(d1(2)*d2(3)))^(1/2);
            alfa = atan(tan_alfa);
            p = uve(2);
            q = uve(3);
            Tc = (12-20*log10(2/(1-(alfa/pi))))*(q/p)^(2*p);

        if uve_2p<=-0.78

             Lp2_dB = 0;

         else

              Lp2_dB = 6.9 + 20*log10(sqrt((uve_2p-0.1)^2+1)+uve_2p-0.1);

         end

     L1_dB = 6.9 + 20*log10(sqrt((uve(2)-0.1)^2+1)+uve(2)-0.1);

     

         end
    end
    
    Lad_dB = L1_dB + Lp2_dB - Tc;



