clc;clear;

f = 23e9;
lambda = 3e8/f;

G_dB = 35;

Lt_dB = 1.5;
Lt    = 10^(Lt_dB/10);

Grf_dB = 15;
Grf    = 10^(Grf_dB/10);


figura_ruido_rf_dB = 10;
figura_ruido_rf    = 10^(figura_ruido_rf_dB/10);

L_mezclador_dB = 3;
L_mezclador    = 10^(L_mezclador_dB/10);

Gfi_dB = 20;
Gfi    = 10^(Gfi_dB/10);

figura_ruido_fi_dB = 20;
figura_ruido_fi    = 10^(figura_ruido_fi_dB/10);

gamma_gases  = 0.5;
Eb_N0        = 13;
degradacion  = 6 + 1;
roll_off     = 0.4;
Rb           = 50e6;
R_001        = 27;
alpha        = 1.0214;
k            = 0.1286;

MTTR = 20;
MTBF = 1e6;

MD_vano1  = 35;
Distancia = [24 15]*1e3;
K         = 1.381e-23;

T_antena = 350;
T0       = 290;

T_total = T_antena/Lt + T0*(Lt-1)/Lt + T0*(figura_ruido_rf-1) + T0*(L_mezclador-1)/Grf + T0*(figura_ruido_fi-1)*L_mezclador/Grf;

Lgases_dB = gamma_gases*Distancia/1000;
Lbf_dB    = 20*log10(4*pi*Distancia/lambda);
Lb_dB     = Lbf_dB+Lgases_dB;

Umbral=Eb_N0+10*log10(K*T_total*Rb)+degradacion+30;

PIRE_dBm = Umbral + Lb_dB - G_dB + Lt_dB ;
Ptx_dBm  = PIRE_dBm + Lt_dB - G_dB;

R_001_alpha = R_001^alpha;
gamma_R     = k*R_001_alpha; 

Deff=(0.477*(Distancia*1e-3).^0.633*R_001^(0.073*alpha)*(f*1e-9)^0.123)-(10.579*(1-exp(-0.024*(Distancia*1e-3))));

if Deff<0.4
     Lef=(Distancia.*1e-3)*2.5;
else
     Lef=(Distancia.*1e-3)./Deff;
end

F_001=gamma_R*Lef;

if (f*1e-9)>=10
     C0=0.12+0.4*log10(((f*1e-9)/10)^0.8);
else
     C0=0.12;
end

C1 = (0.07^C0)*(0.12^(1-C0));
C2 = 0.855*C0+0.546*(1-C0);
C3 = 0.139*C0+0.043*(1-C0);

% MD mínimo cuando q=1%
MDmin=F_001*C1*1^(-C2-C3*log10(1));

% MD máximo cuando q=0.001%
MDmax=F_001*C1*0.001^(-C2-C3*log10(0.001));

for iteracion=1:2
    if MD_vano1>MDmin(iteracion)
        if MD_vano1<MDmax
            solucion=roots([C3 C2 log10(MD_vano1./(F_001(iteracion)*C1))]);
            q(:,iteracion)=10^(max(solucion));
        else
            q=0.001;
        end
    else
        q=Inf;
    end
end
Ueq         = 1.5*100*(MTTR/MTBF);
Utotalvano1 = Ueq+q;

Utotal = sum(Utotalvano1);