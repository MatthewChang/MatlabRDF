function output = randomFeature()
    num_features = 2;
    width = 128;
    output = cat(3,randi(width*2,1,num_features,2)-width,randi(2,1,num_features,1)-1); 
    %output = [randi(128*2,1,4)-128,   randi(4)-1];
end

