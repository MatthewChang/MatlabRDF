function node = generate_tree(data,items,item_labels,num_labels,num_pixels_per_learner,numLearners,height,depth)
    if(nargin < 8)
        depth = 0;
    end
    width = size(data,1);
    learners = zeros(numLearners,num_pixels_per_learner,3);
    for i = 1:numLearners
        learners(i,:,:)=normalRandomFeature(width,num_labels,num_pixels_per_learner);
    end
    total_entropy = entropy_from_labels(item_labels);
    if total_entropy == 0 || depth > height
        node = tree_node;
        node.label = mode(item_labels(:));
        return
    end
    entropy_decrease = ones(size(learners,1),1);
    possible_labels = unique(item_labels);
    for i = 1:numLearners
        res_labels = separate_items(data,items,learners(i,:,:));
        decided_true_labels = item_labels(res_labels==1,:);
        decided_false_labels = item_labels(res_labels==0,:);
        true_label_counts = label_counts(decided_true_labels,possible_labels);
        false_label_counts = label_counts(decided_false_labels,possible_labels);
        count_matrix = [true_label_counts';false_label_counts'];
        e = entropy2(count_matrix);
%         tt = sum(res_labels.*labels);
%         tf = sum(res_labels.*(1-labels));
%         ft = sum((1-res_labels).*labels);
%         ff = sum((1-res_labels).*(1-labels));
%         e = entropy2([tt,tf;ft,ff]);
        entropy_decrease(i) = total_entropy-e;
    end
    [~,i] = max(entropy_decrease);
    best_separation = separate_items(data,items,learners(i,:,:));
    positive_id_items = items(best_separation==1,:);
    positive_id_labels = item_labels(best_separation==1);
    negative_id_items = items(best_separation==0,:);
    negative_id_labels = item_labels(best_separation==0);
    node = tree_node;
    node.learner = learners(i,:,:);
    node.true_node = generate_tree(data,positive_id_items,positive_id_labels,num_labels,num_pixels_per_learner,numLearners,height,depth+1);
    node.false_node = generate_tree(data,negative_id_items,negative_id_labels,num_labels,num_pixels_per_learner,numLearners,height,depth+1);
end

