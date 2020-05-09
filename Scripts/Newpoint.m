function [Build, BuildRepos] = Newpoint (Dist2,p, Core, L, BuildRepos)
  %Dist1 = distancias do core, Core = os pontos do Core atual, 
  %Dist2 = distancias sobrando, L= combinacao atual
  e = 0.0000001;
  Distu=[];
  Build = [];
  Dist3 = Dist2;
%define pelas entradas os valores das distâncias no sistema linear  
L2= sort(L);
for i=1:3
  Distu = [Distu, Dist2(: , L(i,1))];
  Dist3(: , L2(4-i,1)) =[];
  
end
  
d14= Distu(1,1);
d24= Distu(1,2);
d34= Distu(1,3);
  
  %definicao das variaveis
  x4=[];
  x1 = Core(:,1); x2 = Core(:,2); x3 = Core(:,3);
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
  Build = [x1,x2,x3,x4]; % IMPRESSÃO PARA 4 PONTOS

  
  if abs(k)>e
 % disp ("distancias incompativeis");
    Build = [0];
   return 
  else
  %disp ("FOUND:");
  %Build;
  p=p-1;
  if (p>0)
    fwd = 1;
    [L, Build, BuildRepos] = DistCombNewAtom (1, 4 ,p, 3, [1,2,3],[], Dist3, Build, BuildRepos, fwd, [], Build ,0);
  else 
    Build
    return
  end
  
  

  end
  
  

%  X= [x1,x2,x3,x4];
 return
end
