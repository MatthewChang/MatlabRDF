xyloObj = VideoReader('videos/closed.mp4');
get(xyloObj)
vidWidth = xyloObj.Width;
vidHeight = xyloObj.Height;

square_width = 128;
mov = struct('cdata',zeros(square_width,square_width,3,'uint8'),...
    'colormap',[]);
k = 1;
result = [];
while hasFrame(xyloObj)
    frame = readFrame(xyloObj);
    frame = imresize(frame,[square_width,square_width]);
    frame = rgb2gray(frame);
    frame = repmat(frame,[1 1 3]);
    thresh = 80;
    frame(frame<thresh) = 0;
    frame(frame>=thresh) = 256;
    frame(:,1:20,:) = zeros(width,20,3);
    mov(k).cdata = frame;
    result(:,:,k) = frame(:,:,1)/256;
    k = k+1;
end
hf = figure;
set(hf,'position',[150 150 square_width square_width]);
mov = [mov(30:end-30)];
movie(hf,mov,1,xyloObj.FrameRate);
size(result)
closedHandFrames = result;
save('matlabVideos/closed','closedHandFrames');
