% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1072.154820300300344 ; 1070.808979979756714 ];

%-- Principal point:
cc = [ 507.498007905543204 ; 397.032366189017864 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.349941632085971 ; 0.121608436403556 ; 0.001689413546233 ; -0.000896398374912 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.824414253849254 ; 6.155296229384686 ];

%-- Principal point uncertainty:
cc_error = [ 7.897062350903546 ; 6.510893844983403 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.033044660817347 ; 0.290904440814935 ; 0.001061886209369 ; 0.000744584830695 ; 0.000000000000000 ];

%-- Image size:
nx = 1024;
ny = 768;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 7;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.514158e+00 ; -5.403380e-01 ; 7.643702e-02 ];
Tc_1  = [ -3.466822e+01 ; 4.867167e+01 ; 1.758339e+02 ];
omc_error_1 = [ 6.082836e-03 ; 3.032723e-03 ; 9.489427e-03 ];
Tc_error_1  = [ 1.312728e+00 ; 1.098369e+00 ; 1.055719e+00 ];

%-- Image #2:
omc_2 = [ 2.539620e+00 ; 4.349542e-01 ; 7.848826e-02 ];
Tc_2  = [ -4.525703e+01 ; 8.612832e+00 ; 1.630070e+02 ];
omc_error_2 = [ 6.128404e-03 ; 2.956844e-03 ; 9.906903e-03 ];
Tc_error_2  = [ 1.207486e+00 ; 9.963630e-01 ; 9.980283e-01 ];

%-- Image #3:
omc_3 = [ 2.849728e+00 ; 6.331515e-02 ; 6.238129e-04 ];
Tc_3  = [ -3.657213e+01 ; 1.154371e+01 ; 2.600230e+02 ];
omc_error_3 = [ 7.360401e-03 ; 2.162132e-03 ; 1.218557e-02 ];
Tc_error_3  = [ 1.914033e+00 ; 1.583905e+00 ; 1.454642e+00 ];

%-- Image #4:
omc_4 = [ 2.384407e+00 ; 6.860064e-01 ; -4.103732e-01 ];
Tc_4  = [ -5.646394e+01 ; -1.120137e+01 ; 2.102807e+02 ];
omc_error_4 = [ 6.129477e-03 ; 4.114370e-03 ; 9.601567e-03 ];
Tc_error_4  = [ 1.557476e+00 ; 1.285013e+00 ; 1.180969e+00 ];

%-- Image #5:
omc_5 = [ -2.603686e+00 ; -1.177612e+00 ; 5.274018e-01 ];
Tc_5  = [ -3.546191e+01 ; -1.760077e+01 ; 2.480752e+02 ];
omc_error_5 = [ 6.100517e-03 ; 2.418467e-03 ; 1.093369e-02 ];
Tc_error_5  = [ 1.827101e+00 ; 1.497597e+00 ; 1.278566e+00 ];

%-- Image #6:
omc_6 = [ -2.780391e+00 ; -1.311858e+00 ; -1.006864e-01 ];
Tc_6  = [ -7.351149e+01 ; -2.457759e+01 ; 3.627748e+02 ];
omc_error_6 = [ 1.328789e-02 ; 5.716706e-03 ; 2.141134e-02 ];
Tc_error_6  = [ 2.685630e+00 ; 2.220370e+00 ; 2.172662e+00 ];

%-- Image #7:
omc_7 = [ -2.491492e+00 ; -1.074182e+00 ; -4.993038e-01 ];
Tc_7  = [ -4.029773e+01 ; 3.434975e+00 ; 2.095706e+02 ];
omc_error_7 = [ 5.755313e-03 ; 4.496076e-03 ; 1.040350e-02 ];
Tc_error_7  = [ 1.549957e+00 ; 1.269949e+00 ; 1.204327e+00 ];

