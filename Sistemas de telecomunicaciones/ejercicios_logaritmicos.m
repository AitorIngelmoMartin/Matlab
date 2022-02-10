clear;clc;close all;


Potencia_dBr = [3 5 0 1 -10 -1 -5 10 9 -2];

dBm0 = -3;

Preferencia = 1000*10*10^(dBm0/10); %En W

longitud_vector=size(Potencia_dBr);


Vector_potencia_watios = Preferencia*(10^(Potencia_dBr.*(1/10)))
for k=1:longitud_vector
    
   Vector_potencia_absoluto=10*log(Potencia_dBr/Preferencia)
   
end