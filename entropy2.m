function output = entropy2(A)
nums = sum(A,2);
pnums = nums/sum(nums);
C = num2cell(A,2);
B = cellfun(@(x) entropy(x),C);
output = sum(B.*pnums);
end

