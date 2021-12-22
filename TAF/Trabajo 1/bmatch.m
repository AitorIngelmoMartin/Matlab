function Zlist=bmatch(Zo,Zload,N)
% Calculates a broadband multi-section impedance matching transformer
% of unit length, using a graphically based Chebyshev approximation.
%
% Limitations : Gives a reflection coefficient of around 0.1 (-20dB) 
%               or better, for arbitrary impedance ratios up to 4:1
% 
% Zlist=bmatch(Zo,Zload,N)
%
% Zo......Characteristic impedance (Ohms)
% Zload...Load impedance to match to (Ohms)
% N.......Number of sections in transformer (integer)
%
%
% e.g.  Zlist=bmatch(50,100,4)   % Match a 100ohm load to a 50ohm line
%                                % using a 4-section transformer. 
%
% Matches a load impedance Zload to a standard line impedance Zo
% using N transformers. The transformers are calculated using a 
% graphical interpolation method that gives a Chebychev type response.
%
%            (1/4) Wave Matching Sections
% Zo --->    [ Z1 ] [ Z2 ] ....    [ ZN ]   <-- Zload
%


% N.Tucker www.activefrance.com 2010

 if Zo<Zload
    Tsgn=1;
 else
    Tsgn=-1;
 end
Tld=abs((Zload-Zo)/(Zload+Zo));    % Calculated reflection coefficient at load

x1=Tld;                            % 1st point on graph is [Tld,Tld]
y1=Tld;

x2=N;                              % 2nd point on graph is [N,Tld/(N+1)]
y2=Tld/(N+2);

m=(y2-y1)/(x2-x1)*1.00;            % Calculate gradient m
c=y1-m*x1;                         % Calculate offset c

for x=1:N                          % Interpolate the reflection coeffs and calculate
                                   % the corresponding impedance values.
                       
  if N<=4
     Y(1,x)=m*x+c;
  end
  
  if N>=5 & N<=7
     Y(1,x)=cos((2*x+5-N)*pi/12)*(Tld/2)*0.96+(Tld/2); 
  end
  
  if N>=8
     Y(1,x)=cos((x-1)*pi/(N-1))*(Tld/2)*0.96+(Tld/2);
  end         
                              
   T(1,x)=Y(1,x)*Tsgn;                  
   Z(1,x)=(1+T(1,x))/(1-T(1,x))*Zo;
   X(1,x)=x;                  % X-axis vector for plotting if required
end   

Zlist=[Zload,Z(1,:),Zo];      % Vector of transformer impedances
Zlist=fliplr(Zlist);          % Reverse order so that Zload is on the right.

% Print the design to command screen for designs upto 10 sections
if N<11
fprintf('\n\n     Matching Transformer Design (Ohms)\n');
fprintf('     ==================================\n\n');
fprintf('     Zo');

  for x=1:N
     fprintf('        Z%i',x);
  end
  fprintf('        Zload\n');

  for x=1:(N+2)
     fprintf('%10.2f',Zlist(1,x));
  end
end  
fprintf('\n\n');

figure();
plot(X,fliplr(Z),'b-',X,fliplr(Z),'+');
xlabel('Zo     Matching Section Number    Zload');
ylabel('Impedance (Ohms)');
title('Transformer Impedances')
grid on;

chartname=sprintf(' Transformer Impedances ');
%set(10,'name',chartname);