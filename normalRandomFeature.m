function output = normalRandomFeature()
    num_features = 2;
    width = 128;
    stddev = width/2;
    num_labels=2;
    output = floor(cat(3,normrnd(0,stddev,1,num_features,2),randi(num_labels,1,num_features,1)-1)); 
    %output = [randi(128*2,1,4)-128,   randi(4)-1];
end

