function output = matrixSelect(A,sel)
    sel_cell = num2cell(sel,1);
    indices = sub2ind(size(A),sel_cell{:});
    output = A(indices);
%     A_s = size(A);
%     muls = ones(ndims(A),1);
%     for i = 2:ndims(A)
%         muls(i) = muls(i-1)*A_s(i-1);
%     end
%     vals = ((sel-1)*muls)+1;
%     output = A(vals);

end

