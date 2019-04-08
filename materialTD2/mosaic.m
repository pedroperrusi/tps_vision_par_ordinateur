
clear all; close all;


%% Load image

I1 = imread('../data/tps1.jpg');
I2 = imread('../data/tps2.jpg');

im1 = im2single(rgb2gray(I1)); 
im2 = im2single(rgb2gray(I2)); 

figure();imshow(im1);
figure();imshow(im2);


%% (1b) Test Homography function using good correspondences provided by the intructor
load('inliers_fromNP');
H =  homography(X1_fromNP, X2_fromNP);


%% (1b) Blend images and show mosaic: the transformation and the resulting mosaic should be quite good
K = blend(I1,I2,H);
figure(8);
imshow(K);


%% Display both images simultaneously and select corresponding points manually
I = [I1,I2];
figure, imshow(I);

[X,Y] = ginput(8); %Ask for 8 points
save('tps_ginput','X','Y');
%load('tps_ginput');

[M,N,t] = size(I1);
n = size(X,1);
X1 = zeros(3,n/2);
X2 = zeros(3,n/2);

%... [TODO] define X1 and X2 from X and Y to get corresponding points in image coordinates
X1 = [X(1 : 2 : end); Y(1 : 2 : end)];
X2 = [X(2 : 2 : end); Y(2 : 2 : end)];

%% Compute homography

H = homography(X1,X2);  % H maps from I1 to I2


%% Blend images and show mosaic (too few points: transformation may not be very good)

K = blend(I1,I2,H);

figure(5);
imshow(K);



%% Use all potential matches to compute the homography

load('tps_matches.mat');

%...  [TODO] define X1 and X2

H = homography(X1,X2);  % H maps from I1 to I2


K = blend(I1,I2,H);

figure(5);   %(due to the remaining outliers, an incorrect transformation may have been computed)
imshow(K);





%% Use RANSAC to detect inliers and compute homography
tr=6;
numMatches = size(m1,2) 

%...  [TODO]



%% Display matches before and after RANSAC



%...  [TODO]



%% Display results

K = blend(I1,I2,H);

figure(6);
imshow(K);

%% Results when recomputing homography with inliers

H =  homography(X1(:,inliers) , X2(:,inliers)); %...  [TODO] Define 'inliers'

K = blend(I1,I2,H);

figure(7); %(the transformation and the resulting mosaic should be good)
imshow(K);





