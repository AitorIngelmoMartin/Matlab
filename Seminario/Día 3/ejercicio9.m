%Constantes
l1=0.3;
l2=0.2;

%Vectores
vector_Q1= [0:0.05:pi/2];
vector_Q2= [0:0.05:pi];

tamano1 = size(vector_Q1);
tamano2 = size(vector_Q2);
%Matrices meshgrid
[q1,q2] = meshgrid(vector_Q1,vector_Q2);

    for i=1:1:tamano1(1,2)        
       Matriz_M = matriz_DH(vector_Q1(1,i),vector_Q2(1,i))
    end




%Expresiones
%x = l1*cos(q1)+l2*cos(q1+q2)
%y = l1*sin(vector_Q1)+l2*sin(q1+q2)


