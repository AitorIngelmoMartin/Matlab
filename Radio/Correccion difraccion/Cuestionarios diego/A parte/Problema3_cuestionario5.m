clear;clc;

f = 23e9;
c=3e8;
lambda= c/f;

% Alturas y distancias en metros

d = 38e3;
R0 =6370e3;

a1 = 150;
e1 = 150;
h1 = a1 + e1;

a2 = 40;
e2 = 200;
h2 = a2 + e2;

d_obs1 = 15e3;
d_obs2 = 29e3;
ho1 = 261;
ho2 = 239;


% -------------------------------------------------------------------------
k = 4/3;
Re = R0*k;
dmax = sqrt(2*Re)*(sqrt(h1)+sqrt(h2)); 

if(d<0.1*dmax) 
    %Código ejecutado si tierra plana
    "" + ...
        "" + ...
        "Tierra plana"
else
    %Código ejecutado si tierra curva
    "Tierra curva"
end

% -------------------------------------------------------------------------

% Parámetros de difracción

%Obstáculo 1
d1_obs1 = sqrt(2*Re*ho1);
d2_obs1 = d - d1_obs1;

flecha_obs1= d1_obs1*d2_obs1/(2*Re);
y_obs1 = (ho1-h1)/d_obs1 *d1_obs1+h1; % altura del rayo
despejamiento_obs1 = ho1+flecha_obs1-y_obs1; %despejamiento

 R1_o1 = sqrt(lambda*d_obs1*d2_obs1/(d1_obs1+d2_obs1)); %Primer rayo de Fresnel del obstáculo 1
 parametro_dif1 = sqrt(2)*despejamiento_obs1/R1_o1;

%Obstáculo 2
d1_obs2 = sqrt(2*Re*ho2);
d2_obs2 = d - d1_obs2;

flecha_obs2= d1_obs2*d2_obs2/(2*Re);
y_obs2 = (ho2-h1)/d_obs2 *d1_obs2+h1; % altura del rayo
despejamiento_obs2 = ho2+flecha_obs2-y_obs2; %despejamiento

R1_o2 = sqrt(lambda*d1_obs2*d2_obs2/(d1_obs2+d2_obs2)); %Primer rayo de Fresnel del obstáculo 2
parametro_dif2 = sqrt(2)*despejamiento_obs2/R1_o2;


%Parámetros actualizados

d2p_obs1 = d_obs2 - d1_obs1;
d1p_obs2 = d2p_obs1;

%De la estación 1 a obstáculo 2.



flechap_obs1= d1_obs1*d2p_obs1/(2*Re);
yp_obs1 = (ho2-h1)/d2p_obs1 *d1_obs1+h1; % altura del rayo
despejamientop_obs1 = ho2+flechap_obs1-yp_obs1; %despejamiento

R1p_o1 = sqrt(lambda*d1_obs1*d2p_obs1/(d1_obs1+d2p_obs1)); %Primer rayo de Fresnel del obstáculo 2
parametrop_dif1 = sqrt(2)*despejamientop_obs1/R1p_o1;

Ldifp1_dB = 6.9 + 20*log10(sqrt(((parametrop_dif1-0.1^2)+1) + parametrop_dif1-0.1));


%Del obstáculo 1 a la estación 2.


flechap_obs2= d1p_obs2*d2_obs2/(2*Re);
yp_obs2 = (ho2-h1)/d2_obs2 *d1p_obs2+h1; % altura del rayo
despejamientop_obs2 = ho2+flechap_obs2-yp_obs2; %despejamiento

R1p_o2 = sqrt(lambda*d1p_obs2*d2_obs2/(d1p_obs2+d2_obs2)); %Primer rayo de Fresnel del obstáculo 2
parametrop_dif2 = sqrt(2)*despejamientop_obs2/R1p_o2;

Ldifp2_dB = 6.9 + 20*log10(sqrt(((parametrop_dif2-0.1^2)+1) + parametrop_dif2-0.1));


% Pérdidas adicionales
 Lad_dB = Ldifp1_dB+Ldifp2_dB+10*log10(d1_obs2*d2_obs1/(d1p_obs2*(d1_obs2+d2_obs2)));














% % if(despejamiento_obs1 > 0 && despejamiento_obs1 == 0)
% %     %Código ejecutado si hay difracción
% %     "Existe difracción en el obstáculo 1"
% 
% 
% 
%     Ldif1_dB = 6.9 + 20*log10(sqrt(((parametro_dif1-0.1^2)+1) + parametro_dif1-0.1));
%     Ldif2_dB = 6.9 + 20*log10(sqrt(((parametro_dif2-0.1^2)+1) + parametro_dif2-0.1));
% 
%     %metodo de los dos obstáculos
%     if(parametro_dif1<0 && parametro_dif2<0 && abs(parametro_dif1-parametro_dif2)<0.5)
%         if(((parametro_dif1 | parametro_dif2)>0) && abs(parametro_dif1-parametro_dif2)<0.5)
%         %se usa el método 1
%             Lad_dB = Ldif1_dB+Ldif2_dB+10*log10(d1_obs1*d2_obs1/(d1_obs2*(d1_obs2+d2_obs2)));
%         else 
%         %se usa el método 2
%            
%             Lad_dB = Ldif1_dB + Ldif2_dB - Tc;
%         end 
%     end
%   
% % else 
% %     "No existe difracción, rayo directo"
% % end

