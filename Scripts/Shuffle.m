
function [l2] = Shuffle (L,flag,l2, Dist1, Dist2, Core, l3);
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
   l2
 
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
  l2
  L=l2;
   
   %troca de 2 com 3 , [1,2,3] vira [1,3,2]
 if flag==0
 if l2==L2
     l2(3)=L(2);
     l2(2) = L(3);
     l2
 end
 end
 
 
 
end
