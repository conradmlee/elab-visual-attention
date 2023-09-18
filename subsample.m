function output = subsample(A, step, out_dim)

output = zeros(out_dim,out_dim);

for ind_x = 1:out_dim
    for ind_y = 1:out_dim
        B_ind_x = (ind_x - 1)*step + 1;
        B_ind_y = (ind_y - 1)*step + 1;
            
        B = A (B_ind_x:(B_ind_x + step - 1), B_ind_y:(B_ind_y + step - 1));
        output(ind_x, ind_y) = mean(mean(B));
    end
end
