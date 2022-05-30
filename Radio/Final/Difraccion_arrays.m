clc;clear;

f  = 23e9;
R0 = 6370000;
K  = 4/3;
Re = K*R0;

h1 = 332;
h2 = 328;
Distancia = 38e3;
lambda    = 3e8/f;

e  = [150 261 239 200];
a  = [150 0 0 40];
d1 = [0 15e3 29e3 Distancia];
d2 = Distancia - d1;

flecha        = d1.*d2/(2*Re);
altura_rayo   = ((e(end)+a(end)-e(1)-a(1))/Distancia) * d1 + e(1)+a(1);
despejamiento = e + flecha - altura_rayo;

R1  = sqrt(lambda*d1.*d2/Distancia); %Altura del primer rayo de Fresnel
uve = sqrt(2)*despejamiento./R1;
uve(:,1)   =[];
uve(:,end) =[];



if((uve(1)<=-0.78) && (uve(2)>-0.78))
    "El obstáculo uno no interviene"
    Lad=6.9+20*log10(sqrt(((uve(3)-0.1)^2)+1)+uve(3)-0.1);
end
if((uve(2)<=-0.78) && (uve(1)>-0.78))
    "El obstáculo dos no interviene"
    Lad=6.9+20*log10(sqrt(((uve(2)-0.1)^2)+1)+uve(2)-0.1);
end

if( (((uve(1)<0) ||(uve(2)<0) ) && (abs(uve(1) -uve(2))<0.5)) || (((uve(1)>0) && (uve(2)>0) ) && (abs(uve(1) -uve(2))<0.5)) )    "Método uno, obstáculos parecidos" 
    %Para Ldif(uve'1)
        Distancia_obstaculos_IZQ = d1(3)-d1(2);
        
        flecha_IZQ        = Distancia_obstaculos_IZQ*d1(2)/(2*Re);
        altura_IZQ        = ((a(1) + e(1)- e(3))*Distancia_obstaculos_IZQ/d1(3)) + e(3);
        despejamiento_IZQ = e(2) + flecha_IZQ - altura_IZQ;

        R1_IZQ  = sqrt(lambda*Distancia_obstaculos_IZQ*d1(2)/d1(3)); %Altura del primer rayo de Fresnel 
        uve_IZQ = sqrt(2)*(despejamiento_IZQ/R1_IZQ);

        Ldif_IZQ_dB = 6.9 + 20*log10(sqrt((uve_IZQ - 0.1)^2 + 1)+uve_IZQ - 0.1);

    %Para Ldif(uve'2)
        Distancia_obstaculos_DRCH = d1(3)- d1(2); %distancia entre obstaculos

        flecha_DRCH = Distancia_obstaculos_DRCH*d2(3)/(2*Re);
        altura_rayo_DRCH = ((a(end) + e(end) - e(2))*Distancia_obstaculos_DRCH/d2(2)) + e(2); 
        despejamiento_DRCH = e(3) + flecha_DRCH - altura_rayo_DRCH;

        R1_DRCH = sqrt(lambda*Distancia_obstaculos_DRCH*d2(3)/d2(2)); %Altura del primer rayo de Fresnel 
        uve_DRCH = sqrt(2)*(despejamiento_DRCH/R1_DRCH);

        Ldif_DRCH_dB = 6.9 + 20*log10(sqrt((uve_DRCH - 0.1)^2 + 1) + uve_DRCH - 0.1);

        Lad_dB = Ldif_IZQ_dB + Ldif_DRCH_dB + 10*log10(d1(3)*d2(2)/(Distancia_obstaculos_DRCH*(d1(3) + d2(3))))
end

if( ( (uve(1)>0) && (uve(2)>0) ) && (abs(uve(1) -uve(2))>0.5) )    "Método dos, obsáculo dominante"
           Distancia_obstaculos = d1(3)-d1(2);
           tan_alfa = (Distancia*Distancia_obstaculos/(d1(2)*d2(3)))^(1/2);
           alfa     = atan(tan_alfa);
           Tc = (12-20*log10(2/(1-(alfa/pi))))*(uve(2)/uve(1))^(2*uve(1));
    
        if(uve(1)>uve(2))
            "Obstáculo 1 dominante"
            flecha_2_prima        = Distancia_obstaculos*d2(3)/(2*Re);
            altura_2_prima        = ((a(end)+e(end)-e(2))*Distancia_obstaculos/d2(2))+e(2);
            despejamiento_2_prima = e(3) + flecha_2_prima - altura_2_prima;

            R1_2_prima  = sqrt(lambda*Distancia_obstaculos*d2(3)/d2(2)); %Altura del primer rayo de Fresnel
            uve_2_prima = sqrt(2)*(despejamiento_2_prima/R1_2_prima);
            
            if uve_2_prima<=-0.78
               Ldif_2_prima_dB = 0;
            else
               Ldif_2_prima_dB = 6.9 + 20*log10(sqrt((uve_2_prima-0.1)^2+1)+uve_2_prima-0.1);
            end
            
            Ldif_obstaculo_1_dB = 6.9 + 20*log10(sqrt((uve(1)-0.1)^2+1)+uve(1)-0.1);
            Lad_dB = Ldif_obstaculo_1_dB + Ldif_2_prima_dB - Tc      
        else
            "Obstáculo 2 dominante"
             flecha_1_prima        = do1_o2*d1(2)/(2*Re);
             altura_rayo_1_prima   = ((a(1)+e(1)-e(3))*Distancia_obstaculos/d1(3))+e(3);
             despejamiento_1_prima = e(2) + flecha_1_prima - altura_rayo_1_prima;

             R1_1_prima  = sqrt(lambda*Distancia_obstaculos*d1(2)/d1(3)); %Altura del primer rayo de Fresnel
             uve_1_prima = sqrt(2)*(despejamiento_1_prima/R1_1_prima);  
             
             if uve_prima<=-0.78
               Ldif_p2_dB = 0;
             else
               Ldif_prima_dB = 6.9 + 20*log10(sqrt((uve_2p-0.1)^2+1)+uve_2p-0.1);
             end
             
             Ldif_obstaculo_2_dB = 6.9 + 20*log10(sqrt((uve(1)-0.1)^2+1)+uve(1)-0.1);
             Lad_dB = Ldif_obstaculo_uno_dB + Ldif_prima_dB - Tc             
        end
        
    end
