clc;clear;close all;

Corriente_1 = [1:11];

Tension_1 = [
2.84  

3  

3.12  

3.24  

3.35  

3.47  

3.57  

3.67  

3.76  

3.86  

3.97  
];
Tension_1 = transpose(Tension_1);
Corriente_2 = [1 2  3  4  5  6  7  8  9  10  11 12 13 14 15 16 17 18 19 20 21 22];  

Tension_2 = [1.88 2  2.08  2.17 2.26  2.35 2.42 2.48 2.61 2.67 2.75 2.82 2.9 2.99 3.08 3.16 3.24 3.29 3.39 3.44 3.54 3.62] ; 


figure(1);
hold on 

plot(Tension_1,Corriente_1)
plot(Tension_2,Corriente_2)

hold off
title("Gráfica V/I Fotoemisor Nº1 y Nº5");
xlabel("Tensión [V]");ylabel("Corriente [mA]");
legend("Fotoemisor Nº1","Fotoemisor Nº5");



Desviacion = [
0 

0.5  

1.0  

1.5 

2.0 

2.5 

3.0 

3.5 

4.0 

4.5 

5.0 

];

Desviacion_1 = [
0 

0.5  

1.0  

1.5 

2.0 

2.5 

3.0 

3.5 

4.0 

4.5 



];

Desviacion_1 = transpose (Desviacion_1);
Desviacion = transpose(Desviacion);

dos_con_cinco = [ 
0 

  

-0.12  

-0.2  

-0.25  

-0.4  

-0.75  

-1.12  

-1.42   

-2.01  

-2.5 

  

 

-3.11 

];
dos_con_cinco = transpose(dos_con_cinco);

cinco_con_cero = [ 
0 

  

 -0.1 

-0.47  

-0.89  

-1  

-2.4  

 -3.51 

-4.12  

  

 

-5.2 

  

 

-7 

  

 



];

cinco_con_cero = transpose(cinco_con_cero);

figure(2);
hold on 

plot(Desviacion_1,cinco_con_cero)
plot(Desviacion,dos_con_cinco)

hold off
title("Desalineamiento lateral");
xlabel("Distancia [mm]");ylabel("Atenuación [dB]");
legend(" 5 mm","2.5 mm");