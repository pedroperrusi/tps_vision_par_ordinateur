function [m1,m2] = match_sift(P1,P2,D1,D2)
    m1 = zeros(1, size(P1, 2));
    diff1 = 10000 * ones(size(P1, 2)); % arbitrary large value
    m2 = zeros(1, size(P2, 2));
    diff2 = 10000 * ones(size(P1, 2)); % arbitrary large value
    for i = 1 : size(P1, 2)
        for j = 1 : size(P2, 2)
            % compute the squared norm of each descriptor / histogram 
            diffD = sum((D1(:, i) - D2(:, j)).*(D1(:, i) - D2(:, j)));
            if(diffD < diff1(i))
                m1(i) = j;
            end
            if(diffD < diff2(j))
               m2(j) = i; 
            end
        end
    end
end