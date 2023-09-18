%% this function creates 24 feature maps for orientation
function output = orientation_feature_maps(orientation_pyramids_cells)

%% define parameters
in_scale = [2 2 3 3 4 4];
out_size = [32 64 64 128 128 256];
surround = [5 6 6 7 7 8];

%% preallocate for speed
out = cell(256,256,6);
output = cell(256,256,6,4);

%% i varies DEG (from 1 to 4, aka DEG_0 to DEG_135)
for i=1:4
    
    %% j varies the other parameters
    % remember to take absolute value after across-scale subtraction!
    for j=1:6
        resized = resize(orientation_pyramids_cells{i}{in_scale(j)},out_size(j));
        subtracted = abs(resized - orientation_pyramids_cells{i}{surround(j)});
        
        %% display 4 sets of 6 images
        % figure
        % imshow(subtracted);
        
        %% 6 images per DEG
        out(j) = {subtracted};
    end
    
    %% 4 DEG with 6 images in each
    output(i) = {out};
end