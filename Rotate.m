
function Mrot = Rotate(M,ang)
A=[];
Rot = [  sin(ang),  cos(ang); cos(ang), -sin(ang)];
[i,j] = size(M);

    for k=1:j
    A(:,k) = Rot*M(:,k);
  
  end
  
Mrot = A;
end
