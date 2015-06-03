sd = size(data)
for i = 11:sd(3)
    i
    new = ones(sd(1),sd(2),size(treeset,2));
    input = data(:,:,i,1);
    for r = 1:sd(1)
        for c = 1:sd(2)
            for z = 1:size(treeset,2)
                new(r,c,z) = label_pixel(input,[r c],treeset{z});
            end
        end
    end
    s = size(treeset,2);
    subplot(1,s+2,1), subimage(input)
    for z = 1:size(treeset,2)
        subplot(1,s+2,z+1), subimage(new(:,:,z))
    end
    m = mode(new,3);
    subplot(1,s+2,s+2), subimage(m)
    pause
end
            