% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1070.357124767423102 ; 1068.721486953892281 ];

%-- Principal point:
cc = [ 506.368349185190141 ; 397.348686279199796 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.022423555659747 ; 0.069859672025422 ; -0.000374983432833 ; 0.000827766182070 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 7.407192386985116 ; 7.852091952806843 ];

%-- Principal point uncertainty:
cc_error = [ 10.122369925683261 ; 8.271131281109399 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.042872753944407 ; 0.377810323662914 ; 0.002618061798352 ; 0.003381710739788 ; 0.000000000000000 ];

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
omc_1 = [ 2.230306e+00 ; 1.441508e+00 ; -4.938810e-01 ];
Tc_1  = [ -6.204990e+02 ; -4.671393e+01 ; 2.112326e+03 ];
omc_error_1 = [ 6.023944e-03 ; 6.241496e-03 ; 1.243213e-02 ];
Tc_error_1  = [ 2.004712e+01 ; 1.655186e+01 ; 1.527958e+01 ];

%-- Image #2:
omc_2 = [ 1.535936e+00 ; 2.171659e+00 ; -4.871052e-01 ];
Tc_2  = [ -2.472332e+02 ; -4.695289e+02 ; 2.000172e+03 ];
omc_error_2 = [ 4.364906e-03 ; 8.041024e-03 ; 1.217267e-02 ];
Tc_error_2  = [ 1.903414e+01 ; 1.547775e+01 ; 1.412463e+01 ];

%-- Image #3:
omc_3 = [ 2.019572e+00 ; 2.111591e+00 ; -3.000270e-01 ];
Tc_3  = [ -3.324627e+02 ; -5.554985e+02 ; 2.794102e+03 ];
omc_error_3 = [ 5.936766e-03 ; 7.996004e-03 ; 1.555484e-02 ];
Tc_error_3  = [ 2.669074e+01 ; 2.160751e+01 ; 2.053340e+01 ];

%-- Image #4:
omc_4 = [ 1.337198e+00 ; 2.419136e+00 ; -9.625353e-01 ];
Tc_4  = [ -1.672681e+02 ; -5.865481e+02 ; 2.432625e+03 ];
omc_error_4 = [ 3.759460e-03 ; 9.274535e-03 ; 1.297326e-02 ];
Tc_error_4  = [ 2.331717e+01 ; 1.896203e+01 ; 1.586989e+01 ];

%-- Image #5:
omc_5 = [ -9.569194e-01 ; -2.537659e+00 ; 1.238300e-01 ];
Tc_5  = [ 1.192338e+02 ; -6.305362e+02 ; 2.226225e+03 ];
omc_error_5 = [ 3.839866e-03 ; 8.708679e-03 ; 1.161363e-02 ];
Tc_error_5  = [ 2.137808e+01 ; 1.732823e+01 ; 1.747620e+01 ];

%-- Image #6:
omc_6 = [ -1.060157e+00 ; -2.954204e+00 ; -1.507028e-01 ];
Tc_6  = [ -1.904554e+02 ; -6.907206e+02 ; 3.594982e+03 ];
omc_error_6 = [ 7.297506e-03 ; 1.786308e-02 ; 2.784985e-02 ];
Tc_error_6  = [ 3.422954e+01 ; 2.798930e+01 ; 2.763042e+01 ];

%-- Image #7:
omc_7 = [ -1.114642e+00 ; -2.802794e+00 ; -8.108523e-01 ];
Tc_7  = [ 1.208144e+02 ; -4.111921e+02 ; 1.949705e+03 ];
omc_error_7 = [ 2.113068e-03 ; 1.010191e-02 ; 1.357992e-02 ];
Tc_error_7  = [ 1.848694e+01 ; 1.515034e+01 ; 1.577333e+01 ];

