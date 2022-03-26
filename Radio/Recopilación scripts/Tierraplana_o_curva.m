
K = 4/3;
termino1 = K*R0+h1;
termino2 = K*R0;
termino3 = K*R0+h2;
termino4 = K*R0;

Dmax = sqrt(termino1^2 - termino2^2)+sqrt(termino3^2 - termino4^2);

if(Distancia<0.1*Dmax) 
    %Código ejecutado si tierra plana
    Caso = "Tierra plana"
else
    %Código ejecutado si tierra curva
    Caso = "Tierra curva";
end

