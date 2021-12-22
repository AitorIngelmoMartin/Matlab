function Zlist=bexp(Zo,Zload,N)
% Calculate impedance list for a Exponential taper 
% of unit length. 
% 
% Zlist=bexp(Zo,Zload,N)
%
% Zo......Characteristic impedance (Ohms)
% Zload...Load impedance to match to (Ohms)
% N.......Number of sections used to approximate taper (integer)
%
% e.g.  Zlist=bexp(50,100,60)      % Match a 100ohm load to a 50ohm line
%                                  % Taper defined as list of 60 sections  
%
% Note : Only valid for Zload>Zo
%
% Matches a load impedance Zload to a standard line impedance Zo
% using Klopfenstein taper. 
% Taper profile is returned as a list of impedances.
%
%            Impedance Values
% Zo --->    [ Z1 ] [ Z2 ] ....    [ ZN ]   <-- Zload
%
% Ref D.M Pozar Microwave Engineering 2nd Ed Page 291

% N.Tucker www.activefrance.com 2010


a=log(Zload/Zo);                  % Exponential factor

z=0;                              % Fractional distance along taper
dz=1/(N-1);                       % Incremental distance

Zx=zeros(1,N);
for c=1:N                         % Loop for impedance values along taper
 Zx(1,c)=Zo.*exp(a.*z);
 z=z+dz;
end


Zlist=[Zo,Zx,Zload];              % Assemble the list of impedances for output
X=1:1:N;                          % X-axis vector for plotting

figure(10);
plot(X,(Zx),'b-',X,(Zx),'+');
xlabel('Zo     Matching Section Number    Zload');
ylabel('Impedance (Ohms)');
title('Transformer Impedances')
grid on;

chartname=sprintf(' Transformer Impedances ');
set(10,'name',chartname);