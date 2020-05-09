
function [l2, BuildRepos] = ShuffleNewPoint (L,flag,p, Dist2, Core, BuildRepos);
 L2=L; 
 
  %primeira roda [1,2,3] para [3,2,1]
    for k=1:3
     if k==1
       l2(k) = L(3);
     else
       l2(k)=L(k-1);
     end
    end
   L=l2;
   l2;
   
  %Novo ponto e checagem se não é repetido
  [Build, BuildRepos] =  Newpoint ( Dist2,p, Core, l2', BuildRepos);
  %Build;
 % BuildRepos = CheckBuild (Build, BuildRepos1);
  %BuildRepos;

  
  
   
 %novas rodadas  
   while l2!=L2;
   l2;
   
   for k=1:3
     if k==1
       l2(k) = L(3);
     else
       l2(k)=L(k-1);
     end
   end
  l2;
  L=l2;
  
  %Novo ponto e checagem se não é repetido
  [Build, BuildRepos] =  Newpoint ( Dist2,p, Core, l2', BuildRepos);
  %Build;
  %BuildRepos = CheckBuild (Build, BuildRepos1);
  %BuildRepos;
  
   
 %troca de 2 com 3 , [1,2,3] vira [1,3,2]
 if flag==0
  if l2==L2
     l2(3)=L(2);
     l2(2) = L(3);
     l2;
  end
 end
 %Novo ponto e checagem se não é repetido
   [Build, BuildRepos] =  Newpoint ( Dist2,p, Core, l2', BuildRepos);
  %Build;
 % BuildRepos = CheckBuild (Build, BuildRepos1);
  %BuildRepos;
 
 
 
end
