tamano = input ("Indique el tamaño de la matriz")

matriz = randn(tamano)

%Matriz con columnas imapres
columnas = size(matriz);
tamano_aux=0;
impar=0;
j=1;

for i=1:1:tamano
    
    aux = mod((i-1),2);
    
    if (aux == 0)
      impar=impar+1;
    end     
end

matriz_Impar = zeros(tamano, impar);

for k=1:1:tamano
    aux = mod((k-1),2);
    
    if (aux == 0)
     matriz_Impar(:,j) = matriz(:,k);
     j=j+1; 
    end 
end
disp('La matriz con als columnas impares es :')
disp(matriz_Impar)

%Diagonal

diagonal = diag(matriz)

%Valores máximos de cada columna

valores_Max = [max(matriz(1,:)); max(matriz(2,:)); max(matriz(3,:))]

%Valores mínimos de cada columna

valores_Min = [min(matriz(1,:)); min(matriz(2,:)); min(matriz(3,:))]

%Valores medios de cada columna
valores_Medios = [mean(matriz(1,:));mean(matriz(2,:));mean(matriz(3,:))]

%Varianza de cada columna
valores_Varianza = [var(matriz(1,:));var(matriz(2,:));var(matriz(3,:))]