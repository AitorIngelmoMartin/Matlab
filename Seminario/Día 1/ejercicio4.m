tiempos_Rangos = zeros(1,200);
tiempos_Determinantes = zeros(1,200);



for caso=1:200
    
    matriz_Estudiada = rand(caso);
    tic;
    
    rango = rank(matriz_Estudiada);
    tiempos_Rangos(caso) = toc;
    
    tic
    determinante = det(matriz_Estudiada);
    tiempos_Determinantes(caso) = toc;   
end

valores = linspace(1, 200, 200);

%Para ver as gráficas bien hay que agrandar la ventana

%Determinantes
subplot(2,2,1);
plot(valores, tiempos_Determinantes,'b-');
title(['\fontsize{14}Tiempo Determinantes'])
xlabel('Tamaño matriz (cuadrada)','fontsize',14)
ylabel('Tiempo (segúndos)','fontsize',14)
grid minor

%Rangos
subplot(2,2,2);
plot(valores, tiempos_Rangos, 'gs--');
title(['\fontsize{14}Tiempo Rangos'])
xlabel('Tamaño matriz (cuadrada)','fontsize',14)
ylabel('Tiempo (segúndos)','fontsize',14)
grid minor

%Ls dos superpuestas
subplot(2,2,3);
hold on
plot(valores, tiempos_Determinantes,'k-');
plot(valores, tiempos_Rangos, 'r-');
title(['\fontsize{14}Superpisición de tiempos'])
xlabel('Tamaño matriz (cuadrada)','fontsize',14)
ylabel('Tiempo (segúndos)','fontsize',14)
hold off
