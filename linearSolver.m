function [ decoded, tf ] = linearSolver( G, parity, message )
%linearSolver linearly solve
%   G is the generator, parity is a column of the parity bits

temp = rowReduceMod2([G(1:length(parity),:) parity]);
k = length(message);

decoded = temp(1:k, end)';
s = size(temp,2)-1;
if (sum(sum(temp(1:s, 1:s) ~= eye(s))) ~= 0)
    tf = false;
else
    tf = true;
end

end

