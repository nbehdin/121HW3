function [ G, parity, decoded, tf, count ] = substitutionSolver( G, parity, message, decoded, row,count )
% substitutionSolver Attempt to solve by substitution
%   use this iterively. solve for as many bits as you can given new row
count = [count; sum(G(row,:))];
for i = find(~isnan(decoded))
    if (G(row,i) == 1)
        G(row,i) = 0;
        parity(row) = mod(parity(row)+decoded(i),2);
        count(row) = count(row) - 1;
    end
end

if (count(row) == 1)
    colIndex = find(G(row,:));
    decoded(colIndex) = parity(end);
    [G, decoded, parity, count] = subHelper(G, decoded, colIndex, message, parity, row, count);
end
if (sum(isnan(decoded)) == 0)
    tf = true;
else
    tf = false;
end
end

function [G, decoded, parity, count] = subHelper(G, decoded, colIndex, message, parity, row, count)
indices = find(G(:,colIndex) == 1)';

for j = indices
    if (j ~= row && G(j, colIndex) == 1)
        G(j,colIndex) = 0;
        parity(j) = mod(parity(j)+decoded(colIndex), 2);
        count(j) = count(j) - 1;
        if (count(j) == 1)
            colIndex = find(G(j,:));
            if (~isnan(decoded(colIndex)))
                decoded(colIndex) = parity(j);
            end
            [G, decoded, parity, count] = subHelper(G, decoded, colIndex, message, parity, j, count);
        end
    end
end
end

