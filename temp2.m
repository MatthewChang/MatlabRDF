A = data(:,:,10,1);
figure; imshow(A/255);

p = [70 85];
candidate = [-1 0;1 0;0 1;0 -1];
total = 0;
numel = 0;
mask = zeros(size(A));
while(size(p,1) > 0)
    v = p(1,:);
    p = p(2:end,:);
    mask(v(1),v(2)) = 1;
    total = total + A(v(1),v(2));
    numel = numel+1;
    for i = 1:4
        c = v+candidate(i,:);
        if(c(1) > 0 && c(1) <= 128 && c(2) > 0 && c(2) <= 128)
            if(abs(A(c(1),c(2)) - (total/numel)) < 20 && mask(c(1),c(2)) == 0)
                p = [c;p];
            end
        end
    end
    
end
figure; imshow(mask);