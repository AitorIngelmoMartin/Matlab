%LLUVIA
% CALCULA K Y ALFA EN FUNCIÓN DE LA FRECUENCIA  Para horizontal [k,alfa]=lluvia(1,0,frec)

function [k,alfa]= lluvia(horc, verc,f,angulo,tau)

%kc=1 para calcular el valor de k
%alfac=1 para calcular el valor de alfa
%horc=1 para considerar polarizacion horizontal
%verc=1 para considedara polarizacion vertical
%f=frecuencia en GHz
%si vrec=horc=1 se puede hacer correccion en polarizacion
    %angulo=angulo de inclinacion pi/6
    %tau= pi/4 en caso de polarizacion circular
    %kc=[valor de k en polarizacion horizontal, valor de k en polarizacion vertical]
    %alfac=[valor de alfa en polarizacion horizontal, valor de alfa en polarizacion vertical]
for ind=1:length(f)
    
if horc&&verc
    
     
        a = [-5.33980  -0.35351 -0.23789 -0.94158];
        b = [-0.10008 1.26970 0.86036 0.64552];
        c = [1.13098 0.45400 0.15354 0.16817];
        m = -0.18961;
        ck = 0.71147;

        ptk=a.*exp(-((log10(f(ind))-b)./c).^2);
        kc(1)=10^(sum(ptk)+m*log10(f(ind))+ck);
    

        a = [-3.80595 -3.44965 -0.39902 0.50167];
        b = [0.56934 -0.22911 0.7304 1.07319];
        c = [0.81061 0.51059 0.11899 0.27195];
        m = -0.16398;
        ck = 0.63297;

        ptk=a.*exp(-((log10(f(ind))-b)./c).^2);
        kc(2)=10^(sum(ptk)+m*log10(f(ind))+ck);




        a = [-0.14318    0.29591    0.32177   -5.3761   16.1721];
        b = [ 1.82442    0.77564    0.63773   -0.9623   -3.2998];
        c = [-0.55187    0.19822    0.13164    1.47828    3.4399];
        m=0.67849;
        calfa=-1.95537;

        ptalfa=a.*exp(-((log10(f(ind))-b)./c).^2);
        alfac(1)=sum(ptalfa)+m*log10(f(ind))+calfa;

        

        a = [-0.07771    0.56727   -0.20238  -48.2991   48.5833];
        b = [2.3384    0.95545    1.1452    0.791669    0.791459];
        c = [-0.76284    0.54039    0.26809    0.116226    0.116479];
        m = -0.053739;
        calfa = 0.83433;
        
        ptalfa=a.*exp(-((log10(f(ind))-b)./c).^2);
        alfac(2)=sum(ptalfa)+m*log10(f(ind))+calfa;
      
  
        k(ind) = (kc(1) + kc(2) + (kc(1) - kc(2))*(cos(angulo))^2*cos(2*tau))/ 2;
        alfa(ind) = (kc(1)*alfac(1) + kc(2)*alfac(2) + (kc(1)*alfac(1) - kc(2)*alfac(2))*(cos(angulo))^2*cos(2*tau)) / (2*k);

elseif horc
        a = [-5.33980  -0.35351 -0.23789 -0.94158];
        b = [-0.10008 1.26970 0.86036 0.64552];
        c = [1.13098 0.45400 0.15354 0.16817];
        m = -0.18961;
        ck = 0.71147;

        ptk=a.*exp(-((log10(f(ind))-b)./c).^2);
        k(ind)=10^(sum(ptk)+m*log10(f(ind))+ck);
        
        a = [-0.14318    0.29591    0.32177   -5.3761   16.1721];
        b = [ 1.82442    0.77564    0.63773   -0.9623   -3.2998];
        c = [-0.55187    0.19822    0.13164    1.47828    3.4399];
        m=0.67849;
        calfa=-1.95537;

        ptalfa=a.*exp(-((log10(f(ind))-b)./c).^2);
        alfa(ind)=sum(ptalfa)+m*log10(f(ind))+calfa;
    
    elseif verc
        a = [-3.80595 -3.44965 -0.39902 0.50167];
        b = [0.56934 -0.22911 0.7304 1.07319];
        c = [0.81061 0.51059 0.11899 0.27195];
        m = -0.16398;
        ck = 0.63297;

        ptk=a.*exp(-((log10(f(ind))-b)./c).^2);
        k(ind)=10^(sum(ptk)+m*log10(f(ind))+ck);

        a = [-0.07771    0.56727   -0.20238  -48.2991   48.5833];
        b = [2.3384    0.95545    1.1452    0.791669    0.791459];
        c = [-0.76284    0.54039    0.26809    0.116226    0.116479];
        m = -0.053739;
        calfa = 0.83433;
        
        ptalfa=a.*exp(-((log10(f(ind))-b)./c).^2);
        alfa(ind)=sum(ptalfa)+m*log10(f(ind))+calfa;
      
    end

end

    

