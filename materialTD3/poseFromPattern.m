%File poseFromPattern.m
%%
clear all; close all;

%You need to be in the folder containing the calibration toolbox for this to work
tb_path = pwd;
addpath(genpath([tb_path '/toolbox_calib']));


%% Load camera calibration

run './imgCalib/Calib_Results.m'

%% Build matrix K

K = %...

%% Load image
I = imread('imgCalib/im-0003.bmp');
figure(1);hold on; imshow(I)


%% Select 4 corners of the pattern

%...


%% Compute homography H between plane in the image and plane on the object

%...

%% Compute R,t from H (take care of scale..)

[R,t] = computeRTfromH(H,K)

%% Compute projection matrix P

P = %...

%% Project coordinate system of the pattern 

A = P*[0;0;0;1];        A = A / A(3)
BX = P*[90; 0; 0; 1];   BX = BX / BX(3)
BY = P*[0; 70; 0; 1];   BY = BY / BY(3)
BZ = P*[0; 0; 50; 1];   BZ = BZ / BZ(3) 


%...

%%


