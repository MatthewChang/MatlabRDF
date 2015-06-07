function res = unique_counts(A)
    u = unique(A);
    res = label_counts(A,u);
end

