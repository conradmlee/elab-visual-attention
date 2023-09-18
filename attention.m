function attention
global RED GREEN BLUE YELLOW DEG_0 DEG_45 DEG_90 DEG_135
RED    = 1;
GREEN  = 2;
BLUE   = 3;
YELLOW = 4;

DEG_0   = 1;
DEG_45  = 2;
DEG_90  = 3;
DEG_135 = 4;

%% input must be 512 x 512 image
input = double(imread('shark512.png'));
gray_input = (input(:,:,1)+input(:,:,2)+input(:,:,3))/3;

%% make gaussian pyramids, scales 1 to 9
intensity_pyramids_cells = make_pyramids(gray_input); % {indx}, indx = 1..9
color_pyramids_cells = color_pyramids(input, gray_input); % {RED}{indx}
orientation_pyramids_cells = orientation_pyramids(gray_input); % {DEG_0}{indx}

%% compute feature maps
intensity_feature_cells = intensity_feature_maps(intensity_pyramids_cells); % {indx}, indx = 1..6
color_feature_cells  = color_feature_maps(color_pyramids_cells); % {indx}, indx = 1..12
orientation_feature_cells = orientation_feature_maps(orientation_pyramids_cells);

%% compute individual saliency maps
intensity_saliency_cells = intensity_saliency(intensity_feature_cells);
color_saliency_cells = color_saliency(color_feature_cells);
orientation_saliency_cells = orientation_saliency(orientation_feature_cells);
 
%% compute master saliency map
saliency_map_cells = saliency_map(intensity_saliency_cells,color_saliency_cells,orientation_saliency_cells);

%% find index of max value from saliency map, and draw a circle on input image
find_max_cells = find_max(saliency_map_cells, input);

%% need debugging:
% 1. image seems to be drifting towards the bottom right, see Dirk Walther
% 2. Need DoG filter: difference of gaussians?
% 3. (done) get it to loop through several points
% 4. get it to cut out 75% of the image to black
% 5. (corrected) initialize size of variables first to prevent reallocation
% 6. (corrected) some confusion with scale levels, here used 1..9 not itti 0..8

%% good test images 512 x 512
% all: hiker512, faces512, panda512
% also: shark512, moon512, carina512, galaxy512, plane512
% intensity: carlights512, shark512, galaxy512
% color: iou512, faces512, carina512
% orientation: aircraft512, moon512, spock