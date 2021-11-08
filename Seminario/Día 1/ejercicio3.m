tamano = input ("Indique el tamaño de la matriz")

matriz = randn(tamano)
columnas = size(matriz);
tamano_aux=0;
j=1;

for i=1:1:tamano
    aux = mod((i-1),2);
    if (aux == 0)
     Matriz_impar(j,:) = matriz(:,i);
     j=j+1;
    end  
end   
disp(Matriz_impar)

