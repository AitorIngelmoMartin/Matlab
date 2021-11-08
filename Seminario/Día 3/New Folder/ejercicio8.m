%Constantes
l1=0.3;
l2=0.2;

%Vectores
vector_Q1= [0:0.05:pi/2];
vector_Q2= [0:0.05:pi];

%Matrices meshgrid
[q1,q2] = meshgrid(vector_Q1,vector_Q2)

%Expresiones
x = l1*cos(q1)+l2*cos(q1+q2)

y = l1*sin(vector_Q1)+l2*sin(q1+q2)

%Representación de la función
plot([x,y],'xk')
hold on;

%Gráfica en rojo
vector_Q1= [0:0.05:pi/2];
vector_Q2= [-pi/2:0.05:pi/2];

[q1,q2] = meshgrid(vector_Q1,vector_Q2)

x = l1*cos(q1)+l2*cos(q1+q2)
y = l1*sin(vector_Q1)+l2*sin(q1+q2)

plot([x,y],'or')