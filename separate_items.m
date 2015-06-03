function res_labels = separate_items(data,items,nl)
        width = size(data,1);
        num_items = size(items,1);
        o1 = nl(1:2);
        o1 = o1(ones(num_items,1),:);
        o2 = nl(3:4);
        o2 = o2(ones(num_items,1),:);
        offset_values1 = [items(:,1:2)+o1 items(:,3)];
        offset_values2 = [items(:,1:2)+o2 items(:,3)];
        
        %thresholding
        offset_values1(offset_values1<1) = 1;
        offset_values1(offset_values1>width) = width;
        offset_values2(offset_values2<1) = 1;
        offset_values2(offset_values2>width) = width;
        
        feature1 = matrixSelect(data,offset_values1);
        feature2 = matrixSelect(data,offset_values2);
        res_labels = feature1+2*feature2;

        res_labels(res_labels~=nl(5)) = -1;
        res_labels(res_labels==nl(5)) = 1;
        res_labels(res_labels==-1) = 0;
end

