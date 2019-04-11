%File poseFromBox.m
%%
clear all; close all;

%You need to be in the folder containing the calibration toolbox for this to work
tb_path = pwd;
addpath(genpath([tb_path '/toolbox_calib']));


%% Load camera calibration

run './imgCalib/Calib_Results.m'

%% Build K matrix

K = [fc(1)  alpha_c  cc(1); 0  fc(2)  cc(2); 0 0 1] 

%% Load image
I = imread('tea-box.jpg');
figure(1);hold on; imshow(I)

%% Select 4 points

[x,y]=select4Points(I);

%% Saved points
x = [175.3181 369.1353 776.4756 587.6953]';
y = [170.2402 51.5195 249.9611 435.7422]';

%% Compute H

%Size of the box
sx = 85; %mm
sy = 45; %mm
sz = 50; %mm

imP = [x';y';ones(1,4)]
tmP = [0 0 sx sx;0 sy sy 0;ones(1,4)]

H = homography(tmP, imP);
H = H/H(3,3); % Normalize H


%% Compute R,t from H 

[R,t] = computeRTfromH(H,K)

%% Compute projection matrix P

P = K*[R t]

%% Show box axis
figure(2);hold on; imshow(I);

A = P*[0;0;0;1]; A=A / A(3)
BX = P*[sx; 0; 0; 1]; BX = BX / BX(3)
BY = P*[0; sy; 0; 1]; BY = BY / BY(3)
BZ = P*[0; 0; -sz; 1]; BZ = BZ / BZ(3)  %Caution: inverted axis


figure(2);hold on;
plot([A(1) BX(1)], [A(2),BX(2)],'-','color','r','linewidth',2);

plot([A(1) BY(1)], [A(2),BY(2)],'-','color','b','linewidth',2);

plot([A(1) BZ(1)], [A(2),BZ(2)],'-','color','g','linewidth',2);


%% Full box reconstruction 

%size of the box
sx = 85;%mm
sy = 45;
sz = 50;

%dimensions used to define the sizes of the 2d unwarped image
rx = 850; 
ry = 450;
rz = 500;

% Top (main reference plane for the 3D coordinate system)

%Project corresponding 3D points in the image
pt1 = P*[0;0;0;1];      pt1=pt1 / pt1(3)
pt2 = P*[0; sy; 0; 1];  pt2=pt2 / pt2(3)
pt3 = P*[sx; sy; 0; 1]; pt3=pt3 / pt3(3)
pt4 = P*[sx; 0; 0; 1];  pt4=pt4 / pt4(3)

%Display the projected points in the picture
figure();imshow(I);hold on;
plot([pt1(1) pt2(1)], [pt1(2),pt2(2)],'-','color','r','linewidth',2);
plot([pt2(1) pt3(1)], [pt2(2),pt3(2)],'-','color','b','linewidth',2);
plot([pt3(1) pt4(1)], [pt3(2),pt4(2)],'-','color','g','linewidth',2);
plot([pt4(1) pt1(1)], [pt4(2),pt1(2)],'-','color','m','linewidth',2);

%Compute homography
x = [pt1(1) pt2(1) pt3(1) pt4(1)];
y = [pt1(2) pt2(2) pt3(2) pt4(2)];

imP = [x;y;ones(1,4)];
tmP = [0 0 sx sx;0 sy sy 0;ones(1,4)];
H = homography(tmP, imP);

%Generate unwarped image 
PX = [1:rx]*sx/rx;
PY = [1:ry]*sy/ry;
[MX,MY] = meshgrid(PX,PY);

x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

II = double(I);
C1 = interp2(II(:,:,1),x./z,y./z,'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(II(:,:,2),x./z,y./z,'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(II(:,:,3),x./z,y./z,'cubic'); C3(isnan(C3)) = 0;

CCT=uint8(zeros(ry,rx,3));
CCT(:,:,1)=round(C1);
CCT(:,:,2)=round(C2);
CCT(:,:,3)=round(C3);

%%
% Front 

%Project corresponding 3D points in the image
pt1 = P*[0;0;-sz;1];        pt1=pt1 / pt1(3) %start from bottom left
pt2 = P*[0; 0; 0; 1];       pt2=pt2 / pt2(3)
pt3 = P*[sx; 0; 0; 1];      pt3=pt3 / pt3(3)
pt4 = P*[sx; 0; -sz; 1];    pt4=pt4 / pt4(3)

%Display the projected points in the picture
figure();imshow(I);hold on;
plot([pt1(1) pt2(1)], [pt1(2),pt2(2)],'-','color','r','linewidth',2);
plot([pt2(1) pt3(1)], [pt2(2),pt3(2)],'-','color','b','linewidth',2);
plot([pt3(1) pt4(1)], [pt3(2),pt4(2)],'-','color','g','linewidth',2);
plot([pt4(1) pt1(1)], [pt4(2),pt1(2)],'-','color','m','linewidth',2);

%Compute homography
x = [pt1(1) pt2(1) pt3(1) pt4(1)];
y = [pt1(2) pt2(2) pt3(2) pt4(2)];

imP = [x;y;ones(1,4)];
tmP = [0 0 sx sx; 0 sz sz 0;ones(1,4)]; %start from bottom left
H = homography(tmP, imP);

%Generate unwarped image 
PX = [1:rx]*sx/rx;  %Adapt to plane coordinate sytem
PY = [1:rz]*sz/rz;
[MX,MY] = meshgrid(PX,PY);

x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

II = double(I);
C1 = interp2(II(:,:,1),x./z,y./z,'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(II(:,:,2),x./z,y./z,'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(II(:,:,3),x./z,y./z,'cubic'); C3(isnan(C3)) = 0;

CCF=uint8(zeros(rz,rx,3));
CCF(:,:,1)=round(C1);
CCF(:,:,2)=round(C2);
CCF(:,:,3)=round(C3);
%%
% Small side

%Project corresponding 3D points in the image
pt1 = P*[sx;0;-sz;1];       pt1=pt1 / pt1(3) %start from bottom left
pt2 = P*[sx; 0; 0; 1];      pt2=pt2 / pt2(3)
pt3 = P*[sx; sy; 0; 1];     pt3=pt3 / pt3(3)
pt4 = P*[sx; sy; -sz; 1];   pt4=pt4 / pt4(3)

%Display the projected points in the picture
figure();imshow(I);hold on;
plot([pt1(1) pt2(1)], [pt1(2),pt2(2)],'-','color','r','linewidth',2);
plot([pt2(1) pt3(1)], [pt2(2),pt3(2)],'-','color','b','linewidth',2);
plot([pt3(1) pt4(1)], [pt3(2),pt4(2)],'-','color','g','linewidth',2);
plot([pt4(1) pt1(1)], [pt4(2),pt1(2)],'-','color','m','linewidth',2);

%Compute homography
x = [pt1(1) pt2(1) pt3(1) pt4(1)];
y = [pt1(2) pt2(2) pt3(2) pt4(2)];

imP = [x;y;ones(1,4)];
tmP = [0 0 sy sy;0 sz sz 0;ones(1,4)]; %start from bottom left
H = homography(tmP, imP);

%Generate unwarped image 
PX = [1:ry]*sy/ry; %Adapt to plane coordinate sytem
PY = [1:rz]*sz/rz;
[MX,MY] = meshgrid(PX,PY);

x = (H(1,1)*MX+H(1,2)*MY+H(1,3));
y = (H(2,1)*MX+H(2,2)*MY+H(2,3));
z = (H(3,1)*MX+H(3,2)*MY+H(3,3));

II = double(I);
C1 = interp2(II(:,:,1),x./z,y./z,'cubic'); C1(isnan(C1)) = 0;
C2 = interp2(II(:,:,2),x./z,y./z,'cubic'); C2(isnan(C2)) = 0;
C3 = interp2(II(:,:,3),x./z,y./z,'cubic'); C3(isnan(C3)) = 0;
%Z=zeros(ry,rx);

CCS=uint8(zeros(rz,ry,3));
CCS(:,:,1)=round(C1);
CCS(:,:,2)=round(C2);
CCS(:,:,3)=round(C3);


%% Display the box in 3D (map the unwarped images on the 3D box model) 
figure();hold on; xlabel('x');ylabel('y');zlabel('z');

%Define a 3D surface (a 3D plane) 
%See eg http://fr.mathworks.com/help/matlab/visualize/representing-a-matrix-as-a-surface.html
planex = [0 sx/2 sx; 0 sx/2 sx];
planey = [0 0 0; sy sy sy];
planez = [0 0 0; 0 0 0];
warp(planex,planey,planez,CCT);

planex = [0 sx/2 sx; 0 sx/2 sx];
planey = [0 0 0; 0 0 0];
planez = [-sz -sz -sz; 0 0 0];
warp(planex,planey,planez,CCF);

planex = [sx sx sx;sx sx sx];
planey = [0 sy/2 sy; 0 sy/2 sy];
planez = [-sz -sz -sz; 0 0 0];
warp(planex,planey,planez,CCS);

axis equal;  
axis vis3d; 

set(gca,'XTickLabel',{})%nicer axes
set(gca,'YTickLabel',{})
set(gca,'ZTickLabel',{})
%camproj('perspective');
%alpha('texture');
view(-40,-30)


%% Generate some camera motion
hold on; hidden on;
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






