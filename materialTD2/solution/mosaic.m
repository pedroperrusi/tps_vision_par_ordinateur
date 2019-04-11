clear all; close all;


%% Load image

I1 = imread('tps1.jpg');
I2 = imread('tps2.jpg');

im1 = im2single(rgb2gray(I1)); 
im2 = im2single(rgb2gray(I2)); 

figure();imshow(im1);
figure();imshow(im2);


%% Test Homography function using good correspondences provided by the intructor
load('inliers_fromNP');
H =  homography(X1_fromNP, X2_fromNP);


%% Blend images and show mosaic: the transformation and the resulting mosaic should be quite good
K = blend(I1,I2,H);
figure(8);
imshow(K);


%% Display both images simultaneously and select corresponding points manually
I = [I1,I2];
figure, imshow(I);

%[X,Y] = ginput(8); %Ask for 8 points (uncomment)
%save('tps_ginput','X','Y');
load('tps_ginput');


[M,N,t] = size(I1);
n = size(X,1);
X1 = zeros(3,n/2);
X2 = zeros(3,n/2);
for i = 1:n/2
    X1(:,i) = [X(2*i-1), Y(2*i-1), 1]';
    X2(:,i) = [X(2*i)-N, Y(2*i), 1]';
end

%% Compute homography

H = homography(X1,X2);  % H maps from I1 to I2


%% Blend images and show mosaic (too few points: transformation may not be very good)

K = blend(I1,I2,H);  

figure(5);
imshow(K);



%% Use all potential matches to compute the homography

load('tps_matches.mat');

X1=[m1;ones(1,size(m1,2))];
X2=[m2;ones(1,size(m2,2))];

H = homography(X1,X2);  % H maps from I1 to I2

%% Blend images and show mosaic (due to the remaining outliers, an incorrect transformation was computed)

K = blend(I1,I2,H);   %note: incorrect mosaic

figure(5);
imshow(K);



%% Use RANSAC to detect inliers and compute homography
load('tps_matches.mat');
X1=[m1;ones(1,size(m1,2))];
X2=[m2;ones(1,size(m2,2))];

tr=6;
numMatches = size(m1,2) 

clear H score inliers ;
for t = 1:100
  % estimate homography
  
  subset = randperm(numMatches, 4) ;
  Y1 = []; Y2= [];
  for i = subset
     Y1 =  [Y1 X1(:,i)];
     Y2 =  [Y2 X2(:,i)];
  end
  
  H{t} = homography(Y1,Y2);

  % score homography
  X2_ = H{t} * X1 ;
  du = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:) ;  %normalize coordinates
  dv = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:) ;
  inliers{t} = (du.*du + dv.*dv) < tr*tr ;
  score(t) = sum(inliers{t}) ;
end
[score, best] = max(score) ;
H = H{best} ;
inliers = inliers{best} ;

%% Display matches (inliers)
matches(1,:) = 1:numMatches; 
matches(2,:) = 1:numMatches; 

dh1 = max(size(im2,1)-size(im1,1),0) ;
dh2 = max(size(im1,1)-size(im2,1),0) ;

figure(1) ;  hold on;
axis image off ;
subplot(2,1,1) ;

imshow([im1 im2]);


o = size(im1,2) ;
line([m1(1,matches(1,:));m2(1,matches(2,:))+o], [m1(2,matches(1,:));m2(2,matches(2,:))]) ;

title(sprintf('%d tentative matches', numMatches)) ;

subplot(2,1,2) ;

imshow([im1 im2]);

line([m1(1,matches(1,inliers));m2(1,matches(2,inliers))+o], [m1(2,matches(1,inliers));m2(2,matches(2,inliers))]) ;
title(sprintf('%d (%.2f%%) inliner matches out of %d', sum(inliers), 100*sum(inliers)/numMatches, numMatches)) ;



%% Display results (the transformation and the resulting mosaic are good)

K = blend(I1,I2,H);

figure(6);
imshow(K);

%% Results when recomputing homography with all inliers

H =  homography(X1(:,inliers) , X2(:,inliers));

K = blend(I1,I2,H);

figure(7);
imshow(K);

%% Save inliers 
X1_fromNP = X1(:,inliers);
X2_fromNP = X2(:,inliers);
save('inliers_fromNP','X1_fromNP','X2_fromNP');

%% Show homography comptuted from these inliers
load('inliers_fromNP');
H =  homography(X1_fromNP, X2_fromNP);
K = blend(I1,I2,H);
figure(8);
imshow(K);






