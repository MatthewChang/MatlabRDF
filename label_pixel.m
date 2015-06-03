function l = label_pixel(data,pixel,tree)
    width = size(data,1);
    
    while ~isequal(tree.true_node,[])
        nl = tree.learner;
        numPixels = size(nl,2);
        
        offset_values = reshape(nl(:,:,1:2),numPixels,2);
        offset_values = offset_values + pixel(ones(numPixels,1),:);
        offset_values(offset_values<1) = 1;
        offset_values(offset_values>width) = width;
        
        val = matrixSelect(data,offset_values);
        if(isequal(val',nl(:,:,3)))
            tree = tree.true_node;
        else
            tree = tree.false_node;
        end
    end
    l = tree.label;
end

