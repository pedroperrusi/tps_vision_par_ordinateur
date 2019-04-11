% clear workspace and load needed library
clear all;
addpath(genpath('./vl_toolbox'))    %CAUTION: matlab needs to be in the directory containing the folder vl_toolbox


%% Load and display image
I1 = imread('tps1.jpg');
I2 = imread('tps2.jpg');

im1 = im2single(rgb2gray(I1)); 
im2 = im2single(rgb2gray(I2)); 

figure();imshow(im1);
figure();imshow(im2);

%% Compute SIFT features

[SIFT_F1,SIFT_D1] = vl_sift(im1) ;
[SIFT_F2,SIFT_D2] = vl_sift(im2) ;

SIFT_P1 = SIFT_F1(1:2,:);
SIFT_P2 = SIFT_F2(1:2,:);

save('tps_sift.mat','SIFT_P1','SIFT_P2','SIFT_D1','SIFT_D2');


%%
load('tps_sift.mat');

%%

figure(1);imshow(im1);
figure(2);imshow(im2);

figure(1);hold on;plot(SIFT_P1(1,:)',SIFT_P1(2,:)','+r');
figure(2);hold on;plot(SIFT_P2(1,:)',SIFT_P2(2,:)','+g');


%%

[m1,m2] = match_sift(SIFT_P1,SIFT_P2,SIFT_D1,SIFT_D2);


figure(3);imshow(im1);
figure(4);imshow(im2);
figure(3);hold on;plot(m1(1,:)',m1(2,:)','+r');
figure(4);hold on;plot(m2(1,:)',m2(2,:)','+g');


mm1 = m1;
mm2 = m2 + repmat([size(I1,2);0],1,size(m2,2))

%% Plot correspondences
R = [I1 I2];
figure(5);
imagesc(R);colormap gray;hold on;

for i = 1:size(mm1,2)
    plot([mm1(1,i) mm2(1,i)], [mm1(2,i) mm2(2,i)],'-','color','r');
    %pause
end


X1 = m1; X1(3,:) = 1 ;
X2 = m2; X2(3,:) = 1 ;

%%
save('tps_matches.mat','m1','m2');



