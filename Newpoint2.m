function [Build, BuildRepos] = Newpoint2 (Dist2,p, Core, L3, L, BuildRepos)

  %Dist1 = distancias da build, Core = os pontos do Core atual, 
  %Dist2 = distancias sobrando, 
  %FAZER ESSA TROCA!!!! trocar L3 com L, pois no resto está trocado
  %L= combinacao atual de distancias
  %L3 = combinacao de pontos
  e = 0.00001;
  Distu=[]; 
  Coreu =[];
  Build = [];
  Dist3 = Dist2;
%define pelas entradas os valores das distâncias no sistema linear  
L2= sort(L);
for i=1:3
  Distu = [Distu, Dist2(: , L(i,1))];
  Dist3(: , L2(4-i,1)) =[];
end
% ESCOLHER COM L3 OS PONTOS EM CORE 
% TAMBÉM DEFINE, PARA CHECAGEM POSTERIOR, OS PONTOS NÃO UTILIZADOS
L32 = sort(L3);
NotCore = Core;
for i=1:3
  Coreu = [Coreu, Core(: , L3(i,1))];
  NotCore (: , L32(4-i,1)) = [];
end
  
d14= Distu(1,1);
d24= Distu(1,2);
d34= Distu(1,3);
  
  %definicao das variaveis
  x4=[];
  x1 = Coreu(:,1); x2 = Coreu(:,2); x3 = Coreu(:,3);
  A = [(x2 -x1)'; (x3 - x1)'];
  b1 = (1/2)*(d14^2 -d24^2 + x2'*x2 - x1'*x1);
  b2 = (1/2)*(d14^2 - d34^2 + x3'*x3 - x1'*x1);
  b = [b1,b2]';
%calculo do sistema linear  
  d = det(A);
  
    if d<e
 %     disp ("distancias incompativeis");
    Build = [0];
      return
   end
  x4 = A\b;
  k = (norm(x4-x1)^2 - d14^2);
  Build = [Core,x4];

  
  if abs(k)>e
 % disp ("distancias incompativeis");
    Build = [0];
   return 
  else
  %TESTE DAS DISTANCIAS REMANESCENTES
  %[flag,Dist3,Adj] = CheckDist(x4, NotCore, Dist3,Adj);   
   [flag,Dist3,Adj] = CheckDist(x4, NotCore, Dist3);   
  %Build
  if (flag==1)
      %disp ("FOUND:");
      Build
      p=p-1;
      [nD,mD] = size(Dist3);      
      if (mD>2)
        fwd = 1;
        [nD,mD] = size(Dist3);    
       


       [L, BuildRepos] = DistCombNewAtom (1, mD ,p, 3, [1,2,3],[], Dist3, Core, BuildRepos, fwd, [], Build ,0);
      else 
        %BuildRepos = CheckBuild (Build, BuildRepos);
        
        Build
        
%+++++++++++++++++++++++++
       %FUNCAO PARA PLOTAR 
       
       % PES = PlotESave(Build);    
%++++++++++++++++++++++++++        
        toc
        
        %D=DistFinder(Build);
        %D'
        return
      end
  else
   Build = [0];
   return   
  end
  
  

  end
  
  

%  X= [x1,x2,x3,x4];
 return
end
