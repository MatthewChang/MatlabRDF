function [root,next] = buildTreeFromSerial(vals,start)
    if(nargin<2)
        start = 1;
    end
    root = tree_node;
    if vals(start,3)==-1
        root.label = vals(start,1);
        next = start+1;
        return;
    end
    root.learner = reshape(vals(start,:),1,1,3);
    [root.false_node,next] = buildTreeFromSerial(vals,start+1);
    [root.true_node,next] = buildTreeFromSerial(vals,next);
    return
end
