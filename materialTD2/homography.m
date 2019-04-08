

function [ H ] = homography( X1, X2 )  

n = size(X1, 2);

A = [];
% A = zeros(2*n, 9);
for i = 1 : size(X1, 2)
    x1 = X1(:, i)';
    x2 = X2(:, i)';
    % Compute decomposed cross product between matching points
    Ai = [ 0   0   0  -x2(3).*x1   x2(2).*x1 ; ...
           x2(3).*x1   0  0  0    -x2(1).*x1 ; ...
          -x2(2).*x1   x2(1).*x1    0  0  0  ];
    % Remove lalst row (only two equations needed)
%     Ai(3) = [];
    % Add to A matrix
    A = [ A;  Ai ];
end
-x2(3).*x1 
size(Ai)
% size(A)

[U,D,V] = svd(A);

H = [V(1:3,9)'; V(4:6,9)'; V(7:9,9)'];

