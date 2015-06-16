function labels = label_items_tree(data,tree,items,num_labels)
    if isequal(tree.true_node,[])
        labels = ones(size(items,1),1)*tree.label;
        return
    end
    separation = separate_items(data,items,tree.learner);
    labels = zeros(size(items,1),1);
    positive_id_items = items(separation==1,:);
    negative_id_items = items(separation==0,:);
    positive_labels = label_items_tree(data,tree.true_node,positive_id_items,num_labels);
    negative_labels = label_items_tree(data,tree.false_node,negative_id_items,num_labels);
    labels(separation==1,:) = positive_labels;
    labels(separation==0,:) = negative_labels;
end