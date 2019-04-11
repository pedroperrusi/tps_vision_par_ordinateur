%File poseFromBox.m
%%
clear all; close all;

%You need to be in the folder containing the calibration toolbox for this to work
tb_path = pwd;
addpath(genpath([tb_path '/toolbox_calib']));


%% Load camera calibration

run './imgCalib/Calib_Results.m'

%% Build K matrix

%...

%% Load image
I = imread('tea-box.jpg');
figure(1);hold on; imshow(I)

%% Select 4 points

%...


%% Compute H

%...


%% Compute R,t from H 

%...


%% Compute projection matrix P

%...

%% Show box axis
figure(2);hold on; imshow(I);

%...


%% Full box reconstruction: unwarp each side




%% Display the box in 3D (map the unwarped images on the 3D box model) 


%...


%% Generate some camera motion


%...




