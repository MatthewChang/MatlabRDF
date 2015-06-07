function e = entropy_from_labels(A)
    e = entropy(unique_counts(A));
end

