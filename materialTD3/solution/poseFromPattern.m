%File poseFromPattern.m
%%
clear all; close all;

%You need to be in the folder containing the calibration toolbox for this to work
tb_path = pwd;
addpath(genpath([tb_path '/toolbox_calib']));


%% Load camera calibration

run './imgCalib/Calib_Results.m'

%% Build matrix K

K = [fc(1)  alpha_c  cc(1); 0  fc(2)  cc(2); 0 0 1] 
%%
% K =
%
%   1.0e+03 *
%
%    1.0704         0    0.5064
%         0    1.0687    0.3973
%         0         0    0.0010

%% Load image
I = imread('imgCalib/im-0003.bmp');
figure(1);hold on; imshow(I)


%% Select 4 corners of the pattern

[x,y]=select4Points(I);


%% Saved 4 points
x = [ 227.4423 435.1586 796.3319 614.5680]';
y = [ 342.9126 145.4792 271.7645 536.6715]';

%% Compute homography H between plane in the image and plane on the object

% Points on the image:
imP = [x';y';ones(1,4)]  
% Points on the 3D model (in world coordiante system)
tmP = [0 0 9*10 9*10;0 7*10 7*10 0;ones(1,4)] %unit is mm

H = homography(tmP, imP);
H = H/H(3,3); % Normalize H

%% Compute R,t from H (take care of scale..)
[R,t] = computeRTfromH(H,K)

%% Compute projection matrix P

P = K*[R t]

%% Project coordinate system of the pattern 

A = P*[0;0;0;1];        A = A / A(3)
BX = P*[90; 0; 0; 1];   BX = BX / BX(3)
BY = P*[0; 70; 0; 1];   BY = BY / BY(3)
BZ = P*[0; 0; 50; 1];   BZ = BZ / BZ(3) 


figure(1);hold on;
plot([A(1) BX(1)], [A(2),BX(2)],'-','color','r','linewidth',2);
plot([A(1) BY(1)], [A(2),BY(2)],'-','color','b','linewidth',2);
plot([A(1) BZ(1)], [A(2),BZ(2)],'-','color','g','linewidth',2);

%%











