function bdraw(Zlist,L,Fo,F1,F2,linetype);
% Plots the performance of the N-section impedance transformer
% as calculated by the function bmatch.m, binmatch.m or bklop.m
%
% Usage : bdraw(Zlist,L,Fo,F1,F2,linetype)
%
%
% Zlist.....Impedance list returned by bmatch (Ohms)
% L.........Length of transformer sections in wavelengths
% Fo........Centre frequency in (MHz)
% F1........Minimum frequency to plot (MHz)
% F2........Maximum frequency to plot (MHz)
%
% e.g.  Zlist=bexp(50,150,100)              % Calc Exp tapered match for a 150ohm to 50ohm (N=100)
%       Zlist1=bklop(50,150,100,-30)        % Calc Klop tapered match for a 150ohm to 50ohm (N=100)
%       bplot(Zlist,0.01,1000,1,2000)       % Plot Zlist results for fo=1000MHz over 1-2000MHz
%       bdraw(Zlist1,0.01,1000,1,2000,'g-') % Add Zlist1 reultsusing for fo=1000MHz over 1-2000MHz

Zlist=fliplr(Zlist);     % Reverse order of Zlist for the analysis
[Row,Col]=size(Zlist);   % Get the dimensions of the impedance transformer vector
N=Col-2;                 % Number of transformer sections

Zload=Zlist(1,1);        % 1st value is Zload
Zo=Zlist(1,Col);         % Last value is Zo
Lambda=3e8/(Fo*1e6)*1e3; % Lambda free space (mm)
Len=Lambda*L;            % Length of 1/4 wave section (mm)
Er=1.0;                  % Dielectric constant
LdB=0;                   % Loss in dB/m

Npts=201;                % Number of points for the plot
Step=(F2-F1)/(Npts-1);   % Step value
Freq=F1:Step:F2;         % Set up the frequency vector    
ZL=term(Zload,Freq);     % Vectorise Zload for all frequencies

Z(1,:)=ZL;               % Impedance vector at load 
for x=1:N
   Z(x+1,:)=trl(Zlist(1,(x+1)),Z(x,:),Len,Freq,Er,LdB);
end
Zin=Z((N+1),:);

figure(1);
hold on;
smdrawc(Zin,Zo,linetype);

figure(5);
hold on   
rldrawc(Zin,Freq,Zo,linetype);


