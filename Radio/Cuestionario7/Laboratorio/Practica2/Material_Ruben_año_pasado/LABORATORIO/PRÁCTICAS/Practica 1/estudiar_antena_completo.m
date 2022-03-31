function [Z_ANT] = estudiar_antena_completo(antena_objeto,frec,polarizacion,barrido)
figure();
show(antena_objeto)
g0=gcf;
g0.Name='Antena';
g0.NumberTitle='off';

%% 3D
figure()
pattern(antena_objeto,frec,'CoordinateSystem','polar','Type','directivity','Polarization',polarizacion);
g1=gcf;
g1.Name='Diagrama 3D';
g1.NumberTitle='off';

%% Azimut
figure()
beamwidth(antena_objeto,frec,-180:180,0);
g2=gcf;
g2.Name='Diagrama 2D Acimut';
g2.NumberTitle='off';

%% Elevacion
figure()
beamwidth(antena_objeto,frec,0,-180:180);
g3=gcf;
g3.Name='Diagrama 2D Elevacion';
g3.NumberTitle='off';

%% Impedancia
figure()
impedance(antena_objeto,barrido);
g4=gcf;
g4.Name='Impedancia';
g4.NumberTitle='off';
Z_ANT=impedance(antena_objeto,frec);

%% Ancho de banda
figure()
returnLoss(antena_objeto,barrido,real(Z_ANT)); 
g2=gcf;
g2.Name='RL';
g2.NumberTitle='off';
end

