% clear workspace and load needed library
clear all; close all;
addpath(genpath('./'))

%% Load and display image
I1 = imread('../data/tps1.jpg');
I2 = imread('../data/tps2.jpg');

im1 = im2single(rgb2gray(I1)); 
im2 = im2single(rgb2gray(I2)); 
% 
% figure();imshow(im1);
% figure();imshow(im2);

%% Compute SIFT features on images im1 and im2 using function vl_sift

[SIFT_F1,SIFT_D1] = vl_sift(im1) ;
[SIFT_F2,SIFT_D2] = vl_sift(im2) ;

SIFT_P1 = SIFT_F1(1:2,:);
SIFT_P2 = SIFT_F2(1:2,:);


%% Display features
figure(); 
imshow(im1);hold on;
for i = 1 : size(SIFT_P1, 2)
   plot(SIFT_P1(1, i), SIFT_P1(2, i), 'r+')
end

figure(); 
imshow(im2);hold on;
for i = 1 : size(SIFT_P2, 2)
   plot(SIFT_P2(1, i), SIFT_P2(2, i), 'g+')
end


%% Match features using function match_sift

[m1,m2] = match_sift(SIFT_P1,SIFT_P2,SIFT_D1,SIFT_D2);

%% Display matched features

% Create a new side to side image
rowsMatch = max(size(im1, 1), size(im2, 1));
colsMatch = size(im1, 2) + size(im2, 2);
ImageMatch = zeros(rowsMatch, colsMatch, 1);

% add image 1
ImageMatch(1 : size(im1, 1), 1 : size(im1, 2)) = im1;
% add image 2 to its right side
ImageMatch(1 : size(im2, 1), size(im1, 2) : colsMatch - 1) = im2;

%... [TODO]
figure();
imshow(ImageMatch); hold on;
for i = 1 : length(m1)
    pt1 = m1(i);
   pt2 = [size(im1, 1) 0]' + m2(i);
   plot([pt1(1) pt2(1)], [pt1(2) pt2(2)], 'b:')
%        plot([pt1(1) pt2(1)], [pt1(2) pt2(2)], 'b+')
end

%% Save matched features for later
save('tps_matches.mat','m1','m2');



