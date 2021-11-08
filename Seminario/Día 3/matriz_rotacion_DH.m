function [ R ] = matriz_rotacion_DH(q)
R = [cos(q) -sin(q) 0; sin(q) cos(q) 0; 0 0 1];
end