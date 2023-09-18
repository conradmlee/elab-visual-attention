function res = normalize(A)

min_A = min(min(A));
max_A = max(max(A));
[n m] = size(A);

M = 1;
if ((max_A - min_A) < 10^-15)
    res = zeros(n,m);
    return
end
A_ = ((A - min_A)/(max_A - min_A))*M;

loc_max=0;
r = 1;
% go over all elements in A_
for i = 1:n
    for j = 1:m
        is_local_max = 1;
        % check if one of the neigbors is larger
        for k = max(1, i-1):min(n, i+1)
            for l = max(1, j-1):min(m, j+1)
                if (A_(k, l) > A_(i,j))
                    is_local_max = 0;
                end
            end
        end
        if ((is_local_max == 1) && (A_(i, j) < M))
            loc_max(r) = A_(i, j);
            r = r+1;
        end
    end
end

avg_loc_max = mean(loc_max);

res = A_* (M - avg_loc_max)^2;
