
function output = entropy( arg )
p = arg/sum(arg);
plog = log2(p);
val = -p.*plog;
val(isnan(val)) = 0;
output = sum(val);
end

