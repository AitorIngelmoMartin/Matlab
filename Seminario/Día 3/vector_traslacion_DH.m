function [ T ] = vector_traslacion_DH(d,q)
T = [d*cos(q), d*sin(q),0];

end