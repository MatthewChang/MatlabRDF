function data = load_video_data(file,square_width,threshold,label)
    xyloObj = VideoReader(file);
    k = 1;
    data = [];
    while hasFrame(xyloObj)
        frame = readFrame(xyloObj);
        frame = rgb2gray(frame);
        
        
        frame = imresize(frame,[square_width,square_width]); 
        
        [~,thresh] = edge(frame,'sobel');
        sobel = edge(frame,'sobel',thresh);
        se3 = strel('square',2);
        sobel = imdilate(sobel,se3);
        sobel = imresize(sobel,[square_width,square_width]);  
        
        
        frame(frame<threshold) = 0;
        frame(frame>=threshold) = label;
        %frame(:,1:20,:) = zeros(square_width,20,1);
        data(:,:,k,1) = sobel;
        data(:,:,k,2) = frame;
        k = k+1;
    end
end