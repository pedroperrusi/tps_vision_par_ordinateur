function [R,t] = computeRTfromH(H,K)
% Compute R,t from H (take care of scale..)
% P is the projection matrix

kH = inv(K)*H;
sc = [norm(kH(:,1))]; %;norm(kH(:,2))]);
kH = kH / sc; 

R1 = kH(:,1); 
R1 = R1/ norm(R1);

R2 = kH(:,2)-dot(kH(:,2),R1)*R1;
R2 = R2 / norm(R2);

R3 = cross(R1,R2);

R = [R1 R2 R3]
t = kH(:,3)

end

