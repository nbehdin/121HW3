function [ G, parity, decoded, tf ] = substitutionSolver( G, parity, message, decoded, row )
% substitutionSolver Attempt to solve by substitution
%   use this iterively. solve for as many bits as you can given new row
for i = find(~isnan(decoded))
    if (G(row,i) == 1)
        G(row,i) = 0;
        parity(row) = mod(parity(row)+decoded(i),2);
    end
end
if (sum(G(row,:)) == 1)
    colIndex = find(G(row,:));
    decoded(colIndex) = parity(end);
    [G, decoded, parity] = subHelper(G, decoded, colIndex, message, parity, row);
end
if (sum(isnan(decoded)) == 0)
    if (sum(decoded~=message) ~= 0)
        error('decoded incorrectly');
    end
    tf = true;
else
    tf = false;
end
end

function [G, decoded, parity] = subHelper(G, decoded, colIndex, message, parity, row)
indices = find(G(:,colIndex) == 1)';

for j = indices
    if (j ~= row)
        G(j,colIndex) = 0;
        parity(j) = mod(parity(j)+decoded(colIndex),2);
        if (sum(G(j,:)) == 1)
            colIndex = find(G(j,:));
            if (~isnan(decoded(colIndex)))
                decoded(colIndex) = parity(j);
            end
            [G, decoded, parity] = subHelper(G, decoded, colIndex, message, parity, j);
        end
    end
end
end

