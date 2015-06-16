width = 128;
num_items = 20000;
numTrees  = 1;
learners_to_generate = 100;
tree_height = 10;
num_pixels_per_learner = 1;
num_labels = 2;

disp('Generating Tree');
treeset = cell(1);

learners = zeros(learners_to_generate,1,3);
for i = 1:learners_to_generate
        learners(i,:,:)=reshape(normalRandomFeature(width,num_labels,1),[1 3]);
end
    
for i = 1:numTrees
    i
    items = [randi(width,num_items,2), randi(size(data,4),num_items,1)];
    item_labels = matrixSelect(labels,items);
    treeset{i} = generate_tree(data,items,learners,item_labels,tree_height);
end
if tree_height == 10
    save('treeset10','treeset')
else
    save('treeset20','treeset')
end
