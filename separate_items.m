function res_labels = separate_items(data,items,nl,num_labels)
        width = size(data,1);
        num_items = size(items,1);        
        numLearnerPoints = size(nl,2);
        
        offset_values = [];
        for i = 1:numLearnerPoints
            o = reshape(nl(:,i,1:2),1,2);
            o = o(ones(num_items,1),:);
            offset_values(:,:,i) = [items(:,1:2)+o items(:,3)];
        end
        offset_values(:,1:2,:) = mod(offset_values(:,1:2,:)-1,width)+1;
                
        feature = zeros(num_items,1);
        learner_value = 0;
        d=1;
        for i = 1:numLearnerPoints
            learner_value = learner_value + nl(:,i,3)*d;
            feature(:,:) = feature(:,:) + matrixSelect(data,offset_values(:,:,i))*d;
            d=d*num_labels;
        end
        res_labels = feature;
        res_labels(res_labels~=learner_value) = -1;
        res_labels(res_labels==learner_value) = 1;
        res_labels(res_labels==-1) = 0;
end

