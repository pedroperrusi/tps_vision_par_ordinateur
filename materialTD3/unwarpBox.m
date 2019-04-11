%File unwarpBox.m
%%
clear all; close all;

%You need to be in the folder containing the calibration toolbox for this to work
tb_path = pwd;
addpath(genpath([tb_path '/toolbox_calib']));

%% Load image
I = imread('tea-box.jpg');
figure(1);hold on; imshow(I)

%% Select 4 points (on the corners)

% [cx,cy]=select4Points(I);
cx = [175.2641  369.0918  776.4645  585.3516]';
cy = [170.2931   51.5247  249.9084  432.2266]';

% Size of the new image
rx=850;
ry=450;

% size of the box
sx = 85;
sy = 45;
sz = 50;

% We eill create an rectangular image to unwrap the tea rectangle
X1 = [0     0   sx    sx ;...
      sy    0   0     sy;...
      1     1    1    1];

X2 = [cx';...
      cy';...
      ones(1, 4)];

%% Compute H

H = homography(X1, X2);


%% Unparp the top plane to remove the perspective effect
clear 'CC','Z','PX','PY';

PX = [1:rx]*sx/rx;
PY = [1:ry]*sy/ry;

[MX,MY] = meshgrid(PX,PY);
x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

Id = double(I);
C1 = interp2(Id(:,:,1), x./z, y./z, 'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(Id(:,:,2), x./z, y./z, 'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(Id(:,:,3), x./z, y./z, 'cubic'); C3(isnan(C3)) = 0;

CC = uint8(zeros(ry, rx, 3));
CC(:,:,1) = round(C1);
CC(:,:,2) = round(C2);
CC(:,:,3) = round(C3);

%% Show top of the box after removing the perspective effect
figure;
imshow(CC);

%% Map it on a cylinder


%...


%% Map it on a 3D plane

%...

%% Camera motion
hold on;


%...


%% Warp text to display it on the picture (add perspective effect)

ICV = imread('cv-pic.png');


%Size of the tea box image
rx = 1024;
ry = 768;

%Size of the text image
sx = 850; 
sy = 450; 

% We eill create an rectangular image to unwrap the tea rectangle
X1 = [0     0   sx    sx ;...
      sy    0   0     sy;...
      1     1    1    1];

X2 = [cx';...
      cy';...
      ones(1, 4)];

% Compute H

H = homography(X2, X1);
H = H/H(3,3);

% Unparp the top plane to remove the perspective effect
% clear 'CC','Z','PX','PY';

PX = [1:rx];
PY = [1:ry];

[MX,MY] = meshgrid(PX,PY);
x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

Id = double(ICV);
C1 = interp2(Id(:,:,1), x./z, y./z, 'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(Id(:,:,2), x./z, y./z, 'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(Id(:,:,3), x./z, y./z, 'cubic'); C3(isnan(C3)) = 0;

CC2 = uint8(zeros(ry, rx, 3));
CC2(:,:,1) = round(C1);
CC2(:,:,2) = round(C2);
CC2(:,:,3) = round(C3);

%% Show text after adding the perspective effect
figure;
imshow(CC2);

%% Overlay warped text on the box
% Eliminate black pixels


I2 = I;
I2(CC2 == 255) = 255;

figure;
imshow(I2);


