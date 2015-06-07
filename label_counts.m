function res = label_counts(A,u)
    u = u(:);
    res = zeros(size(u));
    for i = 1:size(u,1)
        res(i) = sum(A==u(i));
    end
end

