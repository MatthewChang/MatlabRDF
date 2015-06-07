function miss = miss_bins(data,tree,items,labels,num_labels)
    if isequal(tree.true_node,[])
        miss = sum(labels==tree.label);
        return
    end
    separation = separate_items(data,items,tree.learner,num_labels);
    positive_id_items = items(separation==1,:);
    positive_id_labels = labels(separation==1);
    negative_id_items = items(separation==0,:);
    negative_id_labels = labels(separation==0);
    miss = miss_bins(data,tree.true_node,positive_id_items,positive_id_labels,num_labels);
    miss = miss+miss_bins(data,tree.false_node,negative_id_items,negative_id_labels,num_labels);
end