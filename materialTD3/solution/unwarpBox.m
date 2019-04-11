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

[cx,cy]=select4Points(I);

%% Saved points
cx = [175.3181 369.1353 776.4756 587.6953]';
cy = [170.2402 51.5195 249.9611 435.7422]';

%% Compute H

%Size of the box
sx = 85; %mm
sy = 45; %mm
sz = 50; %mm

imP = [cx';cy';ones(1,4)]
tmP = [0 0 sx sx; sy 0 0 sy;ones(1,4)]

H = homography(tmP, imP);

%% Unparp the top plane to remove the perspective effect
clear 'CC','Z','PX','PY';
rx=850;
ry=450;

PX = [1:rx]*sx/rx; %number of elements = resolution of the image
PY = [1:ry]*sy/ry; %values should match the corners given to the homography

[MX,MY] = meshgrid(PX,PY);
x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

II = double(I);
C1 = interp2(II(:,:,1),x./z,y./z,'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(II(:,:,2),x./z,y./z,'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(II(:,:,3),x./z,y./z,'cubic'); C3(isnan(C3)) = 0;

CC=uint8(zeros(ry,rx,3));
CC(:,:,1)=round(C1);
CC(:,:,2)=round(C2);
CC(:,:,3)=round(C3);

%% Show top of the box after removing the perspective effect
figure();hold on;xlabel('x');ylabel('y');imshow(CC);

%% Map it on a cylinder
figure;
[x,y,z] = cylinder;

warp(x,y,z,CC);

%% Map it on a 3D plane
sx = 85;%mm
sy = 45;
sz = 50;

figure();hold on; xlabel('x');ylabel('y');zlabel('z');

planex = [0 sx/2 sx; 0 sx/2 sx];
planey = [0 0 0; sy sy sy];
planez = [sz sz sz; sz sz sz];
warp(planex,planey,planez,CC);%hold on;

axis equal;  
axis vis3d; 
set(gca,'XTickLabel',{}) %nicer axes
set(gca,'YTickLabel',{})
set(gca,'ZTickLabel',{})
zlim([0 sz])
view(-40,-30)

%% Camera motion
hold on;
for i = 0:-2:-60
    view(-40+i,-30);
    drawnow;
    pause(0.1);
end
for i = 0:2:60+50
    view(-40-60+i,-30-i/3);
    drawnow;
    pause(0.1);
end
for i = 0:-2:-50
    view(-40+50+i,-30-110/3-i);
    drawnow;
    pause(0.1);
end


%% Warp text to display it on the picture (add perspective effect)

ICV = imread('cv-pic.png');
clear 'CC','Z','PX','PY';

%Size of the tea box image
rx = 1024;
ry = 768;

%Size of the text image
sx = 850; 
sy = 450; 

%Compute homography between text image and side of tea box 
imP = [cx';cy';ones(1,4)]
tmP = [0 0 sx sx;sy 0 0 sy;ones(1,4)] % Caution (O,O) is top left of image in matlab
H = homography(imP, tmP);
H = H/H(3,3); % Normalize H

PX = [1:rx];
PY = [1:ry];

[MX,MY] = meshgrid(PX,PY);
x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

II = double(ICV);
C1 = interp2(II(:,:,1),x./z,y./z,'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(II(:,:,2),x./z,y./z,'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(II(:,:,3),x./z,y./z,'cubic'); C3(isnan(C3)) = 0;

CC=uint8(zeros(ry,rx,3));
CC(:,:,1)=round(C1);
CC(:,:,2)=round(C2);
CC(:,:,3)=round(C3);

%% Show text after adding the perspective effect
figure();hold on;xlabel('x');ylabel('y');imshow(CC);

%% Overlay warped text on the box
%[ix,iy,]=(CC(:,:,1)==255);
I2=I;
I2(CC==255)=255;
figure();imshow(I2);


