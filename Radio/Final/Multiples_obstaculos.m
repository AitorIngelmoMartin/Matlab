clear;clc;

f      = 880e6;
lambda = 3e8/f;
R0     = 6370e3;

Distancia  = 34e3; 

e = [230 248 205 236 195];
a = [51 0 0 0 33];

d1 = [0 8e3 16e3 25e3 Distancia];
d2 = Distancia - d1;

k    = 4/3;
Re   = R0*k;
Dmax = sqrt(2*Re)*(sqrt(e(1)+a(1))+sqrt(e(end)+a(end))); 

   %parámetros

    flecha        = d1.*d2/(2*Re);
    altura_rayo   = ((e(end)+a(end)-e(1)-a(1))/Distancia) * d1 + e(1)+a(1);
    despejamiento = e + flecha - altura_rayo;

    R1  = sqrt(lambda*d1.*d2/Distancia); %Altura del primer rayo de Fresnel
    uve = sqrt(2)*despejamiento./R1;

    %Metodo 3: 3 obstáculos

    %Obstaculo a la izquierda del dominante

    Distancia_entre_obstaculos_IZQ = d1(3)-d1(2); %distancia entre obstaculo dominante y obstaculo izquierdo

    flecha_IZQ        = Distancia_entre_obstaculos_IZQ*d1(2)/(2*Re);
    altura_rayo_IZQ   = ((e(1) + a(1) - e(3))*Distancia_entre_obstaculos_IZQ/d1(3)) + e(3);
    despejamiento_IZQ = e(2) + flecha_IZQ - altura_rayo_IZQ;

    R1_IZQ  = sqrt(lambda*Distancia_entre_obstaculos_IZQ*d1(2)/d1(3)); %Altura del primer rayo de Fresnel
    uve_IZQ = sqrt(2)*(despejamiento_IZQ/R1_IZQ);

    Ldif_IZQ = 6.9 + 20*log10(sqrt((uve_IZQ-0.1)^2+1)+uve_IZQ-0.1)

    if (Ldif_IZQ < 0)
        Ldif_IZQ = 0;
    end

%-----------------------------------------------------------------------------

    %Obstaculo a la derecha del dominante

    Distancia_entre_obstaculos_DRCH = d1(4)-d1(3); %distancia entre obstaculo dominante y obstaculo derecho

    flecha_DRCH        = Distancia_entre_obstaculos_DRCH*d2(4)/(2*Re);
    altura_rayo_DRCH   = ((a(end) + e(end) - e(3))*Distancia_entre_obstaculos_DRCH/d2(3)) + e(3);
    despejamiento_DRCH = e(4) + flecha_DRCH - altura_rayo_DRCH;


    R1_DRCH  = sqrt(lambda*Distancia_entre_obstaculos_DRCH*d2(4)/d2(3)); %Altura del primer rayo de Fresnel
    uve_DRCH = sqrt(2)*(despejamiento_DRCH/R1_DRCH);

    Ldif_DRCH = 6.9 + 20*log10(sqrt((uve_DRCH - 0.1)^2 + 1) + uve_DRCH - 0.1)

    if (Ldif_DRCH < 0)
        Ldif_DRCH = 0;
    end

  %---------------------------------------------------------------------------

    Ldif_Dominante = 6.9 + 20*log10(sqrt((uve(3)-0.1)^2+1)+uve(3)-0.1); %Pérdidas del obstaculo dominante
    
    T = 1-exp(-Ldif_Dominante/6);
    C = 10 + 0.04*((d1(3)+d2(3))/1000);

    Lad_dB = Ldif_Dominante + T*(Ldif_IZQ + Ldif_DRCH + C)