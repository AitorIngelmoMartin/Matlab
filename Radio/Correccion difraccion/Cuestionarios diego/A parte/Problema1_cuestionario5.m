clear;clc;

f = 2.5;
c=3e8;
lambda= c/f;
Lt_dB = 3;

% Alturas, distancia y radio en metros
G_dB = 34;
h1 = 8;
h2 = 22;
d = 13e3;
R0 =6370e3;
Epsilon0= -0.8628;

% -------------------------------------------------------------------------
k = 4/3;
Re = R0*k;
dmax = sqrt(2*Re)*(sqrt(h1)+sqrt(h2)); 

if(d<0.1*dmax) 
    %Código ejecutado si tierra plana
    "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

p = (2/3^0.5)*(((k*R0*(h1+h2)+(d^2)/4)))^0.5; 

if(h1>h2)
    theta = acos((2*k*R0*(h1-h2)*d)/p^3);
    d1 = d/2+p*cos((pi+theta)/3)*(1/1000);
    d2=d-d1;
else
    theta = acos((2*k*R0*(h2-h1)*d)/p^3);
    d2 = d/2+p*cos((pi+theta)/3)*(1/1000);
    d1=d-d2;
end

hp2 = h2 - (d2^2)/(2*k*R0);
hp1 = h1 - (d1^2)/(2*k*R0);

Phi = atan(hp1/d1);
Phi_lim = (1/1000)*(5400/(f/1000))^(1/3);

numerador   = sin(Phi) - sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
denominador = sin(Phi) + sqrt(Epsilon0-(cos(Phi)*cos(Phi)));
Rh =numerador/denominador;
% Programar para que vaya solito por PH/PV


if(Phi>=Phi_lim)
 %Código ejecutado si hay reflexión -> MTC
    "Hay pérdidas por reflexión"
    
        dif_caminos =sqrt( d^2 + (hp1+hp2)^2 ) - sqrt( d^2 + (hp1-hp2)^2 );
        
        Divergencia = ( 1 + (5*(d1/1000*d1/1000*d2/1000)/(16*k*(d/1000)*hp1)) )^(-0.5);
        R_efectivo = Rh*Divergencia;
        exponente = (-1i*(((2*pi)/lambda))*dif_caminos);
        Lref_dB   = -20*log10(norm( 1 + (R_efectivo*exp(exponente)) ));     
else
 %Código ejecutado si hay difracción -> MDTE
    "Hay pérdidas por difracción"

        beta = 1; %aproximación

        X = beta*d*(pi/(lambda*Rh^2))^(-1/3);
        Y1 = 2*beta*h1*(pi^2/(lambda^2)*Rh)^(1/3);
        Y2 = 2*beta*h2*(pi^2/((lambda^2)*Rh))^(1/3);
        
        if(X>=1.6)
            F = 11 + log10(X) - 17.6*X;

        else
            F = -20*log10(X) - 5.6488*X^1.425;

        end


        if(Y1>2 || Y2>2)
           G1 = 17.6*sqrt(beta*Y1-11) - 5*log10(beta*Y1-11) - 8;
           G2 = 17.6*sqrt(beta*Y2-11) - 5*log10(beta*Y2-11) - 8;
        else
            G1 = 20*log10(beta*Y1+0.1*(beta*Y1)^3);
            G2 = 20*log10(beta*Y2+0.1*(beta*Y2)^3);
        end

        if((G1 || G2) < 2+20*log10(k))
            G1 = 2+20*log10(k);
            G2 = 2+20*log10(k);
        end


        Lad_dB = -F -G1 -G2;
end


%-----------------------------------------------------------------------------------


