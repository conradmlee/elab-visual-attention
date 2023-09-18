%% this function creates 12 feature maps for color
function output = color_feature_maps(color_pyramids_cells)

%% perform first subtraction of center-center and surround-surround

% definitions
RG_BY = [1 1 1 2 2 2 2 3 3 3 4 4 4 4];
GR_YB = [2 2 2 1 1 1 1 4 4 4 3 3 3 3];
color_scale = [2 3 4 5 6 7 8 2 3 4 5 6 7 8];

%% preallocate for speed
first_sub = cell(256,256,14);
output = cell(256,256,12);

% perform first subtraction
for i=1:14
    sub = color_pyramids_cells{RG_BY(i)}{color_scale(i)} - color_pyramids_cells{GR_YB(i)}{color_scale(i)};
    first_sub(i) = {sub};
end

%% resize to necessary scales then perform second subtraction (point-by-point)

% definitions
center_address = [1 1 2 2 3 3 8 8 9 9 10 10];
out_size = [32 64 64 128 128 256 32 64 64 128 128 256];
surround_address = [4 5 5 6 6 7 11 12 12 13 13 14];

% perform resize and subtract
% remember to take absolute value after across-scale subtraction!
for k=1:12
    resized = resize(first_sub{center_address(k)},out_size(k));
    subtracted = abs(resized - first_sub{surround_address(k)});
    
    % display 2 sets of 6 images
    % figure
    % imshow(subtracted);
    
    % send output
    output(k) = {subtracted};
end