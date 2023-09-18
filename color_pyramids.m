%% this function creates a set of gaussian pyramids for color
function output = color_pyramids(input, I)

global RED BLUE GREEN YELLOW

% RED = 1;
% GREEN = 2;
% BLUE = 3;
% YELLOW = 4;

%% define I (aka gray_input or intensity) and maximum I (over image)
%I = (input(:,:,1)+input(:,:,2)+input(:,:,3))/3;
maxI = max(max(I));

%% define input size and empty normalized/decoupled input matrix
Ax = size(input,1);
Ay = size(input,2);
Az = size(input,3);
norm_input = zeros(Ax,Ay,Az);

%% normalize r, g, and b channels by I (to decouple hue from intensity)
for d=1:3
    for x=1:Ax
        for y=1:Ay
            if I(x,y) > maxI/10
                norm_input(x,y,d) = input(x,y,d)/I(x,y);
            else
                norm_input(x,y,d) = 0;
            end
        end
    end
end

%% display normalized image
% figure
% imshow(norm_input);

%% define Red, Green, Blue, and Yellow color channels
Red = zeros(Ax,Ay);
Green = zeros(Ax,Ay);
Blue = zeros(Ax,Ay);
Yellow = zeros(Ax,Ay);

%% calculate R, G, B, Y
for x=1:Ax
    for y=1:Ay
        Red(x,y) = norm_input(x,y,1) - (norm_input(x,y,2) + norm_input(x,y,3))/2;
        Green(x,y) = norm_input(x,y,2) - (norm_input(x,y,1) + norm_input(x,y,3))/2;
        Blue(x,y) = norm_input(x,y,3) - (norm_input(x,y,1) + norm_input(x,y,2))/2;
        Yellow(x,y) = ((norm_input(x,y,1) + norm_input(x,y,2))/2) - (abs(norm_input(x,y,1) - norm_input(x,y,2))/2) - norm_input(x,y,3);
    end
end

%% display R, G, B, Y color channels
% figure
% imshow(Red)
% figure
% imshow(Green)
% figure
% imshow(Blue)
% figure
% imshow(Yellow)

%% create 4 sets of pyramids for R, G, B, Y color channels
output(RED) = {make_pyramids(Red)};
output(GREEN) = {make_pyramids(Green)};
output(BLUE) = {make_pyramids(Blue)};
output(YELLOW) = {make_pyramids(Yellow)};

