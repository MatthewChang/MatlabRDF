function l = label_pixel(data,pixel,tree)
    width = size(data,1);
    while ~isequal(tree.true_node,[])
        learner = tree.learner;
        offset_values1 = [pixel+learner(1:2)];
        offset_values2 = [pixel+learner(3:4)];
        
        %thresholding
        offset_values1(offset_values1<1) = 1;
        offset_values1(offset_values1>width) = width;
        offset_values2(offset_values2<1) = 1;
        offset_values2(offset_values2>width) = width;
        
        val1 = matrixSelect(data,offset_values1);
        val2 = matrixSelect(data,offset_values2);
        
        res = val1+val2*2;
        if(res==learner(5))
            tree = tree.true_node;
        else
            tree = tree.false_node;
        end
    end
    l = tree.label;
end

