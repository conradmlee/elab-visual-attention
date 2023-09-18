%% this function uses normalization to create 1 saliency map for orientation
function output = orientation_saliency(orientation_feature_cells)

%% 4 steps:

% (1) normalize each set of 6 (4 sets of orientation)
% (2) within each set, resize and sum, resulting in 4 maps (1 for each O)
% (3) normalize the 4 resulting maps
% (4) sum the 4 normalized maps

% definitions
normalized_DEG = zeros(32,32);
output = zeros(32,32);

% for each DEG set: 1..4, for each map: 1..6
for i=1:4
    
    % set DEG_sum to zero before the start of each DEG set
    DEG_sum = zeros(32,32);
    
    % steps (1) and (2)
    for j=1:6
        normalized = normalize(orientation_feature_cells{i}{j});
        resized = resize(normalized,32);
        DEG_sum = DEG_sum + resized;
    end
    
    % steps (3) and (4)
    normalized_DEG = normalized_DEG + normalize(DEG_sum);
end

%% send output
output = normalized_DEG;

%% display orientation saliency map
 figure
 imshow(output);

