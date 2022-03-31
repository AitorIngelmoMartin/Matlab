function [] = estudiar_antena_incompleto(antena_objeto,frec,polarizacion)
figure();
show(antena_objeto)
g0=gcf;
g0.Name='Antena';
g0.NumberTitle='off';

%% 3D
figure()
pattern(antena_objeto,frec, -180:5:180,-180:5:180,'CoordinateSystem','polar', 'Type','directivity', 'Polarization',polarizacion)
g1=gcf;
g1.Name='Diagrama 3D';
g1.NumberTitle='off';

%% Azimut
figure()
pattern(antena_objeto,frec, -180:180,0, 'CoordinateSystem','rectangular', 'Type','directivity', 'Polarization',polarizacion)
g2=gcf;
g2.Name='Diagrama 2D Acimut cartesianas';
g2.NumberTitle='off';

%% Elevacion
figure()
pattern(antena_objeto,frec, 0, -180:180,'CoordinateSystem','rectangular', 'Type','directivity', 'Polarization',polarizacion)
g3=gcf;
g3.Name='Diagrama 2D Elevacion cartesianas';
g3.NumberTitle='off';
