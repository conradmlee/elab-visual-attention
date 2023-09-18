%% this function uses normalization to create 1 saliency map for color
function output = color_saliency(color_feature_cells)

%% 4 steps:
% (1) normalize 6 RG maps and 6 BY maps separately
% (2) combine each pair of same scale RG and BY maps
% (3) resize all 6 RGBY maps to scale 4
% (4) point-to-point addition of the 6 combined RGBY maps

% define total_sum
total_sum = zeros(32,32);

%% preallocate for speed
normalized = cell(256,256,12);

%% normalize all 12 (2 sets of 6 each) color feature maps
for i=1:12
    normalized(i) = {normalize(color_feature_cells{i})};
end

%% combine same-scale pairs, then resize and sum (note: added average "/2")
for j=1:6
    combined = normalized{j} + normalized{j+6};
    
    %% debug: averaged the two in order to prevent oversized output
    averaged = combined/2;
    
    resized = resize(averaged,32);
    total_sum = total_sum + resized;
end

%% send output
output = total_sum;

%% display color saliency map
 figure
 imshow(output);