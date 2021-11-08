function [out] = operacionesMatriz(Matriz_A, Matriz_B)

msg = 'Hay un error de compatibilidad de matrices';
Tamano1 = size(Matriz_A);
Tamano2 = size(Matriz_B);

if((Tamano1(1,1))<(Tamano2(1,1)))
error(msg)
end

%Mostrar matrices introducidad
disp(Matriz_A)
disp(Matriz_B)
%Transposición de las matrices

Transpuesta_A = transpose(Matriz_A)
Transpuesta_B = transpose(Matriz_B)

%Inversa de A
Inversa_de_Matriz_A = inv(Matriz_A)

%Determinante y rango de A
Determinante_A = det(Matriz_A)
Rango_A = rank(Matriz_A)

%Producto matricial
ProductoMatriciaL = Matriz_A*Matriz_B

%Producto elemento a elemento
PorductoColumna1= times((Matriz_A(:,1)),(Matriz_B(:,1)))

%Vector fila con la primera fila de cada matriz

Vector_fila = [Matriz_A(1,:), Matriz_B(1,:)]

%Vector columna

Vector_columna = [Matriz_A(:,1); Matriz_B(:,1)]



end