clear
use_cached_data = false;
use_cached_learners = false;
learners_to_generate = 100;
show_data = false;
width = 128;
num_labels = 4;

closed_label = 1;
gun_label = 2;
open_label = 3;
none_label = 0;

if ~exist('data.mat','file') || ~use_cached_data
    disp('Loading Image Data')
    load('matlabVideos/closed');
    load('matlabVideos/gun');
    load('matlabVideos/open');
    load('matlabVideos/random');
    data(:,:,:,1) = closedHandFrames;
    data(:,:,:,2) = closedHandFrames*closed_label;
    
    next = gunHandFrames;
    next(:,:,:,2) = gunHandFrames*gun_label;
    data = cat(3,data,next);
    
    next = openHandFrames;
    next(:,:,:,2) = openHandFrames*open_label;
    data = cat(3,data,next);
    
    next = randomHandFrames;
    next(:,:,:,2) = randomHandFrames*none_label;
    data = cat(3,data,next);
    
    size(data)
    save('data.mat','data')
else
    disp('Using Data Cache')
    load('data.mat')
end
if show_data
    for i = 1:size(data,3)
        i
        subplot(1,2,1), subimage(data(:,:,i,1))
        subplot(1,2,2), subimage(data(:,:,i,2))
        pause
    end
end

disp('Generating Items');
num_items = 50000;
items = [randi(width,num_items,2), randi(size(data,3),num_items,1)];
labels = matrixSelect(data(:,:,:,2),items);
disp('Generating Tree');
treeset = cell(1);
numTrees  = 1;
for i = 1:numTrees
    i
    items = [randi(width,num_items,2), randi(size(data,3),num_items,1)];
    labels = matrixSelect(data(:,:,:,2),items);
    treeset{i} = generate_tree(data(:,:,:,1),items,labels,num_labels);
end
save('treeset','treeset')