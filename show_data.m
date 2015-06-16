width = 128;
%loaded_data = []
%//loaded_data = load_video_data('trimmed_videos/open.avi',width,70,1);
% loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/open.avi',width,70,1));
% loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/closed.avi',width,78,2));
% loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/gun.avi',width,75,3));
% loaed_data = cat(3,loaed_data,load_video_data('trimmed_videos/random.avi',width,85,4));
loaded_data = data;
d_s = size(loaded_data);
square_width = d_s(1);
mov = struct('cdata',zeros(square_width,square_width,3,'uint8'),...
    'colormap',[]);

for i = 1:size(loaded_data,4)
    
    %frame = uint8(repmat(loaded_data(:,:,i,1),[1 1 3]));
    frame = loaded_data(:,:,:,i);
    frame = LABdist(frame,[64,64]);
    frame = uint8(repmat(frame,[1 1 3]));
    frame = uint8(lab2rgb(loaded_data(:,:,:,i))*255); %Show rgb form
    
    mask = labels(:,:,i);
    frame2 = ones(d_s(1),d_s(2),3);
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