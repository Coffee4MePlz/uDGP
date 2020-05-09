function X = DistcoreComb2 (k, n, s, l, L,Dist)
Dist;
  % k = posição nas entradas ; n=n0 de distancias; s= combinações ; l = resposta;
  
  if (k>s)
    X=l';
    Dist1 = [];
    Distu = [];
% define distancias usadas
    for i=1:3
    Dist1 = [Dist1, Dist(X(i,1))];
    end
% monta o primeiro core  
    Dist1;
    [Core,flag] = BuildCore(Dist1, 3);
    Core;
    if (flag == 1) 
  % disp("Distancias incompativeis \n ---------------------");
    return
    end

%Nova Distancia // Novo atomo
      Dist2=Dist ;
      for i=1:3
      Dist2(: , X(4-i,1))=[];
      end 
    Novacomb = DistCombNewAtom(1, 3 , 3, [1,2,3],[], Dist1, Dist2, Core);
    

   return
      
  end
  if k==1
      m=1;
    else
      m=l(k-1) +1;
    end
  for (i=m:n-(s-k))    
    l(k)=i;
    L = DistcoreComb2(k+1,n,s,l, L, Dist);
  end
  X=L;
 
end
