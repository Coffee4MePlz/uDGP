
function [BuildRepos] = CheckBuild (Build, BuildRepos)
[n,m] = size (BuildRepos);
e = 0.000000001;
flag =0;

 if (Build == [0])
   return
 end
 if (size(Build) == [0 0])
   return
 end
 
 if (n==0)
   BuildRepos = Build;
   return
 end
 
B = BuildRepos;

[nB,mB] = size (B);
[nA,mA] = size(Build);

if (nA>nB-1 && nA>2)
  BuildRepos = Build;
  return
end

i=1; j=1;
    while (i<nB)
      A = B((i:(i+1)), (1:(mA))) ;      
      if (norm(A-Build)<e)
        BuildRepos = B;
        return
      end
      i= i+2;
    end

    BuildRepos = [BuildRepos; Build];
   
return

end
