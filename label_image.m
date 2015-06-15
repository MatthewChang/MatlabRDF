function labeled_image = label_image(data,treeset)
    labeled_image = zeros(size(data,1),size(data,2),size(treeset,2));
    for t = 1:size(treeset,2)
        for c = 1:size(data,2)
            for r = 1:size(data,1)
                %size(labeled_image(r,c))
                %lasize(label_pixel(data,[r c],treeset))
                labeled_image(r,c,t) = label_pixel(data,[r c],treeset{t});
            end
        end
    end
    labeled_image = mode(labeled_image,3);
end

