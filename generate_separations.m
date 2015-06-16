function separated_items = generate_separations(data,items,learners)
    width = size(data,1);
    num_items = size(items,1);
    num_learners = size(learners,1);
    separated_items = zeros(num_items,num_learners);
    for i = 1:num_learners
        i;
        separated_items(:,i) = separate_items(data,items,learners(i,:,:));
    end
end

