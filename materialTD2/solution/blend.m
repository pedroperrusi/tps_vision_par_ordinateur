function K = blend(I1,I2,H)
% Blend 2 images I1 and I2. Homography H warps image I1 into I2
%corners of the image
corners2 = [1  size(I2,2) size(I2,2)  1 ;
        1  1           size(I2,1)  size(I2,1) ;
        1  1           1            1 ] ;
    
warped_corners2 = inv(H) * corners2 ;
warped_corners2(1,:) = warped_corners2(1,:) ./ warped_corners2(3,:) ;
warped_corners2(2,:) = warped_corners2(2,:) ./ warped_corners2(3,:) ;

xrange = min([1 warped_corners2(1,:)]):max([size(I1,2) warped_corners2(1,:)]) ;
yrange = min([1 warped_corners2(2,:)]):max([size(I1,1) warped_corners2(2,:)]) ;

[MX,MY] = meshgrid(xrange,yrange);
x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

II = double(I2);
C(:,:,1) = interp2(II(:,:,1),x./z,y./z,'cubic'); 
C(:,:,2) = interp2(II(:,:,2),x./z,y./z,'cubic'); 
C(:,:,3) = interp2(II(:,:,3),x./z,y./z,'cubic'); 
%first image
II = double(I1);
D(:,:,1) = interp2(II(:,:,1),MX,MY,'cubic'); 
D(:,:,2) = interp2(II(:,:,2),MX,MY,'cubic'); 
D(:,:,3) = interp2(II(:,:,3),MX,MY,'cubic'); 
%size(C)
%size(D)
w = ~isnan(C) +  ~isnan(D);
C(isnan(C)) = 0;
D(isnan(D)) = 0;
K=uint8((C+D)./w);

return



























