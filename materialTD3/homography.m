function [ H ] = homography( X1, X2 )  
%Compute homography H
%X1 are X2 are correspondences

A = [] ;
for i=1:size(X1,2)
        A(2*(i-1)+1,1:3) =  [0 0 0];
        A(2*(i-1)+1,4:6) = -X2(3,i)*X1(:,i);
        A(2*(i-1)+1,7:9) =  X2(2,i)*X1(:,i);
  
        A(2*(i-1)+2,1:3) =  X2(3,i)*X1(:,i);
        A(2*(i-1)+2,4:6) =  [0 0 0];
        A(2*(i-1)+2,7:9) = -X2(1,i)*X1(:,i);
end


[U,D,V] = svd(A);

H = [V(1:3,9)'; V(4:6,9)'; V(7:9,9)'];
H = H/H(3,3);

