'VARIABLES RADIO1 Y RADIO2'
cotat= % cota de la estación origen en metros
hantenat= % altura de la antena de la estación origen en metros
cotar= %cota de la estación final en metros 
hantenar= % altura de la antena de la estación final en metros
k=% factor k del radio efectivo de la tierra
R0=% radio de la tierra en km
f= % frecuencia del radioenlace en MHz
d1= % distancia del origen al obstáculo en metros
d= % longitud del enlace en metros
porcentaje_despejamiento_programa= % introduce el porcentaje de despejamiento
altura_geo_obstaculo= % altura del obstáculo en metros

'CALCULOS BASICOS'
ht=cotat+hantenat
hr=cotar+hantenar
lambda=3e2/f
d2=d-d1

'DISTANCIA DE VISIBILIDAD RADIOELÉCTRICA'
d_vis=3.57*sqrt(k)*(sqrt(ht)+sqrt(hr)) % en km

'DESPEJAMINENTO Y PORCENTAJE DE DESPEJAMIENTO DE LA'
'PRIMERA ZONA DE FRESNEL'
y=(hr-ht)*d1/d+ht % altura del rayo en metros
flecha= d1*d2/(2*k*R0*1000) % flecha en metros
despejamiento=(altura_geo_obstaculo+flecha)-y % despejamiento
R1_Fresnel=sqrt(lambda*d1*d2/(d1+d2)) % radio de la 1º zona de Fresnel
porcentaje_despejamiento_calculado=despejamiento*100/R1_Fresnel % porcentaje
%de despejamiento

'CALCULO DE LAS PERDIDAS POR DIFRACCIÓN'
v_programa=sqrt(2)*porcentaje_despejamiento_programa/100
perdidas_difraccion_programa=6.9+20*log10(sqrt((v_programa-0.1)^2+1)+v_programa-0.1)
v_calculado=sqrt(2)*porcentaje_despejamiento_calculado/100
perdidas_difraccion_calculadas=6.9+20*log10(sqrt((v_calculado-0.1)^2+1)+v_calculado-0.1)