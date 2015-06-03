function node = generate_tree(data,items,labels,learners,depth)
    if(nargin < 5)
        depth = 0;
    end
    learners = [];
    for i = 1:5000
        learners(end+1,:,:) = normalRandomFeature();
    end
    
    a = [sum(labels) numel(labels)-sum(labels)];
    total_entropy = entropy(a);
    if total_entropy == 0 || depth > 10
        node = tree_node;
        node.label = mode(labels(:));
        return
    end
    numLearners = size(learners,1);
    entropy_decrease = ones(size(learners,1),1);
    for i = 1:numLearners
        res_labels = separate_items(data,items,learners(i,:,:));
        
        %use find(A==1) with A being the combined matricies to get indices
        %to separate out lower levels
        tt = sum(res_labels.*labels);
        tf = sum(res_labels.*(1-labels));
        ft = sum((1-res_labels).*labels);
        ff = sum((1-res_labels).*(1-labels));
        e = entropy2([tt,tf;ft,ff]);
        entropy_decrease(i) = total_entropy-e;
    end
    [~,i] = max(entropy_decrease);
    best_separation = separate_items(data,items,learners(i,:,:));
    positive_id_items = items(best_separation==1,:);
    positive_id_labels = labels(best_separation==1);
    negative_id_items = items(best_separation==0,:);
    negative_id_labels = labels(best_separation==0);
    node = tree_node;
    node.learner = learners(i,:,:);
    node.true_node = generate_tree(data,positive_id_items,positive_id_labels,learners,depth+1);
    node.false_node = generate_tree(data,negative_id_items,negative_id_labels,learners,depth+1);
end

