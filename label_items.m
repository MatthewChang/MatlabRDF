function labels = label_items(data,treeset,items,num_labels)
    labels = zeros(size(items,1),size(treeset,2));
    for i = 1:size(treeset,2)
        labels(:,i) = label_items_tree(data,treeset{i},items,num_labels);
    end
    labels = mode(labels,2);
end