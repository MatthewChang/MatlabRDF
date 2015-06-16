function dists = LABdist(I,pos)
    dists = zeros(size(I,1),size(I,2));
    mean = I(pos(1),pos(2),:);
    L = I(:,:,1)-mean(1);
    A = I(:,:,2)-mean(2);
    B = I(:,:,3)-mean(3);
    L2 = L.*L;
    A2 = A.*A;
    B2 = B.*B;
    dists = sqrt(L2+A2+B2);    
end