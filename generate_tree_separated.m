function node = generate_tree_separated(items_mask,item_labels,seprated_all,learners,height,depth)
    num_learners = size(learners,1);
    reduced_labels = item_labels(items_mask==1);
    total_entropy = entropy_from_labels(reduced_labels);
    if total_entropy == 0 || depth >= height
        node = tree_node;
        node.label = mode(reduced_labels(:));
        return
    end
    entropy_decrease = ones(num_learners,1);
    possible_labels = unique(reduced_labels);    
    for i = 1:num_learners
        A = seprated_all(:,i);
        res_labels = A(items_mask==1);
        decided_true_labels = reduced_labels(res_labels==1,:);
        decided_false_labels = reduced_labels(res_labels==0,:);
        true_label_counts = label_counts(decided_true_labels,possible_labels);
        false_label_counts = label_counts(decided_false_labels,possible_labels);
        count_matrix = [true_label_counts';false_label_counts'];
        e = entropy2(count_matrix);
        entropy_decrease(i) = total_entropy-e;
    end
    [m,i] = max(entropy_decrease);
    if(m == 0)
        node = tree_node;
        node.label = mode(reduced_labels(:));
        return
    end
    best_separation = seprated_all(:,i);
    positive_id_mask = best_separation.*items_mask;
    negative_id_mask = (1-best_separation).*items_mask;
    node = tree_node;
    node.learner = learners(i,:,:);
    node.true_node = generate_tree_separated(positive_id_mask,item_labels,seprated_all,learners,height,depth+1);
    node.false_node = generate_tree_separated(negative_id_mask,item_labels,seprated_all,learners,height,depth+1);
end

