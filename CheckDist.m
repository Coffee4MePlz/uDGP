function [flag,Dist3,Adj] = CheckDist (x4, NotCore, Dist3,Adj)
 %Funcao que checa se algumas das distancias sobrando encaixam nos pontos já fixos
 % x4 = ponto novo; %NotCore = Pontos fora do Core = Core - Coreu (em Newpoint2)
 %Dist3 = Distancias disponiveis
  Adj =[];

e= 0.0000001;
[nC,mC] = size(NotCore);
[nD,mD] = size(Dist3);
  if (mC ==0 || mD==0)
    flag=1;
  else
    for (i=1:mC)
        for (j=1:mD)
          %k= abs(norm(x4 - NotCore(:,i)) - Dist3(1,j));
          k1= norm(x4 - NotCore(:,i));
          D = Dist3(1,j);
          k = abs(k1-D);
          if (k<e)
            flag =1;
            NotCore(:,i) = [];
            Dist3(j)=[];
            [flag,Dist3] = CheckDist (x4, NotCore,Dist3);
            return
           else
            flag =0;
            %return
          end
        end
        return %novo
    end
  end

end
