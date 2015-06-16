function res_labels = separate_items(data,items,nl)
        width = size(data,1);
        num_items = size(items,1);
        
        o = reshape(nl(1,1,1:2),1,2);
        o = o(ones(num_items,1),:);
        offset_values = [items(:,1:2)+o items(:,3)];
        offset_values(:,1:2) = mod(offset_values(:,1:2)-1,width)+1;
        L_items = [items(:,1:2), ones(num_items,1),items(:,3)];
        A_items = [items(:,1:2), ones(num_items,1)*2,items(:,3)];
        B_items = [items(:,1:2), ones(num_items,1)*3,items(:,3)];
        L_offset_items = [offset_values(:,1:2), ones(num_items,1),items(:,3)]; 
        A_offset_items = [offset_values(:,1:2), ones(num_items,1)*2,items(:,3)];
        B_offset_items = [offset_values(:,1:2), ones(num_items,1)*3,items(:,3)];
        L_diff = matrixSelect(data,L_items)-matrixSelect(data,L_offset_items);
        A_diff = matrixSelect(data,A_items)-matrixSelect(data,A_offset_items);
        B_diff = matrixSelect(data,B_items)-matrixSelect(data,B_offset_items);
        L2 = L_diff.*L_diff;
        A2 = A_diff.*A_diff;
        B2 = B_diff.*B_diff;
        feature = sqrt(L2+A2+B2);
        res_labels = feature>=nl(3);
%         feature = zeros(num_items,1);
%         learner_value = 0;
%         d=1;
%         for i = 1:numLearnerPoints
%             learner_value = learner_value + nl(:,i,3)*d;
%             feature(:,:) = feature(:,:) + matrixSelect(data,offset_values(:,:,i))*d;
%             d=d*num_labels;
%         end
%         res_labels = feature;
%         res_labels(res_labels~=learner_value) = -1;
%         res_labels(res_labels==learner_value) = 1;
%         res_labels(res_labels==-1) = 0;
end

