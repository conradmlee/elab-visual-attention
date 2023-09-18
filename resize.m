%% this function takes one image level and converts it to another level
function output = resize(input_level, out_dim)

%% define output matrix
output = zeros(out_dim,out_dim);

%% get size of input image level
size_input = size(input_level);

%% compare input and output dimension, then subsample, enlarge, or leave
if size_input > out_dim
    %% subsample
    output = subsample(input_level,2,out_dim);
    
elseif size_input < out_dim
    %% enlarge: use function imresize(A,[m n],'box') // use box or bicubic
    output = imresize(input_level,[out_dim out_dim],'box');
    
else
    %% leave
    output = input_level;
end