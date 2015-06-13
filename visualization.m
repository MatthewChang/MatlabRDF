%idea train on difference of hue?
label_results = false;
d_s = size(data);
square_width = d_s(1);
mov = struct('cdata',zeros(square_width,square_width,3,'uint8'),...
    'colormap',[]);

if label_results
    labeled_results = zeros(size(data(:,:,:,1)));
    for i = 1:d_s(3)
        i
        item_list = [];
        for c = 1:d_s(2)
            for r = 1:d_s(1)
                item_list(end+1,:) = [r c i];
            end
        end
        image_labels = label_items(data(:,:,:,1),treeset,item_list,3);
        labeled_results(:,:,i) = reshape(image_labels,d_s(1),d_s(2));        
    end
    save('labeled_results','labeled_results');
end
disp_results = labeled_results;
for i = 1:size(disp_results,3)
    disp_results(:,:,i) = disp_results(:,:,i).*bwareaopen(disp_results(:,:,i),3);
end
for i = 1:size(data,3)
    
    frame = uint8(repmat(data(:,:,i,1),[1 1 3]));
    
    mask = data(:,:,i,2);
    frame2 = repmat(data(:,:,i,2)*256,[1 1 3]);
    serial_frame2 = reshape(frame2,d_s(1)*d_s(2),3);
    serial_frame2(mask==0,:) = repmat([0,0,0],[sum(mask(:)==0) 1]);
    serial_frame2(mask==1,:) = repmat([256,256,0],[sum(mask(:)==1) 1]);
    serial_frame2(mask==2,:) = repmat([0,256,0],[sum(mask(:)==2) 1]);
    serial_frame2(mask==3,:) = repmat([0,0,256],[sum(mask(:)==3) 1]);
    serial_frame2(mask==4,:) = repmat([256,0,0],[sum(mask(:)==4) 1]);
    frame2 = reshape(serial_frame2,d_s(1),d_s(2),3);
    
    mask = disp_results(:,:,i);
    serial_frame3 = zeros(d_s(1)*d_s(2),3);
    serial_frame3(mask==0,:) = repmat([0,0,0],[sum(mask(:)==0) 1]);
    serial_frame3(mask==1,:) = repmat([256,256,0],[sum(mask(:)==1) 1]);
    serial_frame3(mask==2,:) = repmat([0,256,0],[sum(mask(:)==2) 1]);
    serial_frame3(mask==3,:) = repmat([0,0,256],[sum(mask(:)==3) 1]);
    serial_frame3(mask==4,:) = repmat([256,0,0],[sum(mask(:)==4) 1]);
    frame3 = reshape(serial_frame3,d_s(1),d_s(2),3);
    
    mov(i).cdata = cat(2,frame,frame2,frame3);
end
hf = figure;
set(hf,'position',[150 150 square_width*3 square_width]);
movie(hf,mov,1,10);

% writerObj = VideoWriter('treesize20');
% writerObj.FrameRate = 14;
% open(writerObj);
% for k = 1:size(mov,2)
%    frame = mov(k).cdata;
%    writeVideo(writerObj,frame);
% end