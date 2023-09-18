%% this function uses normalization to create 1 saliency map for intensity
function output = intensity_saliency(intensity_feature_cells)

%% 3 steps:
% (1) normalize
% (2) resize to scale 4
% (3) point-to-point addition 

% define total_sum
total_sum = zeros(32,32);

% perform normalization on all 6 feature maps, then resize and sum
for i=1:6
    normalized = normalize(intensity_feature_cells{i});
    resized = resize(normalized,32);
    total_sum = total_sum + resized;
end

% send output
output = total_sum;

% display intensity saliency map
figure
imshow(output);
