function r = testing(final_tree)
    function h = tree_height(node)
        if isequal(node.true_node,[])
            h = 1;
            return
        end
        h = 1+max(tree_height(node.true_node),tree_height(node.false_node));
    end
    tree_height(final_tree)
end