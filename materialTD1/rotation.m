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
       ri = (p(1) - xrange(1));
       rj = (p(2) - yrange(1));
       I2(floor(ri), floor(rj), :) = I1(ii, jj, :);
       I2(ceil(ri), floor(rj), :) = I1(ii, jj, :);
       I2(floor(ri), ceil(rj), :) = I1(ii, jj, :);
       I2(ceil(ri), ceil(rj), :) = I1(ii, jj, :);
   end
end

figure();imshow(uint8(I2));


%% Backward warping with meshgrid & interp2

iR = inv(R);

% src image (not necessary)
% xx = 1 : cols;
% yy = 1 : rows;
% [X, Y] = meshgrid(xx, yy);
% dst image
[X_i, Y_i] = meshgrid(xrange, yrange);
X_i = X_i';
Y_i = Y_i';

% Transform from dst to src
x = (iR(1,1) * X_i + iR(1,2) * Y_i + iR(1,3));
y = (iR(2,1) * X_i + iR(2,2) * Y_i + iR(2,3));
z = (iR(3,1) * X_i + iR(3,2) * Y_i + iR(3,3));

% apply interpolation
II = double(I1); % conversion to double
I3_r = interp2(II(:,:,1)', x./z, y./z, 'cubic');
I3_g = interp2(II(:,:,2)', x./z, y./z, 'cubic');
I3_b = interp2(II(:,:,3)', x./z, y./z, 'cubic');
I3 = cat(3, I3_r, I3_g, I3_b);
figure();imshow(uint8(I3));



