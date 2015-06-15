function l = label_pixel(data,pixel,tree)
    node = tree;    
    while ~isequal(node.true_node,[])
        n = mod(pixel+[node.learner(1) node.learner(2)]-1,128)+1;
        feature = abs(matrixSelect(data,n) - matrixSelect(data,pixel));
        if(feature > 127)
            feature = 255-feature;
        end
        if(feature >= node.learner(3))
            node = node.true_node;
        else
            node = node.false_node;
        end
    end
    l = node.label;
end

