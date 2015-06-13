function data = load_video_data_hsv(file,square_width,threshold,label)
    xyloObj = VideoReader(file);
    k = 1;
    data = [];
    while hasFrame(xyloObj)
        frame = readFrame(xyloObj);
        frame = imresize(frame,[square_width,square_width]);    
        
        [h,~,~] = rgb2hsv(frame);
        frame = rgb2gray(frame); 
        frame(frame<threshold) = 0;
        frame(frame>=threshold) = label;
        
        data(:,:,k,1) = floor(h*255+1); %range 1 to 255
        data(:,:,k,2) = frame;
        k = k+1;
    end
end