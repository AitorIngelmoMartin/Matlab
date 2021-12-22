% Approximation to reflection coefficients for
% Chebyshev multi-section matching.
%
% Reference data from Microwave Engineering 2nd Ed   D.M.Pozar
% Ripple 0.05 (-26.02 dB)
% Impedance ratio ZL/Zo=2 (e.g. Match 100 Ohms to 50 Ohms)
% Number of sections N=2 to 7

close all;
clear all;
help chapprox;
Zo=50;

N2R2=[1.2193,1.6402];                                    % Tm=0.05 ZL/Zo=2 N=2
N3R2=[1.1475,1.4142,1.7429];                             % Tm=0.05 ZL/Zo=2 N=3
N4R2=[1.1201,1.2979,1.5409,1.7855];                      % Tm=0.05 ZL/Zo=2 N=4
N5R2=[1.0490,1.1821,1.4142,1.6919,1.9066];               % Tm=0.05 ZL/Zo=2 N=5
N6R2=[1.0284,1.1185,1.2957,1.5436,1.7880,1.9447];        % Tm=0.05 ZL/Zo=2 N=6
N7R2=[1.0165,1.0766,1.2076,1.4142,1.6561,1.8577,1.9675]; % Tm=0.05 ZL/Zo=2 N=7

Zn2r2=fliplr(N2R2)*Zo;
Zn3r2=fliplr(N3R2)*Zo;
Zn4r2=fliplr(N4R2)*Zo;
Zn5r2=fliplr(N5R2)*Zo;
Zn6r2=fliplr(N6R2)*Zo;
Zn7r2=fliplr(N7R2)*Zo;

Tn2r2=(Zn2r2-Zo)./(Zn2r2+Zo);
Tn3r2=(Zn3r2-Zo)./(Zn3r2+Zo);
Tn4r2=(Zn4r2-Zo)./(Zn4r2+Zo);
Tn5r2=(Zn5r2-Zo)./(Zn5r2+Zo);
Tn6r2=(Zn6r2-Zo)./(Zn6r2+Zo);
Tn7r2=(Zn7r2-Zo)./(Zn7r2+Zo);

X2=1:1:2;
X3=1:1:3;
X4=1:1:4;
X5=1:1:5;
X6=1:1:6;
X7=1:1:7;

figure(1)
plot(X2,Tn2r2,'r-',X2,Tn2r2,'r+',...
   X3,Tn3r2,'g-',X3,Tn3r2,'g+',...
   X4,Tn4r2,'c-',X4,Tn4r2,'c+',...
   X5,Tn5r2,'m-',X5,Tn5r2,'m+',...
   X6,Tn6r2,'y-',X6,Tn6r2,'y+',...
   X7,Tn7r2,'b-',X7,Tn7r2,'b+');
hold on;

for N=2:1:9
 
 Zo=50;                 
 Zld=100;
 if Zo<Zld
    Tsgn=1;
 else
    Tsgn=-1;
 end
    
 Tld=abs((Zld-Zo)/(Zld+Zo));

 x1=Tld;
 y1=Tld;
 x2=N;
 y2=Tld/(N+2);

 m=(y2-y1)/(x2-x1)*1.00;
 c=y1-m*x1;

 for x=1:N
  if N<=4
     Y(1,x)=m*x+c;
  end
  
  if N>=5 & N<=7
     Y(1,x)=cos((2*x+5-N)*pi/12)*(Tld/2)*0.96+(Tld/2); 
  end
  
  if N>=8
     Y(1,x)=cos((x-1)*pi/(N-1))*(Tld/2)*0.96+(Tld/2);
  end
  
    T(1,x)=Y(1,x);
    Z(1,x)=(1+T(1,x))/(1-T(1,x))*Zo;
    X(1,x)=x;
 end
 X=[Tld,X];
 T=[Tld,T]*Tsgn;
 plot(X,T,'k:',X,T,'kx');
end
hold off;
%axis([0,10,0,0.5]);
xlabel('Linear X-axis');
ylabel('Reflection Coefficient');
title('N-section Transformer Reflection Coefficient (Zo=50 ZL=100)');