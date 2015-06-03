clear
use_cached_data = false;
use_cached_learners = false;
learners_to_generate = 100;
show_data = false;
width = 128;

if ~exist('data.mat','file') || ~use_cached_data
    disp('Loading Image Data')
    imgPath = './open/';
    imgType = '*.JPG'; % change based on image type
    images  = dir([imgPath imgType]);
    data = [];
    num_loaded = 0;
    %data, pixels, number, 1 = hand, 2 = label
    for idx = 1:length(images)
        num_loaded = num_loaded + 1;
        val = imcrop(imread([imgPath images(idx).name]),[300,100,499,499]);
        val = imresize(val, [width width]);
        val = rgb2gray(val);
        val(val<150) = 0;
        val(val>=150) = 1;
        data(:,:,num_loaded,1) = val;
        data(:,:,num_loaded,2) = val;
    end

    imgPath = './closed/';
    imgType = '*.JPG'; % change based on image type
    images  = dir([imgPath imgType]);
    for idx = 1:length(images)
        num_loaded = num_loaded + 1;
        val = imcrop(imread([imgPath images(idx).name]),[230,100,499,499]);
        val = imresize(val, [width width]);
        val = rgb2gray(val);
        val(val<180) = 0;
        val(val>=180) = 1;
        data(:,:,num_loaded,1) = val;
        data(:,:,num_loaded,2) = zeros(width,width);
    end
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
if ~exist('learners.mat','file') || ~use_cached_learners
    disp('Generating Learners')
    learners = [];
    for i = 1:learners_to_generate
        learners(end+1,:,:) = randomFeature();
    end
    save('learners.mat','learners')
else    
    disp('Using Cached Learners')
    load('learners.mat')
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
    treeset{i} = generate_tree(data(:,:,:,1),items,labels,learners);
end
save('treeset','treeset')