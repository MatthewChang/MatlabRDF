function node = generate_tree(data,items,learners,labels,height)
    seperations = generate_separations(data,items,learners);
    node = generate_tree_separated(labels,seperations,learners,height,0);
end

