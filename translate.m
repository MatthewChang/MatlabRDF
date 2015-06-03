function output = translate(A,r,c)
    s = size(A);
    if r > 0
        output = [zeros(min(r,s(1)),s(2)) ; A(1:end-r,:)];
    else
        r = -r;
        output = [A(1+r:end,:) ; zeros(min(r,s(1)),s(2)) ];
    end
    if c > 0
        output = [zeros(s(1),min(c,s(2))), output(:,1:end-c)];
    else
        c = -c;
        output = [output(:,1+c:end), zeros(s(1),min(c,s(2))) ];
    end
end

