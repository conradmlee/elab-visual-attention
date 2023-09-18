%% this function finds the index of the max value from the saliency map then
%% draws a circle on the input image
function output = find_max(A, img)

%% 512 / 32 = 16, so use 14.5 as the conversion from saliency map to input image
%% factors to consider: (1) minus 8 to get it centered (2) bottom-right
%% shift due to normalization/decimation (note: this is just an error
%% correction estimate)

%% display image without circles first
figure
image(img/255);

for i=1:10
    % find index of max value
    [R,C] = find(A==max(A(:)));
    
    % convert from scale 4 to scale 0
    R_input = (R*14.5);
    C_input = (C*14.5);
    
    % draw circle at max value
    rectangle
    rectangle('Position',[C_input,R_input,32,32],'Curvature',[1,1],'EdgeColor',[1 0.1*i 0],'LineWidth',2);
    daspect([1,1,1]);
    
    % pause to press enter before moving to next max
    pause
    
    % send output (max value)
    output = [R,C];
    
    % set previous max to 0 (inhibition of return)
    A(R,C) = 0;
    
%   % set previous max and immediate surrounding cells to 0
%     for j=-1:1
%         for k=-1:1
%             if R+j < 0
%             elseif C+k < 0
%             else
%             A(R+j,C+k) = 0;
%             end
%         end
%     end
end