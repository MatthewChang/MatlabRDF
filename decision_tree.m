if ~exist('data.mat','file')
    disp('Loading Image Data')
    imgPath = './open/';
    imgType = '*.JPG'; % change based on image type
    images  = dir([imgPath imgType]);
    data = [];
    num_loaded = 0
    %data, pixels, number, 1 = hand, 2 = label
    for idx = 1:length(images)
        num_loaded = num_loaded + 1;
        val = imcrop(imread([imgPath images(idx).name]),[300,100,499,499]);
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
        val = rgb2gray(val);
        val(val<180) = 0;
        val(val>=180) = 1;
        data(:,:,num_loaded,1) = val;
        data(:,:,num_loaded,2) = zeros(500,500);
    end
    size(data)
    data(:,:,18,1);
    imshow(data(:,:,1,1)*256)
    save('data.mat','data')
else
    disp('Using Data Cache')
    load('data.mat')
end

numLearners = 1000;
if ~exist('learners.mat','file')
    disp('Generating Learners')
    learners = [];
    for i = 1:numLearners
        learners(end+1,:) = randomFeature();
    end
    save('learners.mat','learners')
else    
    disp('Using Cached Learners')
    load('learners.mat')
end

% for i = 1:2:numLearners*2
%     offsets = learners(i:i+1,1:2);
%     selector = learners(i:i+1,3);
%     newlearners(end+1,:) = [offsets(:)', selector(1) + selector(2)*2];
% end
% learners(1:40,:)
% newlearners(1:20,:)

temp = data(:,:,1,2);
a = [sum(temp(:)), 500*500-sum(temp(:))];
init_entropy = entropy(a);
entropy_decrease = zeros(numLearners,1);

labels = data(:,:,:,2);
labels_serial = labels(:);
s = size(labels_serial);
a = [sum(labels_serial), s(1)-sum(temp(:))];
total_entropy = entropy(a);
for i = 1:numLearners
    nl = learners(i,:);
    offset1 = translate(temp,-nl(1),-nl(2));
    offset2 = translate(temp,-nl(3),-nl(4));
    offset3 = offset1 + offset2*2;
    offset3(offset3~=nl(5)) = -1;
    offset3(offset3==nl(5)) = 1;
    offset3(offset3==-1) = 0;
%     isequal(res,offset3)
%     subplot(1,2,1), subimage(res)
%     subplot(1,2,2), subimage(offset3)
%     pause
    res = offset3;
    hh = sum(res(:).*temp(:));
    hn = sum(res(:).*(1-temp(:)));
    nh = sum((1-res(:)).*temp(:));
    nn = sum((1-res(:)).*(1-temp(:)));
    e = entropy2([hh,hn;nh,nn]);
    entropy_decrease(i) = init_entropy-e;
end
[m,i] = max(entropy_decrease)
learners(i,:)
init_entropy
