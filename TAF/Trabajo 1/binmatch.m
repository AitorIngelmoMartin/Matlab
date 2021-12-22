function Zlist=binmatch(Zo,Zload,N)
% Calculates a Binomial multi-section impedance matching transformer
% of unit length 
% 
% Zlist=binmatch(Zo,Zload,N)
%
% Zo......Characteristic impedance (Ohms)
% Zload...Load impedance to match to (Ohms)
% N.......Number of sections in transformer (integer)
%
%
% e.g.  Zlist=binmatch(50,100,4)   % Match a 100ohm load to a 50ohm line
%                                  % using a 4-section transformer. 
%
% Matches a load impedance Zload to a standard line impedance Zo
% using N transformers. The transformers are calculated using a 
% Binomial distribution that gives a maximally flat response.
%
%            (1/4) Wave Matching Sections
% Zo --->    [ Z1 ] [ Z2 ] ....    [ ZN ]   <-- Zload
%
% Ref D.M Pozar Microwave Engineering 2nd Ed Page 278

% N.Tucker www.activefrance.com 2010


Zn=zeros(1,N+1);
for n=0:1:N
 CnN=prod(1:N)./(prod(1:(N-n)).*prod(1:n));
 if n==0
   LnZn=log(Zo)+(2.^(-N)).*CnN.*log(Zload/Zo);
 else
   LnZn=log(Zn(1,n))+(2.^(-N)).*CnN.*log(Zload/Zo);
end
 Zn(1,n+1)=exp(LnZn);
end

Z=Zn(1,1:N);
Zlist=[Zo,Z,Zload];       % Vector of transformer impedances

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

X=1:1:N;
figure();
plot(X,Z,'b-',X,Z,'+');
xlabel('Zo     Matching Section Number    Zload');
ylabel('Impedance (Ohms)');
title('Transformer Impedances')
grid on;

chartname=sprintf(' Transformer Impedances ');
%set(10,'name',chartname);