clear;
xyloObj = VideoReader('hands/closed.mp4');
k = 1;
hand_data=double(ones(128,128,1,1));
while hasFrame(xyloObj) && k <= 250
    frame = readFrame(xyloObj);   
    frame = rgb2gray(frame);
    frame = imresize(frame,[128 128]);
    hand_data(:,:,1,k) = frame;
    k = k+1;
end
%data(1:10,:,:,:) = 0;
%data(70:75,80:90,:,:) = 256;
hand_data(hand_data<1) = 1;
thresh = 100;
hand_mask = hand_data;
hand_mask(hand_mask<thresh) = 0;
hand_mask(hand_mask>=thresh) = 1;

% map = colormap(gray(256));%256 as an example.
% mov = immovie(hand_data,map);
% hf = figure;
% movie(hf,mov,1);

xyloObj = VideoReader('bg/bg.mp4');
k = 1;
data = zeros(128,128,250,2);
while hasFrame(xyloObj) && k <= 250
    frame = readFrame(xyloObj);   
    frame = rgb2gray(frame);
    frame = imresize(frame,[128 128]);
    A = hand_data(:,:,1,k);
    mask = hand_mask(:,:,1,k);
    frame(mask>0)=A(mask>0);
    data(:,:,k,1) = imgradient(frame,'sobel');
    data(:,:,k,2) = mask;
    k = k+1;
end
%data(1:10,:,:,:) = 0;
%data(70:75,80:90,:,:) = 256;
disp_data = reshape(data(:,:,:,1),128,128,1,250);
m = max(disp_data(:));
disp_data = disp_data*255/m;
disp_data(disp_data<1) = 1;

% map = colormap(gray(256));%256 as an example.
% mov = immovie(disp_data,map);
% hf = figure;
% movie(hf,mov,1);
save('data.mat','data')
