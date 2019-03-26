clear all; close all;

%% Load image

I1 = imread('tps1.jpg');
[rows, cols, ~] = size(I1);
figure();imshow(I1);

%% Define transformation R
theta = pi/4; 

%... [TODO]
R = [cos(theta) -sin(theta) 0;...
     sin(theta) cos(theta)  0;...
     0             0        1];


%% Compute transformed image size

corners = [1  size(I1,1) size(I1,1)  1 ;
           1  1           size(I1,2)  size(I1,2) ;
           1  1           1            1 ] ;
    
% We apply transformation to the image corners
r_corners = R * corners;
r_rows = ceil(max(r_corners(1,:)) - min(r_corners(1,:)));
r_cols = ceil(max(r_corners(2,:)) - min(r_corners(2,:)));

xrange = min(r_corners(1,:)) : max(r_corners(1,:));
yrange = min(r_corners(2,:)) : max(r_corners(2,:));

I2 = zeros(r_rows, r_cols, 3);
%% Forward warping 
for ii = 2 : rows - 1
   for jj = 2 : cols - 1
       p = R * [ii jj 1]';
       ri = round(p(1) - xrange(1));
       rj = round(p(2) - yrange(1));
       I2(ri, rj, :) = I1(ii, jj, :);
   end
end
% [TODO]

figure();imshow(uint8(I2));


%% Backward warping with meshgrid & interp2
I3 = zeros(r_rows, r_cols, 3);
% We interpolate the pixels of I1 in I3
% src image
xx = 1 : cols;
yy = 1 : rows;
[X, Y] = meshgrid(xx, yy);
% dst image
xx_i = 1 : 1 : r_cols;
yy_i = 1 : 1 : r_rows;
[X_i, Y_i] = meshgrid(xx_i, yy_i);
I3 = interp2(xx, yy, I1, X_i, Y_i);
figure();imshow(I3);



