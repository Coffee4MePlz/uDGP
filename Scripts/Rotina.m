function X = Rotina (Points, Dist0)
  BuildRepos = [];
%escolhas arbitrarias 4 pontos e 6 distâncias
%  disp("6 pontos, 15 distancias")
%lista de distancias escolhida
tic
  % PENTAGRAMA
 %Dist=[1, 1, sqrt(2),1, sqrt(2),1, 1,1, sqrt(2+sqrt(3)), sqrt(2+sqrt(3))];
  
 % disp(Dist')
 % n=10;
 % p=5;
   
 
  % PIPA E TRAPEZIO
 % Dist = [4,2,sqrt(2),sqrt(2), sqrt(10), sqrt(10)]
 
 %HEXAGONO
 %Points = [  0,  0.5, -0.5,  0.5, -0.5,  0;  0,  sqrt(3)/2 , sqrt(3)/2,  (sqrt(3)/2+1),  (sqrt(3)/2 +1),  (sqrt(3) +1) ]
 
  
  
  %PENTAGRAMA ESTENDIDO
  %Points = [0 0 0.5 (1+sqrt(15)/2) 1 1; 0 1 (1+sqrt(3)/2) 0.5 0 1]
  
  disp("First input must be 0 or a 2xn Matrix, or second a 1xn vector. ")
  Points
  [Dist] = DistFinder(Points);
  disp("Distancias Disponiveis");
  Dist'
  
  if (Points==0)
    Dist=Dist0
  end
  
  [pl, p] = size(Points);
  [m,n] = size(Dist);
  Adj = [];
  if (Dist==0)
    disp("no inputs given")     
  else
    p = round(1/2 + sqrt(1+8*n)/2)
  end
  p;
  n
  tic
  [L, BuildRepos] = DistCoreArranjo(1,n,p,3,[1,2,3], [],Dist, BuildRepos,Adj);

 % BuildRepos
  toc
end
