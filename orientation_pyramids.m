% Function that receives an image (512x512 matrix)
% performs convolution with Gabor filters of different orientations
% (0, 45, 90, 135) and finds the Gauss pyramids of all the 
% orientations (conv with Gauss kernel + subsample on 9 different
% scales).
function output = orientation_pyramids(input_image)
global DEG_0 DEG_45 DEG_90 DEG_135

% Gabor kernels for diffrent orientations
Gabor_0 = [-1, -1, -1; 2, 2, 2; -1, -1, -1];
Gabor_45 = [2, -2, 1; -2, 2, -2; 1, -2, 2];
Gabor_90 = [-1, 2, -1; -1, 2, -1; -1, 2, -1];
Gabor_135 = [1, -2, 2; -2, 2, -2;2, -2, 1];

% convolve with Gabor kernel 
% and find [0..8] different scales

orientation_0 = conv2(input_image, Gabor_0, 'same');
output(DEG_0) = {make_pyramids(orientation_0)};

orientation_45 = conv2(input_image, Gabor_45, 'same');
output(DEG_45) =  {make_pyramids(orientation_45)};

orientation_90 = conv2(input_image, Gabor_90, 'same');
output(DEG_90) =  {make_pyramids(orientation_90)};

orientation_135 = conv2(input_image, Gabor_135, 'same');
output(DEG_135) =  {make_pyramids(orientation_135)};



