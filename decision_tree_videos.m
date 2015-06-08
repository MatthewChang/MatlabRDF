clear
use_cached_data = false;
use_cached_learners = false;
width = 50;
num_items = 50000;
numTrees  = 3;
learners_to_generate = 100;
tree_height = 15;
num_pixels_per_learner = 1;
num_labels = 5;


if ~exist('data.mat','file') || ~use_cached_data
    disp('Loading Image Data')
    data = [];
    data = cat(3,data,load_video_data('trimmed_videos/open.avi',width,70,1));
    data = cat(3,data,load_video_data('trimmed_videos/closed.avi',width,78,2));
    data = cat(3,data,load_video_data('trimmed_videos/gun.avi',width,75,3));
    data = cat(3,data,load_video_data('trimmed_videos/random.avi',width,85,4));
    
    size(data)
    save('data.mat','data')
else
    disp('Using Data Cache')
    load('data.mat')
end

disp('Generating Items');

items = [randi(width,num_items,2), randi(size(data,3),num_items,1)];
labels = matrixSelect(data(:,:,:,2),items);
disp('Generating Tree');
treeset = cell(1);

for i = 1:numTrees
    i
    items = [randi(width,num_items,2), randi(size(data,3),num_items,1)];
    labels = matrixSelect(data(:,:,:,2),items);
    treeset{i} = generate_tree(data(:,:,:,1),items,labels,num_labels,num_pixels_per_learner,learners_to_generate,tree_height);
end
save('treeset','treeset')