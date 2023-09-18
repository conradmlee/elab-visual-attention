%% this function computes the master saliency map by normalizing then
%% averaging the 3 feature saliency maps (I, C, and O)
function output = saliency_map(intensity_saliency_cells,color_saliency_cells,orientation_saliency_cells)

%% normalize and average
total_avg = (normalize(intensity_saliency_cells) + normalize(color_saliency_cells) + normalize(orientation_saliency_cells))/3;

%% make edges black
for i=1:32;
    total_avg(i,1) = 0.0001;
    total_avg(i,32) = 0.0001;
    total_avg(1,i) = 0.0001;
    total_avg(32,i) = 0.0001;
end

%% send output
output = total_avg;

%% display master saliency map
figure
imshow(output);