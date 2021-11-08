function [ M ] = matriz_DH(q1,q2)

d = [0.3, .02];

R1 = matriz_rotacion_DH(q1);
R2 = matriz_rotacion_DH(q2);

T1 = vector_traslacion_DH(d(1,1),q1);
T2 = vector_traslacion_DH(d(1,1),q2);

M1 = [R1;T1];
M2 = [R2;T2];

M= M1+M2;
end