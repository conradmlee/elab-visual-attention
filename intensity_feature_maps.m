%% this function creates 6 feature maps for intensity
function output = intensity_feature_maps(intensity_pyramids_cells)

%% resize to necessary scales then perform second subtraction (point-by-point)

% definitions
in_scale = [2 2 3 3 4 4];
out_size = [32 64 64 128 128 256];
surround = [5 6 6 7 7 8];

% preallocate for speed
output = cell(256,256,6);

% perform resize and subtract
% remember to take absolute value after across-scale subtraction!
for i=1:6
    resized = resize(intensity_pyramids_cells{in_scale(i)},out_size(i));
    subtracted = abs(resized - intensity_pyramids_cells{surround(i)});
    
    % display 1 set of 6 images
    % figure
    % imshow(subtracted);
     
    % send output
    output(i) = {subtracted};
end