clear
close all

f=23e9;
%P.H.
Disponibilidad=99;
UR_total=1;%
d_vano_max=40e3;%m
d=69.48e3;%m
Lt=1.5;
M_seg=2;

%antenas AL3-23/MPR:
G=43.6;
FBR=64;
XPD=32;

%número mínimo de vanos:
n_vanos_min=ceil(d/d_vano_max)

%punto medio:
punto_medio=d/2;
lat= 41.3597;
lon= -4.9158;


MTBF=20*365*24;%horas
MTTR=[36 24 16 45];%horas [Aviat Alcatel Truepoint Motorola]

GammaO=0.2;%dB/km
lambda=3e8/f;

%% 1 Estudio de viabilidad. Establecer el proceso iterativo de cálculo de la indisponibilidad

%1.1 Cálculo de R_001, k_h y alpha_h:
[R_001,P0,Rp_m,MT,T]=itur_p0837_7_annex1(0.01,lat,lon,0)
[k_h,alpha_h]= lluvia(1,0,f*1e-9)


%% 2. Estudio de viabilidad. Escoger los equipos
%Realización del balance de enlace para elegir equipo:

%Supondremos una transmisión entre estaciones (un vano)
Lb=20*log10(4*pi*(d/2)/lambda)+GammaO*(d/2)*1e-3;

% Caso de trabajo a 64 QAM:
Ptx_64=[16.5 16.5 16.5 17]-M_seg;%dBm [Alcatel Aviat-200M Aviat-250M Motorola]
U_64=[-71 -71 -67.5 -70.8]+M_seg;%dBm

PrxCN_64=Ptx_64-2*Lt+2*G-Lb
MD_64=PrxCN_64-U_64

% Caso de trabajo a 128 QAM:
Ptx_128=[15.5 15.5 17]-M_seg;%dBm [Alcatel Aviat Motorola]
U_128=[-65 -65 -67.8]+M_seg;%dBm

PrxCN_128=Ptx_128-2*Lt+2*G-Lb;
MD_128=PrxCN_128-U_128

% Caso de trabajo a 256 QAM:
Ptx_256=[NaN 13.5 15 15]-M_seg;%dBm [Alcatel Aviat Motorola-347M Motorola-368M]
U_256=[NaN -61.5 -65.1 -63.2]+M_seg;%dBm

PrxCN_256=Ptx_256-2*Lt+2*G-Lb;
MD_256=PrxCN_256-U_256

%% 3. Estudio de viabilidad. Calcular la atenuación por lluvia

%
UR_equipos=(3)*MTTR(4)*100/MTBF;
UR_lluvia=UR_total-UR_equipos;%

q=UR_lluvia
%Caso de 2 vanos: ET______RA_____ET->3equipos
UR_equipos=(3)*MTTR(4)*100/MTBF;
UR_lluvia=UR_total-UR_equipos;%
q=UR_lluvia;
d_2vanos=(d/2)*1e-3;
q=q/2;

[Fq2] = MDT(q,d_2vanos,f,R_001,k_h,alpha_h)


%Caso de 3 vanos: ET______RA____RA____ET->4equipos
UR_equipos=(4)*MTTR(4)*100/MTBF;
UR_lluvia=UR_total-UR_equipos;%
q=UR_lluvia;
q=q/3;

d_3vanos=(d/3)*1e-3;
[Fq3] = MDT(q,d_3vanos,f,R_001,k_h,alpha_h)

%Caso de 4 vanos: ET______RA____RA____RA____ET->5equipos
UR_equipos=(5)*MTTR(4)*100/MTBF;
UR_lluvia=UR_total-UR_equipos;%
q=UR_lluvia;
q=q/4;
d_4vanos=(d/4)*1e-3;
[Fq4] = MDT(q,d_4vanos,f,R_001,k_h,alpha_h)

%Caso de 5 vanos: ET______RA____RA____RA____RA____ET->6equipos
UR_equipos=(6)*MTTR(4)*100/MTBF;
UR_lluvia=UR_total-UR_equipos;%
q=UR_lluvia;
q=q/5;
d_5vanos=(d/5)*1e-3;
[Fq5] = MDT(q,d_5vanos,f,R_001,k_h,alpha_h)

%% 4. Estudio de viabilidad. Obtención del número mínimo devanos
%Caso de 2 vanos 256 QAM: ET______RA_____ET->3equipos
UR_equipos2=(3)*MTTR(4)*100/MTBF;
d_2vanos=(d/2)*1e-3;

Lb_2vanos=20*log10(4*pi*(d_2vanos*1e3)/lambda)+GammaO*d_2vanos;
PrxCN_2vanos_256=Ptx_256(4)-2*Lt+2*G-Lb_2vanos;
MD_2vanos_256=PrxCN_2vanos_256-U_256(4);

[q2_256] = MDTinv(MD_2vanos_256,d_2vanos,f,R_001,k_h,alpha_h);
UR_lluvia2_256=2*q2_256;

UR_total2_256=UR_lluvia2_256+UR_equipos2

%Caso de 3 vanos 256 QAM: ET______RA____RA____ET->4equipos
UR_equipos3=(4)*MTTR(4)*100/MTBF;
d_3vanos=(d/3)*1e-3;

Lb_3vanos=20*log10(4*pi*(d_3vanos*1e3)/lambda)+GammaO*d_3vanos;
PrxCN_3vanos_256=Ptx_256(4)-2*Lt+2*G-Lb_3vanos;
MD_3vanos_256=PrxCN_3vanos_256-U_256(4);

[q3_256] = MDTinv(MD_3vanos_256,d_3vanos,f,R_001,k_h,alpha_h);
UR_lluvia3_256=3*q3_256;

UR_total3_256=UR_lluvia3_256+UR_equipos3


%Caso de 4 vanos 256 QAM: ET______RA____RA____RA____ET->5equipos
UR_equipos4=(5)*MTTR(4)*100/MTBF;
d_4vanos=(d/4)*1e-3;

Lb_4vanos=20*log10(4*pi*(d_4vanos*1e3)/lambda)+GammaO*d_4vanos;
PrxCN_4vanos_256=Ptx_256(4)-2*Lt+2*G-Lb_4vanos;
MD_4vanos_256=PrxCN_4vanos_256-U_256(4);

[q4_256] = MDTinv(MD_4vanos_256,d_4vanos,f,R_001,k_h,alpha_h);
UR_lluvia4_256=4*q4_256;

UR_total4_256=UR_lluvia4_256+UR_equipos4

%Caso de 5 vanos 256 QAM: ET______RA____RA____RA____RA____ET->6equipos
UR_equipos5=(6)*MTTR(4)*100/MTBF;
d_5vanos=(d/5)*1e-3;

Lb_5vanos=20*log10(4*pi*(d_5vanos*1e3)/lambda)+GammaO*d_5vanos;
PrxCN_5vanos_256=Ptx_256(4)-2*Lt+2*G-Lb_5vanos;
MD_5vanos_256=PrxCN_5vanos_256-U_256(4);

[q5_256] = MDTinv(MD_5vanos_256,d_5vanos,f,R_001,k_h,alpha_h);
UR_lluvia5_256=5*q5_256;

UR_total5_256=UR_lluvia5_256+UR_equipos5

%Caso de 2 vanos 128 QAM: ET______RA_____ET->3equipos
UR_equipos2=(3)*MTTR(4)*100/MTBF;
d_2vanos=(d/2)*1e-3;

Lb_2vanos=20*log10(4*pi*(d_2vanos*1e3)/lambda)+GammaO*d_2vanos;
PrxCN_2vanos_128=Ptx_128(3)-2*Lt+2*G-Lb_2vanos;
MD_2vanos_128=PrxCN_2vanos_128-U_128(3);

[q2_128] = MDTinv(MD_2vanos_128,d_2vanos,f,R_001,k_h,alpha_h);
UR_lluvia2_128=2*q2_128;

UR_total2_128=UR_lluvia2_128+UR_equipos2

%Caso de 3 vanos 128: ET______RA____RA____ET->4equipos
UR_equipos3=(4)*MTTR(4)*100/MTBF;
d_3vanos=(d/3)*1e-3;
Lb_3vanos=20*log10(4*pi*(d_3vanos*1e3)/lambda)+GammaO*d_3vanos;
PrxCN_3vanos_128=Ptx_128(3)-2*Lt+2*G-Lb_3vanos;
MD_3vanos_128=PrxCN_3vanos_128-U_128(3);

[q3_128] = MDTinv(MD_3vanos_128,d_3vanos,f,R_001,k_h,alpha_h);
UR_lluvia3_128=3*q3_128;

UR_total3_128=UR_lluvia3_128+UR_equipos3


%Caso de 4 vanos: ET______RA____RA____RA____ET->5equipos
UR_equipos4=(5)*MTTR(4)*100/MTBF;
d_4vanos=(d/4)*1e-3;
Lb_4vanos=20*log10(4*pi*(d_4vanos*1e3)/lambda)+GammaO*d_4vanos;
PrxCN_4vanos_128=Ptx_128(3)-2*Lt+2*G-Lb_4vanos;
MD_4vanos_128=PrxCN_4vanos_128-U_128(3);

[q4_128] = MDTinv(MD_4vanos_128,d_4vanos,f,R_001,k_h,alpha_h);
UR_lluvia4_128=4*q4_128;

UR_total4_128=UR_lluvia4_128+UR_equipos4

%Caso de 5 vanos: ET______RA____RA____RA____RA____ET->6equipos
UR_equipos5=(6)*MTTR(4)*100/MTBF;
d_5vanos=(d/5)*1e-3;

Lb_5vanos=20*log10(4*pi*(d_5vanos*1e3)/lambda)+GammaO*d_5vanos;
PrxCN_5vanos_128=Ptx_128(3)-2*Lt+2*G-Lb_5vanos;
MD_5vanos_128=PrxCN_5vanos_128-U_128(3);

[q5_128] = MDTinv(MD_5vanos_128,d_5vanos,f,R_001,k_h,alpha_h);
UR_lluvia5_128=5*q5_128;

UR_total5_128=UR_lluvia5_128+UR_equipos5


%Caso de 2 vanos 64 QAM: ET______RA_____ET->3equipos
UR_equipos2=(3)*MTTR(4)*100/MTBF;
d_2vanos=(d/2)*1e-3;

Lb_2vanos=20*log10(4*pi*(d_2vanos*1e3)/lambda)+GammaO*d_2vanos;
PrxCN_2vanos_64=Ptx_64(4)-2*Lt+2*G-Lb_2vanos;
MD_2vanos_64=PrxCN_2vanos_64-U_64(4);

[q2_64] = MDTinv(MD_2vanos_64,d_2vanos,f,R_001,k_h,alpha_h);
UR_lluvia2_64=2*q2_64;

UR_total2_64=UR_lluvia2_64+UR_equipos2

%Caso de 3 vanos 64 QAM: ET______RA____RA____ET->4equipos
UR_equipos3=(4)*MTTR(4)*100/MTBF;
d_3vanos=(d/3)*1e-3;

Lb_3vanos=20*log10(4*pi*(d_3vanos*1e3)/lambda)+GammaO*d_3vanos;
PrxCN_3vanos_64=Ptx_64(4)-2*Lt+2*G-Lb_3vanos;
MD_3vanos_64=PrxCN_3vanos_64-U_64(4);

[q3_64] = MDTinv(MD_3vanos_64,d_3vanos,f,R_001,k_h,alpha_h);
UR_lluvia3_64=3*q3_64;

UR_total3_64=UR_lluvia3_64+UR_equipos3


%Caso de 4 vanos 64 QAM: ET______RA____RA____RA____ET->5equipos
UR_equipos4=(5)*MTTR(4)*100/MTBF;
d_4vanos=(d/4)*1e-3;

Lb_4vanos=20*log10(4*pi*(d_4vanos*1e3)/lambda)+GammaO*d_4vanos;
PrxCN_4vanos_64=Ptx_64(4)-2*Lt+2*G-Lb_4vanos;
MD_4vanos_64=PrxCN_4vanos_64-U_64(4);

[q4_64] = MDTinv(MD_4vanos_64,d_4vanos,f,R_001,k_h,alpha_h);
UR_lluvia4_64=4*q4_64;

UR_total4_64=UR_lluvia4_64+UR_equipos4

%Caso de 5 vanos 64 QAM: ET______RA____RA____RA____RA____ET->6equipos
UR_equipos5=(6)*MTTR(4)*100/MTBF;
d_5vanos=(d/5)*1e-3;

Lb_5vanos=20*log10(4*pi*(d_5vanos*1e3)/lambda)+GammaO*d_5vanos;
PrxCN_5vanos_64=Ptx_64(4)-2*Lt+2*G-Lb_5vanos;
MD_5vanos_64=PrxCN_5vanos_64-U_64(4);

[q5_64] = MDTinv(MD_5vanos_64,d_5vanos,f,R_001,k_h,alpha_h);
UR_lluvia5_64=5*q5_64;

UR_total5_64=UR_lluvia5_64+UR_equipos5


%% 7. Planificación final. Calcular la indisponibilidad del radioenlace real para más de un esquema de transmsión
d_1v=17.2;%(Valladolid-RA1)
d_2v=17.19;%(RA1-RA2)
d_3v=17.36;%(RA2-RA3)
d_4v=17.61;%(RA3-RA4)
d_5v=17.12;%(RA4-Ávila)

%Cálculos de R_001 en los puntos medios de los vanos:
lat1=41.5447;
lon1=-4.6552;

lat2=41.435;
lon2=-4.7052;

lat3=41.3147;
lon3=-4.7988;

lat4=41.2230;
lon4=-4.9036;

lat5=41.1452;
lon5=-5.0788;

[R_001_1v,P0,Rp_m,MT,T]=itur_p0837_7_annex1(0.01,lat1,lon1,0);
[R_001_2v,P0,Rp_m,MT,T]=itur_p0837_7_annex1(0.01,lat2,lon2,0);
[R_001_3v,P0,Rp_m,MT,T]=itur_p0837_7_annex1(0.01,lat3,lon3,0);
[R_001_4v,P0,Rp_m,MT,T]=itur_p0837_7_annex1(0.01,lat4,lon4,0);
[R_001_5v,P0,Rp_m,MT,T]=itur_p0837_7_annex1(0.01,lat5,lon5,0);

dv=[d_1v d_2v d_3v d_4v d_5v];
Lb_v=20*log10(4*pi*(dv*1e3)/lambda)+GammaO*dv;

%Esquema 128 QAM:
PrxCN_v_128=Ptx_128(3)-2*Lt+2*G-Lb_v;
MD_v_128=PrxCN_v_128-U_128(3);
[q_1v_128] = MDTinv(MD_v_128(1),dv(1),f,R_001_1v,k_h,alpha_h);
[q_2v_128] = MDTinv(MD_v_128(2),dv(2),f,R_001_2v,k_h,alpha_h);
[q_3v_128] = MDTinv(MD_v_128(3),dv(3),f,R_001_3v,k_h,alpha_h);
[q_4v_128] = MDTinv(MD_v_128(4),dv(4),f,R_001_4v,k_h,alpha_h);
[q_5v_128] = MDTinv(MD_v_128(5),dv(5),f,R_001_5v,k_h,alpha_h);

UR_lluvia_real_128=q_1v_128+q_2v_128+q_3v_128+q_4v_128+q_5v_128;
UR_total_real_128=UR_lluvia_real_128+UR_equipos5

%Esquema 256 QAM:
PrxCN_v_256=Ptx_256(4)-2*Lt+2*G-Lb_v;
MD_v_256=PrxCN_v_256-U_256(4);
[q_1v_256] = MDTinv(MD_v_256(1),dv(1),f,R_001_1v,k_h,alpha_h);
[q_2v_256] = MDTinv(MD_v_256(2),dv(2),f,R_001_2v,k_h,alpha_h);
[q_3v_256] = MDTinv(MD_v_256(3),dv(3),f,R_001_3v,k_h,alpha_h);
[q_4v_256] = MDTinv(MD_v_256(4),dv(4),f,R_001_4v,k_h,alpha_h);
[q_5v_256] = MDTinv(MD_v_256(5),dv(5),f,R_001_5v,k_h,alpha_h);

UR_lluvia_real_256=q_1v_256+q_2v_256+q_3v_256+q_4v_256+q_5v_256;
UR_total_real_256=UR_lluvia_real_256+UR_equipos5


