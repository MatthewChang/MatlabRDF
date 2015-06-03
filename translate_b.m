function output = translate(A,r,c)
    s = size(A);
    z = zeros(s);
    output = padarray(A,s);
    output = output(s(1)+1-r:s(1)+s(1)-r,s(2)+1-c:s(2)+s(2)-c);
end

