clear all; close all;


%% Load image

I1 = imread('tps1.jpg');

figure();imshow(I1);

%% Set transformation
theta = pi/4; 
R = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]; %Caution x and y axis in a Matlab image are inverted... not intuitive sometimes. 


%% Compute transformed image size

corners = [1  size(I1,1) size(I1,1)  1 ;
           1  1           size(I1,2)  size(I1,2) ;
           1  1           1            1 ] ;
    
warped_corners = R * corners;  %R transformation from unwarped to warped
warped_corners(1,:) = warped_corners(1,:) ./ warped_corners(3,:) ;
warped_corners(2,:) = warped_corners(2,:) ./ warped_corners(3,:) ;

xrange = min( warped_corners(1,:) ): max(warped_corners(1,:) ) ;
yrange = min( warped_corners(2,:) ): max(warped_corners(2,:) ) ;



%% Simple forward warping 

I2 = zeros(size(xrange,2), size(yrange,2),3);

for u=2:size(I1,1)-1   %TODO: check boundaries
    for v=2:size(I1,2)-1
        p = R *[u;v;1]; 

          I2(round(p(1)-xrange(1)),round(p(2)-yrange(1)),:) = I1(u, v,:);  %TODO: mix colors...
        
    end
end

figure();imshow(uint8(I2));


%% Backward warping using meshgrid

RR = inv(R);

[MX,MY] = meshgrid(xrange,yrange); 
MX=MX';
MY=MY';
x = (RR(1,1)*MX+RR(1,2)*MY+RR(1,3));
y = (RR(2,1)*MX+RR(2,2)*MY+RR(2,3));
z = (RR(3,1)*MX+RR(3,2)*MY+RR(3,3));

II = double(I1);
C(:,:,1) = interp2(II(:,:,1)', x./z,y./z,'cubic'); %coordinates of function Z as produced by meshgrid!!! => transpose
C(:,:,2) = interp2(II(:,:,2)', x./z,y./z,'cubic'); 
C(:,:,3) = interp2(II(:,:,3)', x./z,y./z,'cubic'); 


I2=uint8(C);
figure();imshow(I2);


%% Simple backward warping

I2 = zeros(size(xrange,2), size(yrange,2),3);
for u=1:size(I2,1)
    for v=1:size(I2,2)
        p = inv(R) * [xrange(u);yrange(v);1]; 
        if (p(1)>=1 && p(1)<= size(I1,1)) && (p(2)>=1 && p(2)<= size(I1,2))
          I2(u,v,:) = I1( round(p(1)) , round(p(2)) ,:);  %TODO: interpolate
        end
    end
end

figure();imshow(uint8(I2));










