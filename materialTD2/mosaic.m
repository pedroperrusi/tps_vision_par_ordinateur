
clear all; close all;


%% Load image

I1 = imread('../data/tps1.jpg');
I2 = imread('../data/tps2.jpg');

im1 = im2single(rgb2gray(I1)); 
im2 = im2single(rgb2gray(I2)); 

figure();imshow(im1);
figure();imshow(im2);


%% (1b) Test Homography function using good correspondences provided by the intructor
load('inliers_fromNP');
H =  homography(X1_fromNP, X2_fromNP);


%% (1b) Blend images and show mosaic: the transformation and the resulting mosaic should be quite good
K = blend(I1,I2,H);
figure(8);
imshow(K);


%% Display both images simultaneously and select corresponding points manually
I = [I1,I2];
figure, imshow(I);

[X,Y] = ginput(8); %Ask for 8 points
save('tps_ginput','X','Y');
%load('tps_ginput');

[M,N,t] = size(I1);
n = size(X,1);
X1 = ones(3,n/2);
X2 = ones(3,n/2);

%... [TODO] define X1 and X2 from X and Y to get corresponding points in image coordinates
X1(1 : 2, :) = [X(1 : 2 : end)'; Y(1 : 2 : end)'];
X2(1 : 2, :) = [X(2 : 2 : end)'; Y(2 : 2 : end)'];

%% Compute homography

H = homography(X1,X2);  % H maps from I1 to I2


%% Blend images and show mosaic (too few points: transformation may not be very good)

K = blend(I1,I2,H);

figure(5);
imshow(K);



%% Use all potential matches to compute the homography

load('../data/tps_matches.mat');

% We computee the homogeneous coordinates
X1 = [m1; ones(1, size(m1,2))];
X2 = [m2; ones(1, size(m2,2))];

H = homography(X1,X2);  % H maps from I1 to I2


K = blend(I1,I2,H);

figure(5);   %(due to the remaining outliers, an incorrect transformation may have been computed)
imshow(K);

%% Use RANSAC to detect inliers and compute homography
tr=6;
numMatches = size(m1,2);

H_candidates = {};
inliners_candidates = {};
scores = [];
% try 100 times
for i = 1 : 100
    % generate a random index
    idxs = randperm(numMatches, 4);

    Y1 = [];
    Y2 = [];
    for idx = idxs
        Y1 = [Y1 X1(:,idx)];
        Y2 = [Y2 X2(:,idx)];
    end
    H_candidates{i} = homography(Y1, Y2);
    
    % score homography
    X2_ = H_candidates{i} * X1;
    du = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:);
    dv = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:);
    inliners_candidates{i} = (du.*du + dv.*dv) < tr*tr;
    scores(i) = sum(inliners_candidates{i});
end

[score, best] = max(scores);
H = H_candidates{best};
inliners = inliners_candidates{best};


%% Display matches before and after RANSAC



%...  [TODO]



%% Display results

K = blend(I1,I2,H);

figure(6);
imshow(K);

%% Results when recomputing homography with inliers
% inliers is oposed to inliners
inliers = ~inliners; 
H =  homography(X1(:,inliers) , X2(:,inliers)); 

K = blend(I1,I2,H);

figure(7); %(the transformation and the resulting mosaic should be good)
imshow(K);





