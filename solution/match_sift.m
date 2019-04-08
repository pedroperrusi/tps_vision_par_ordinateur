function [m1,m2] = match_sift(P1,P2,D1,D2)
th = 10;
C=[];
l1 = size(D1,2);
l2 = size(D2,2);
for i = 1 : l1  
  for j = 1 : l2

    x = D1(:,i);
    y = D2(:,j);
    
    d = sqrt(sum((x-y).^2));
   
    C(i,j) = d;    %similarity between point i in first image and point j in second image
  end
end

%look for the maximum of the correlation
[val,kx] = min(C,[],2);
[val,ky] = min(C,[],1);


m1=[];m2=[];
for i = 1 : size(D1,2)
  if ky(kx(i)) == i    %%for the symmetry!
    m1=[m1 [P1(:,i)]];
    m2=[m2 [P2(:,kx(i))]];
  end
end


