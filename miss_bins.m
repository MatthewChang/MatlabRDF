function miss = miss_bins(data,tree,items,labels)
    if isequal(tree.true_node,[])
        l = ones(size(labels,1),1)*tree.label;
        miss = 0;
        if size(labels,1) > 0
            miss = sum(labels~=l);
        end
        return
    end
    separation = separate_items(data,items,tree.learner);
    positive_id_items = items(separation==1,:);
    positive_id_labels = labels(separation==1);
    negative_id_items = items(separation==0,:);
    negative_id_labels = labels(separation==0);
    miss = miss_bins(data,tree.true_node,positive_id_items,positive_id_labels);
    miss = miss+miss_bins(data,tree.false_node,negative_id_items,negative_id_labels);
end