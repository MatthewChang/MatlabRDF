width = 128;
loaed_data = [];
loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/open.avi',width,70,1));
loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/closed.avi',width,78,2));
loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/gun.avi',width,75,3));
loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/random.avi',width,85,4));
size(loaed_data)
d_s = size(loaed_data);
square_width = d_s(1);
mov = struct('cdata',zeros(square_width,square_width,3,'uint8'),...
    'colormap',[]);

for i = 1:size(loaed_data,3)
    
    frame = uint8(repmat(loaed_data(:,:,i,1),[1 1 3]))*256;
    
    mask = loaed_data(:,:,i,2);
    frame2 = repmat(loaed_data(:,:,i,2)*256,[1 1 3]);
    serial_frame2 = reshape(frame2,d_s(1)*d_s(2),3);
    serial_frame2(mask==0,:) = repmat([0,0,0],[sum(mask(:)==0) 1]);
    serial_frame2(mask==1,:) = repmat([256,256,0],[sum(mask(:)==1) 1]);
    serial_frame2(mask==2,:) = repmat([0,256,0],[sum(mask(:)==2) 1]);
    serial_frame2(mask==3,:) = repmat([0,0,256],[sum(mask(:)==3) 1]);
    serial_frame2(mask==4,:) = repmat([256,0,0],[sum(mask(:)==4) 1]);
    frame2 = reshape(serial_frame2,d_s(1),d_s(2),3);
    mov(i).cdata = cat(2,frame,frame2);
end
hf = figure;
set(hf,'position',[150 150 size(mov(1).cdata,2) square_width]);
size(mov)
movie(hf,mov,1);