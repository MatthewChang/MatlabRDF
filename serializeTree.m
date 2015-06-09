function result = serializeTree(node)
    result = [];
    if isequal(node.true_node,[])
        result = [node.label -1 -1];
        return
    end
    l = reshape(node.learner,1,3);
    result = [l;serializeTree(node.false_node);serializeTree(node.true_node)];
end
