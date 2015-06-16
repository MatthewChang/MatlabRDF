function labeled_image = label_image_2(data,treeset)
    item_list = [];
    
    assert(ndims(data) == 3);
    data = repmat(data,[1 1 1 1]);
    d_s = size(data);
    for c = 1:d_s(2)
        for r = 1:d_s(1)
            item_list(end+1,:) = [r c 1];
        end
    end
    image_labels = label_items(data,treeset,item_list,2);
    labeled_image = reshape(image_labels,d_s(1),d_s(2));
end

