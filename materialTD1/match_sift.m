function [m1,m2] = match_sift(P1,P2,D1,D2)

th = 10;
C = [];
l1 = size(D1,2);
l2 = size(D2,2);

for i = 1 : l1
   for j = 1 : l2
      x = D1(:,i);
      y = D1(:,j);
      
      d = sqrt(sum((x-y).^2));
      
      C(i,j) = d;
   end
end

[~, kx] = min(C, [], 2)
[~, ky] = min(C, [], 1)

m1 = [];
m2 = [];

for i = 1 : l1
   if ky(kx(i)) == i
       m1 = [m1 [P1(:, i)]];
       m2 = [m2 [P2(:, kx(i))]];
   end
end

%     m1 = zeros(1, size(P1, 2));
%     diff1 = 100000 * ones(size(P1, 2)); % arbitrary large value
%     m2 = zeros(1, size(P2, 2));
%     diff2 = 100000 * ones(size(P1, 2)); % arbitrary large value
%     iterates over each pair of keypoints and compare their histograms
%     for i = 1 : size(P1, 2)
%         for j = 1 : size(P2, 2)
%             compute the squared norm of each descriptor / histogram 
%             diffD = sqrt(sum((D1(:, i) - D2(:, j)).^2));
%             if(diffD < diff1(i))
%                 m1(i) = j;
%             end
%             if(diffD < diff2(j))
%                m2(j) = i; 
%             end
%         end
%     end
%     iterates over m1 and m2 and keep only symetrical relations
%     for i = 1 : size(m1)
%         if(m1(i) ~= m2(m1(i)) && m1(i) ~= 0)
%            m1(i) = 0; 
%         end
%     end
%     for j = 1 : size(m2)
%         if(m2(j) ~= m1(m2(j)) && m2(j) ~= 0)
%            m2(j) = 0; 
%         end
%     end
end