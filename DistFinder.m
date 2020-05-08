function [Dist] = DistFinder(Points)
Dist=[];

[n,m] = size(Points);

if(m == 0)
 return
end

x1 = Points(:,1);

for (i=2:m)
  xi = Points(:, i);
  d = norm(x1-xi);
  Dist = [Dist, d];
end
 Points(:,1) = [];

 Dist1 = DistFinder(Points);
 
Dist = [Dist, Dist1];
end
