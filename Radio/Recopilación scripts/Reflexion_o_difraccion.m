%  ADVERTENCIA: Cambiar Rh/Rv

% Con:
%     Conductividad = S/m
%     Permitividad  = sin unidades

P = (2/3^0.5)*(((K*R0*(h1+h2)+(Distancia^2)/4)))^0.5; 

if(h1>h2)
    Thau = acos((2*K*R0*(h1-h2)*Distancia)/P^3);
    d1 = Distancia/2+P*cos((pi+Thau)/3);
    d2=Distancia-d1;
else
    Thau = acos((2*K*R0*(h2-h1)*Distancia)/P^3);
    d2 = Distancia/2+P*cos((pi+Thau)/3);
    d1=Distancia-d2;
end

H2 = h2 - (d2^2)/(2*K*R0);
H1 = h1 - (d1^2)/(2*K*R0);

Phi = atan(H1/d1);
Phi_lim = (1/1000)*(5400/(f/1000))^(1/3);

Epsilon0    = Permeavilidad_terreno -1i*60*Conductividad*lambda;

if(Polarizacion == "Horizontal")    
    numerador   = Epsilon0*sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    denominator = Epsilon0*sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    Rv =numerador/denominator;
else
    numerador   = sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    denominator = sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
    Rh =numerador/denominator;    
end

if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"
    Rugosidad = 4*pi*Rho*sin(Phi)/lambda;    
    if(Rugosidad>0.3)
        %Las pérdidas por refelxión son cero;
        Lref = 0;
    else
        Dcaminos    = sqrt( Distancia*Distancia + abs(H1+H2)^2 ) - sqrt( Distancia*Distancia + abs(H1-H2)^2 );        
        Divergencia = ( 1 + (5*(d1/1000*d1/1000*d2/1000)/(16*K*(Distancia/1000)*H1)) )^(-0.5)
        Refectivo   = Rv*Divergencia*exp(-((Rugosidad*Rugosidad)/2))
        exponente   = (-1i*(((2*pi)/lambda))*Dcaminos);
        Lref_dB     = -20*log10(norm( 1 + (Refectivo*exp(exponente)) )) 
    end
    
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"
    if(Polarizacion == "horizontal") % Caso en el que Beta =1, por eso no está
      X  = ((pi/(lambda*R*R))^(1/3))*Distancia;
      Y2 = 2*(((pi*pi)/(lambda*lambda*R))^(1/3))*h2
      Y1 = 2*(((pi*pi)/(lambda*lambda*R))^(1/3))*h1
       if(X>=1.6)
         F = 11 + log10(X) -17.6*X
       else
         F = -20*log10(X) - 5.6488*(X^(1.425))
       end
       
       if(Y1>2)
         G1 = 17.6*sqrt(Y2-1.1) -5*log10(Y2-1.1) - 8          
       else
         G1 = 20*log10(Y1+0.1*Y1*Y1*Y1)
       end
       if(G1<(2 +20*log10(K)))
         G1 = 2 +20*log10(K);
       end
       
       if(Y2>2)
          G2 = 17.6*sqrt(Y1-1.1) -5*log10(Y-1.1) - 8          
       else
          G2 = 20*log10(Y2+0.1*Y2*Y2*Y2)
       end
       
       if(G2<(2 + 20*log10(K)))
          G2 = 2 + 20*log10(K);
       end
       
    Ldif_dB = - F - G1 - G2   
    end
end