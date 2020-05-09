function [X, BuildRepos, Build] = DistCombNewAtom (k, n, p, s, l, L, Dist2, Core, BuildRepos, fwd, L3, Build, flag)
%Dist=[1,1,1,1,sqrt(2),sqrt(2)];
  % k = posição nas entradas ; n=n0 de distancias; p = pontos; s= combinações ; 
  %l = resposta; fwd = sinal se roda primeira ou segunda rodada
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PRIMEIRA RODADA    
 if (fwd==0) 
  if (k>s)
    X=l';
   
   [S, BuildRepos] = ShuffleNewPoint (X',0, p, Dist2, Core, BuildRepos);   
   [S2, BuildRepos] = ShuffleNewPoint (S,1, p, Dist2, Core, BuildRepos);
   
   return
   end
  
  if k==1
      m=1;
    else
      m=l(k-1) +1;
    end
  for (i=m:n-(s-k))    
    l(k)=i;
    [L, BuildRepos] = DistCombNewAtom(k+1,n,p,s,l, L, Dist2, Core, BuildRepos,0);
  end
  X=L;
 
 end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SEGUNDA RODADA


 if (fwd==1)
  if (k>s)
    X=l';
   
   if (flag==0)
   [nB,mB] = size(Build);
   [L,BuildRepos] = DistCombNewAtom (1, mB ,p, 3, [1,2,3],[], Dist2, Core, BuildRepos, fwd, X, Build, 1);
   end
   
   if (flag==1)
   [S, BuildRepos] = ShuffleNewPoint2 (X', L3, 0, p, Dist2, Build, BuildRepos);   
   [S2, BuildRepos] = ShuffleNewPoint2 (S, L3, 1, p, Dist2, Build, BuildRepos);
   %  [Build] = Newpoint2(Dist2,p, Core, X, L3, BuildRepos);
   end
 
   return
   end
  
  if k==1
      m=1;
    else
      m=l(k-1) +1;
    end
  for (i=m:n-(s-k))    
    l(k)=i;
    [L, BuildRepos] = DistCombNewAtom(k+1,n,p,s,l, L, Dist2, Core, BuildRepos,1, L3, Build,flag);
  end
  X=L;
 end
 
 
end

