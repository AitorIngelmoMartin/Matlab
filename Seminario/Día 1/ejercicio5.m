superficie_A = [-5:0.1:100];
superficie_B = [-100:0.1:5];


[X,Y] = meshgrid(superficie_A, superficie_B);
Z = Y*sin(pi*(X/10))+5*cos((X^2 + Y^2)/8) + cos(X+ Y)*cos(3*X-Y);

%Representacion
subplot(2,2,1)
hold on
surf(X)



