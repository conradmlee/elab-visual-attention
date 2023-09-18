%% this function creates a gaussian pyramid by convolution and subsampling
%% output: vector that contains all the scales
%% negative values have are cut out before completion
function output = make_pyramids(gray_input)

%% define the gaussian kernel
kernel = [1 2 1; 2 4 2; 1 2 1]/16;

%% preallocate for speed
output = cell(256,256,8);

%% 8 image scales created by progressively convoluting and subsampling
%% no Level 0 because reference index cannot be 0... e.g. output(0)
for counter = 8:-1:1
    
    %% perform convolution
    convolved = conv2(gray_input, kernel, 'same');
        
    %% define step size and subsampled image size
    step = 2;
    size_out = size(convolved);
    out_dim =  size_out(1) / 2;
        
    %% perform subsampling
    subsampled = subsample(convolved, step, out_dim);
        
    %% display subsampled image level
    % figure
    % imshow(subsampled); % for intensity pyramid divide by 255
        
    %% update gray image for next convolution
    gray_input = subsampled;
    
    %% cut out all negative values
    subsampled(subsampled<0)=0;
    
    output(counter) = {subsampled};
end

%% Center-Surround Level Comparisons: allows multiscale feature extraction
% I(2,5)
% I(2,6)
% I(3,6)
% I(3,7)
% I(4,7)
% I(4,8)

%% Itti Pyramid Levels
% Level 0 = 1 x 1
% Level 1 = 2 x 2
% Level 2 = 4 x 4
% Level 3 = 8 x 8
% Level 4 = 16 x 16
% Level 5 = 32 x 32
% Level 6 = 64 x 64
% Level 7 = 128 x 128
% Level 8 = 256 x 256

%% Pyramid Levels
% Level 0 = 512 x 512
% Level 1 = 256 x 256
% Level 2 = 128 x 128
% Level 3 = 64  x 64
% Level 4 = 32  x 32
% Level 5 = 16  x 16
% Level 6 = 8   x 8
% Level 7 = 4   x 4
% Level 8 = 2   x 2
% Level 9 = 1   x 1