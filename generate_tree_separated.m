function node = generate_tree_separated(item_labels,seprated_all,learners,height,depth)
    num_learners = size(learners,1);
    total_entropy = entropy_from_labels(item_labels);
    if total_entropy == 0 || depth >= height
        node = tree_node;
        node.label = mode(item_labels(:));
        return
    end
    entropy_decrease = ones(num_learners,1);
    possible_labels = unique(item_labels);
    for i = 1:num_learners
        res_labels = seprated_all(:,i);
        
        decided_true_labels = item_labels(res_labels==1,:);
        decided_false_labels = item_labels(res_labels==0,:);
        true_label_counts = label_counts(decided_true_labels,possible_labels);
        false_label_counts = label_counts(decided_false_labels,possible_labels);
        count_matrix = [true_label_counts';false_label_counts'];
        e = entropy2(count_matrix);
        entropy_decrease(i) = total_entropy-e;
    end
    [m,i] = max(entropy_decrease);
    if(m == 0)
        node = tree_node;
        node.label = mode(item_labels(:));
        return
    end
    best_separation = seprated_all(:,i);
    positive_id_labels = item_labels(best_separation==1);
    negative_id_labels = item_labels(best_separation==0);
    positive_separation = seprated_all(best_separation==1,:);
    negative_separation = seprated_all(best_separation==0,:);
    node = tree_node;
    node.learner = learners(i,:,:);
    node.true_node = generate_tree_separated(positive_id_labels,positive_separation,learners,height,depth+1);
    node.false_node = generate_tree_separated(negative_id_labels,negative_separation,learners,height,depth+1);
end

