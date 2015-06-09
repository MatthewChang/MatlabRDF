width = 50;
full_learners = zeros(width*width*4,1,3);

for r=1:width
    for c=1:width
        for s=0:4
            full_learners(end+1,:,:) = [r c s];
        end
    end
end
size(full_learners)