clc;clear
%Problema5test5
fas=14e9;
fdes=12e9;
lamdaas=3e8/fas;
lamdades=3e8/fdes;
N=8;
IBO=-4;
OBO=-1.3;
CI0=83;
EbN0=11.5;
Rb1=3e6;
Rb2=5e6;
Rb3=10e6;
rolloff=0.4;
cod=5/6;
d=39000e3;
Lgasesas=1.5;
Ma=0.5;
Lgasesdes=1.25;
Md=0.5;
B=36e6;
Bg=1.5e6;
Flujosat=-98;
GTsat=10;
PIREsat=52;
gananciaterrena=40;
Ta=22;
L=0.3;
lt1=10^(L/10);
FLNA=0.5;
gananciaLNA=40;
fr1=10^(FLNA/10);
T0=290;
K=1.38e-23;
lbfas=20*log10((4*pi*d)/lamdaas);
lbfdes=20*log10((4*pi*d)/lamdades);
%a
Rb1cod=Rb1*(1/cod);
Rb2cod=Rb2*(1/cod);
Rb3cod=Rb3*(1/cod);
Bw1=(1+0.4)*Rb1cod/2;
Bw2=(1+0.4)*Rb2cod/2;
Bw3=(1+0.4)*Rb3cod/2;
Btotal=4*Bw1+3*Bw2+Bw3;
PIRE1des=PIREsat+10*log10(Bw1/Btotal);
PIRE2des=PIREsat+10*log10(Bw2/Btotal);
PIRE3des=PIREsat+10*log10(Bw3/Btotal);
PIREtotal=Flujosat+10*log10(4*pi*(d^2))+Lgasesas+Ma;
PIRE1as=PIREtotal+10*log10(Bw1/Btotal);
PIRE2as=PIREtotal+10*log10(Bw2/Btotal);
PIRE3as=PIREtotal+10*log10(Bw3/Btotal);
%b
Tantena=Ta+(T0*(lt1-1))+(T0*(fr1-1)*lt1);
GTterrena=gananciaterrena-10*log10(Tantena);
%c
CN01as=PIRE1as+IBO-lbfas-Lgasesas-Ma+GTsat-10*log10(K);
CN01des=PIRE1des+OBO-lbfdes-Lgasesdes-Md+GTterrena-10*log10(K);
CN02as=PIRE2as+IBO-lbfas-Lgasesas-Ma+GTsat-10*log10(K);
CN02des=PIRE2des+OBO-lbfdes-Lgasesdes-Md+GTterrena-10*log10(K);
CN03as=PIRE3as+IBO-lbfas-Lgasesas-Ma+GTsat-10*log10(K);
CN03des=PIRE3des+OBO-lbfdes-Lgasesdes-Md+GTterrena-10*log10(K);
cn01total=1/((10^(-CN01as/10))+(10^(-CN01des/10))+(10^(-CI0/10)));
cn02total=1/((10^(-CN02as/10))+(10^(-CN02des/10))+(10^(-CI0/10)));
cn03total=1/((10^(-CN03as/10))+(10^(-CN03des/10))+(10^(-CI0/10)));
CN01total=10*log10(cn01total);
CN02total=10*log10(cn02total);
CN03total=10*log10(cn03total);
ebn0=10^(EbN0/10);
cn01totalmin=ebn0*Rb1;
cn02totalmin=ebn0*Rb2;
cn03totalmin=ebn0*Rb3;
CN01totalmin=10*log10(cn01totalmin);
CN02totalmin=10*log10(cn02totalmin);
CN03totalmin=10*log10(cn03totalmin);
%Solo se cumple el objetivo de calidad para la 1 estacion ya que la
%CN01total>CN01totalmin
%c Para que el sistema este disponible el 99,99% lo que haría sería poner
%en el enlace ascendente un UPC de MD=10 db y en el enlace descente un CAG
%de MD=8 dB
