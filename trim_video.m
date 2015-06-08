in_file = 'videos/random.mp4';
out_file = 'trimmed_videos/random.avi';


xyloObj = VideoReader(in_file);
get(xyloObj)
vidWidth = xyloObj.Width;
vidHeight = xyloObj.Height;

mov = struct('cdata',zeros(square_width,square_width,3,'uint8'),...
    'colormap',[]);
k = 1;
while hasFrame(xyloObj)
    mov(k).cdata = readFrame(xyloObj);
    k = k+1;
end
hf = figure;
set(hf,'position',[150 150 xyloObj.Width xyloObj.Height]);
mov = [mov(10:end-60)];
movie(hf,mov,1,xyloObj.FrameRate);

writerObj = VideoWriter(out_file);
writerObj.FrameRate = xyloObj.FrameRate;
open(writerObj);
for k = 1:size(mov,2)
   frame = mov(k).cdata;
   writeVideo(writerObj,frame);
end

close(writerObj);

