clear;
width = 128;
[hand_data,labels] = load_video_data_LAB('hands/open2.mp4',width,55,1,true);

%hand_data = cat(3,hand_data,load_video_data_hsv('hands/closed.mp4',width,100,2));
%data(1:10,:,:,:) = 0;
%data(70:75,80:90,:,:) = 256;
% hand_data2 = floor(hand_data*255 + 1);
% max(hand_data(:))

% map = colormap(gray(256));%256 as an example.
% mov = immovie(hand_data2,map);
% hf = figure;
% movie(hf,mov,1);

% 

xyloObj = VideoReader('bg/bg.mp4');
k = 1;
data = zeros(128,128,3,size(hand_data,4));
while hasFrame(xyloObj) && k <= size(hand_data,4)
    frame = readFrame(xyloObj);    
    frame = imresize(frame,[128 128]);
    I = rgb2lab(frame);
    L = I(:,:,1);
    A = I(:,:,2);
    B = I(:,:,3);
    iI = hand_data(:,:,:,k); %already image in lab form
    iL = iI(:,:,1);
    iA = iI(:,:,2);
    iB = iI(:,:,3);
    mask = labels(:,:,k);
    L(mask>0)=iL(mask>0);
    A(mask>0)=iA(mask>0);
    B(mask>0)=iB(mask>0);
    data(:,:,:,k) = cat(3,L,A,B);
    k = k+1;
end

%data(1:10,:,:,:) = 0;
%data(70:75,80:90,:,:) = 256;
%disp_data = reshape(data(:,:,:,1),128,128,1,250);

% disp_data = disp_data*255/m;
% disp_data(disp_data<1) = 1;

% map = colormap(gray(256));%256 as an example.
% mov = immovie(disp_data,map);
% hf = figure;
% movie(hf,mov,1);
save('data.mat','data','labels')
