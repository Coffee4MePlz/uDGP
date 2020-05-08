function [X,flag] = BuildCore (Dist1, n)
%define pelas entradas os valores das distâncias no sistema linear  
d12= Dist1(1,1);
d13= Dist1(1,2);
d23= Dist1(1,3);

%teste de compatibilidade (desigualdade triangular)
B = sort(Dist1);

  if (B(1,3) > B(1,2) + B(1,1))
  X=[];
  flag =1;
  return
  else flag =0;
  end

%escolha arbitraria dos dois primeiros pontos
x1=[0,0]';
x2=[d12,0]';

%calculo das entradas do terceiro pontos
x31=(d13^2+d12^2-d23^2)/(2*d12);
x32=sqrt(d13^2 - x31^2);
x3=[x31,x32]';

%Define resposta como uma matriz com cada coluna um ponto
X=[x1,x2,x3];
%disp("X = [x1,x2,x3]");

end
