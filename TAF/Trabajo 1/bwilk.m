function [Ztran,Risol]=bwilk(N,Zo,Fo)
% Multi Section Wilkinson Divider 
% 
% [Ztran,Risol]=bwilk(N,Zo,Fo)
%
% N.......Number of sections used for the splitter (integer)
% Zo......Characteristic impedance (Ohms)
% Fo......Centre frequency for splitter (MHz)
%
% Ztran...List of transformer impedances, same for each arm (Ohms)
% Risol...List of isolation resistors (Ohms)
%
% e.g.  [Ztran,Risol]=bwilk(4,50,1000)   % 4-section Wilkinson divider
%                                        % to operate in a 50 ohm system,
%                                        % centred at 1000 MHz.
%
% Matches a load impedance Zload to a standard line impedance Zo
% using N 1/4-wave transformers. The transformers are calculated 
% using a graphical interpolation method that gives a Chebychev 
% type response. See bmatch for notes on limitations.
%
%            (1/4) Wave Matching Sections
%
%            [ Z1 ] [ Z2 ] ....    [ ZN ]   <-- Zo
%         /        |      |              |
% Zo --->         R1     R2             RN
%         \        |      |              |
%            [ Z1 ] [ Z2 ] ....    [ ZN ]   <-- Zo
%

% N.Tucker www.activefrance.com 2010

Zlist=bmatch(Zo,2*Zo,N); % N section match forms arms of splitter


Zlist=fliplr(Zlist);     % Reverse order of Zlist for the analysis
[Row,Col]=size(Zlist);   % Get the dimensions of the impedance transformer vector
N=Col-2;                 % Number of transformer sections

Zload=0;                 % Zload is GND for the odd mode analysis
Zo=Zlist(1,Col);         % Last value is Zo
Lambda=3e8/(Fo*1e6)*1e3; % Lambda free space (mm)
L4=Lambda/4;             % Length of 1/4 wave section (mm)
Er=1.0;                  % Dielectric constant
LdB=0;                   % Loss in dB/m

Freq=Fo;                 % Centre frequency    
ZL=term(Zload,Freq);     % Vectorise Zload for all frequencies

Z(1,:)=ZL;               % Impedance vector at load 
for x=1:N
   Z(x+1,:)=trl(Zlist(1,(x+1)),Z(x,:),L4,Freq,Er,LdB);  % Cplx Impedance into Tfmr Z(x+1)
   Zx=abs(Z(x+1,:));                                    % Magnitude of impedance (nominally real)
   R(1,x)=(Zo*Zx)/(Zx-Zo);                              % Calc isolation resistor
   Z(x+1,:)=Zo;                                         % Junction impedance should be Zo
end
Risol=R*2;
Ztran=Zlist(1,2:N+1);

% Print the design to command screen


fprintf('\n\n     Wilkinson Splitter Design (Ohms)\n');
fprintf('     ================================\n\n');
fprintf('    ');
for x=1:N;fprintf('        Z%i',x);end
fprintf('\n\n');

fprintf('     ');
for x=2:(N+1);fprintf('%10.2f',Zlist(1,x));end
fprintf('  <---Zo');
fprintf('\n      /       ');
for x=2:(N+1);fprintf('|         ');end
fprintf('\n  Zo   ');
for x=1:(N);fprintf('%10.2f',Risol(1,x));end
fprintf('\n      \\       ');
for x=2:(N+1);fprintf('|         ');end
fprintf('\n     ');
for x=2:(N+1);fprintf('%10.2f',Zlist(1,x));end
fprintf('  <---Zo');
fprintf('\n\nNote : In this case the Microstrip profile and associated\n');
fprintf('       DXF output has only the the transformer sections,\n');
fprintf('       there are no lead-in sections of Zo impedance.\n');

