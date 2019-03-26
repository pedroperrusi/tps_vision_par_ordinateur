% clear workspace and load needed library
clear all; close all;
addpath(genpath('./'))

%% Load and display image
I1 = imread('tps1.jpg');
I2 = imread('tps2.jpg');

im1 = im2single(rgb2gray(I1)); 
im2 = im2single(rgb2gray(I2)); 

figure();imshow(im1);
figure();imshow(im2);

%% Compute SIFT features on images im1 and im2 using function vl_sift

[SIFT_F1,SIFT_D1] = vl_sift(im1) ;
[SIFT_F2,SIFT_D2] = vl_sift(im2) ;

SIFT_P1 = SIFT_F1(1:2,:);
SIFT_P2 = SIFT_F2(1:2,:);



%% Display features

%... [TODO]


%% Match features using function match_sift

[m1,m2] = match_sift(SIFT_P1,SIFT_P2,SIFT_D1,SIFT_D2);

%% Display matched features

%... [TODO]



%% Save matched features for later
save('tps_matches.mat','m1','m2');



