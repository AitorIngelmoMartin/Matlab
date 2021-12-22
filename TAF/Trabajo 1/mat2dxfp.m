function mat2dxfp(Xp,Yp,Zp,pcolour,layername,filename);
% Converts vertex coordinate list into polygons
% in AutoCad DXF format. 
%
% Usage : mat2dxfp(Xp,Yp,Zp,pcolour,layername,filename)
%
% Xp,Yp,Zp...Vectors of polygon vertices Xp(1,n) Yp(1,n) Zp(1,n)
% pcolour....Line colour  (integer)
% layername..Name of drawing layer (string)
% filename...Full filename path (string)
%
% e.g. mat2dxfp(Xp,Yp,Zp,5,'MYPOLY','C:\CAD\mypoly.dxf')
%
% For single poly Xp=[x1,x2,x3,...xn]
%                 Yp=[y1,y2,y3,...yn]
%                 Zp=[z1,z2,z3,...zn]
%
% For multiple polys Xp=[xa1,xa2,xa3,...xan,-1e6,xb1,xb2,xb3,...xbn]
%                    Yp=[ya1,ya2,ya3,...yan,-1e6,yb1,yb2,yb3,...ybn]
%                    Zp=[za1,za2,za3,...zan,-1e6,zb1,zb2,zb3,...zbn]
%    
% The value -1e6 is used to delimit vertex lists. By using a large negative
% number, polygons can be duplicated (move-copy) without worrying about losing
% the delimiter. (Delimiter value is compared to -0.5e6 so move-copies can be 
% up to 0.5e6 in magnitude). See dxftest1 and dxftest2 in the examples section.
%
% Note : Remember to close polygons i.e. a box requires 5 points, the
%        first point is repeated at the end of the list. 
%
% DXF colour assignments : 1=red,2=yellow,3=green,4=cyan,5=blue,6=magenta

[Row,Col]=size(Xp);
N=Col;

filename
fid=fopen(filename,'W');


x=0;
x1=0;

Xc=0;
Yc=0;
Zc=0;

Delim=-0.5e-6;
DelimFlag=0;

% DXF ENTITIES HEADER
fprintf(fid,'0\n');
fprintf(fid,'SECTION\n');
fprintf(fid,'2\n');
fprintf(fid,'ENTITIES\n');
fprintf(fid,'0\n');

for c=1:N
  x=x+1;
  x1=x1+1;

  % DXF POLYGON HEADER
  if ((x<N) & (DelimFlag==1)) | c==1 
    fprintf(fid,'POLYLINE\n');
    fprintf(fid,'8\n');
    fprintf(fid,'%s\n',layername);
    fprintf(fid,'62\n');
    fprintf(fid,'%g\n',pcolour);          % Polygon Colour
    fprintf(fid,'5\n');
    fprintf(fid,'20\n');
    fprintf(fid,'66\n');
    fprintf(fid,'1\n');
    fprintf(fid,'10\n');
    fprintf(fid,'0.0\n'); 
    fprintf(fid,'20\n');
    fprintf(fid,'0.0\n'); 
    fprintf(fid,'30\n');
    fprintf(fid,'0.0\n'); 
    fprintf(fid,'70\n');
    fprintf(fid,'2\n');
    fprintf(fid,'0\n');
  end
  
  Xc=Xp(1,c);
  Yc=Yp(1,c);
  Zc=Zp(1,c);
  
  if (Xc<=Delim & Yc<=Delim & Zc<=Delim)
     DelimFlag=1;
  else
     DelimFlag=0;
  end   
  
  % DXF POLYGON VERTEX OUTPUT
  if ((DelimFlag~=1) & (x<=N))
    fprintf(fid,'VERTEX\n');
    fprintf(fid,'8\n');
    fprintf(fid,'%s\n',layername); % Layername
    fprintf(fid,'62\n');
    fprintf(fid,'3\n');
    fprintf(fid,'5\n');
    fprintf(fid,'%g\n',20+x1);     % DXF command index
    fprintf(fid,'10\n');
    fprintf(fid,'%g\n',Xp(1,x));   % X coord of vertex (x)
    fprintf(fid,'20\n');
    fprintf(fid,'%g\n',Yp(1,x));   % Y coord of vertex (x)
    fprintf(fid,'30\n');
    fprintf(fid,'%g\n',Zp(1,x));   % Z coord of vertex (x)
    fprintf(fid,'0\n');
  end

  % DXF POLYGON FINISH
  if (DelimFlag==1) | (x==N)
   fprintf(fid,'SEQEND\n');
   fprintf(fid,'8\n');
   fprintf(fid,'0\n');
   fprintf(fid,'5\n');
   fprintf(fid,'%g\n',20+x1+1);    % DXF command index
   fprintf(fid,'0\n');
  end

end

% DXF ENTITIES FINISH
fprintf(fid,'ENDSEC\n');
fprintf(fid,'0\n');
fprintf(fid,'EOF\n');

fclose(fid);




