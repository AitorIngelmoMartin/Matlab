function [frecuencia_corte] = frecuencia_corte(a,b,m,n,epsilon)
    if(nargin<5)
        epsilon =1;
    end

frecuencia_corte = (3e8/(2*sqrt(epsilon)))*sqrt( (m/a)^2 + (n/b)^2 );
end

