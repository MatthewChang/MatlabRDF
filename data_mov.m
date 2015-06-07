d_s = size(data);
square_width = d_s(1);
mov = struct('cdata',zeros(square_width,square_width,3,'uint8'),...
    'colormap',[]);
for i = 1:size(data,3)
    
    frame = uint8(repmat(data(:,:,i,1),[1 1 3]))*256;
    
    mask = data(:,:,i,2);
    frame2 = repmat(data(:,:,i,2)*256,[1 1 3]);
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
set(hf,'position',[150 150 square_width*2 square_width*2]);
movie(hf,mov,1,10);