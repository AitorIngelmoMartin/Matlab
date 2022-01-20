% Broadband match example1. Chebyshev transformer
% Load=Zload Ohm
% Line=50 Ohm
% Number of sections N
%
% Transformer lengths = lambda/4
% Fo=1000 Mhz
% Plot 1 to 4000 MHz
% clc;
% close all;

Zload=75;  % Load impedance, to matched (Ohms)
Zo=50;      % Characteristic impedance to match to (Ohms)
Fo=1000;    % Centre frequency (MHz)
F1=1;       % Start frequency for response plot (MHz)
F2=4000;    % Stop frequency for response plot (MHz) 
Tlen=0.25;  % Transformer length as a fraction of wavelength
N=5;        % Number of transformer sections 

Er=3.48;    % Dielectric constant for microstrip
d=1.52;     % Thickness of substrate (mm)


Zlist=bmatch(Zo,Zload,N);                % Calculate the transformer impedances
bplot(Zlist,Tlen,Fo,F1,F2);              % Plot the input response of the transformer
axis([0 F2 -50 0]);
filename=[pwd '\match_wxb1.dxf']; %setfname;                       % Assign full filepath for .dxf output
bphysical(Zlist,Tlen,Fo,Er,d,filename);  % Output microstrip layout as .dxf



