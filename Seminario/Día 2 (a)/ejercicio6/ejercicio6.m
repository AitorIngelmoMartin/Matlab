k= 1.5;

num1 = [1];
den1 = [1 20];

num2 = [1];
den2 = [1 2 5];

G1= tf(num1,den1)
G2= tf(num2,den2)

Paralelo = parallel(G1,G2)

num3 = Paralelo.Numerator{:}
den3 = Paralelo.Denominator{:}
