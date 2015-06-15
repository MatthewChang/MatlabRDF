width = 128;
num_items = 500000;
numTrees  = 1;
learners_to_generate = 500;
tree_height = 20;
num_pixels_per_learner = 1;
num_labels = 2;

disp('Generating Tree');
treeset = cell(1);

for i = 1:numTrees
    i
    items = [randi(width,num_items,2), randi(size(data,3),num_items,1)];
    labels = matrixSelect(data(:,:,:,2),items);
    treeset{i} = generate_tree(data(:,:,:,1),items,labels,num_labels,num_pixels_per_learner,learners_to_generate,tree_height);
end
if tree_height == 10
    save('treeset10','treeset')
else
    save('treeset20','treeset')
end
