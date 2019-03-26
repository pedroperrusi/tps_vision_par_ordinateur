clear all; close all;

%% Load image

I1 = imread('tps1.jpg');

figure();imshow(I1);

%% Define transformation R
theta = pi/4; 

%... [TODO]


%% Compute transformed image size

corners = [1  size(I1,1) size(I1,1)  1 ;
           1  1           size(I1,2)  size(I1,2) ;
           1  1           1            1 ] ;
    
%... [TODO]
       
     
%% Forward warping 

%... [TODO]

figure();imshow(I2);


%% Backward warping with meshgrid & interp2

%... [TODO]

figure();imshow(I3);



