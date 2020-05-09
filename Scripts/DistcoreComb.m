

function [] = DistcoreComb (k, n, s, l)
  
  % k = posição nas entradas ; n=n0 de pontos ; s= combinações ; l = resposta;
  
  if (k>s)
    %L = [L;l]
    disp(l);
    return
    endif
  if k==1
      m=1;
    else
      m=l(k-1) +1;
    endif
  for (i=m:n-(s-k))    
    l(k)=i;
    DistcoreComb(k+1,n,s,l)
  endfor

endfunction
