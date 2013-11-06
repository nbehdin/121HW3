function [ G, parity, decoded, tf, count ] = substitutionSolver( G, parity, decoded, row, count )
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

newSingleEdges = find(count == 1);
while ((size(newSingleEdges, 1) ~= 0) && (length(newSingleEdges) > 0))
    if (sum(isnan(decoded)) == 0)
        break;
    end
    r = newSingleEdges(1);
    colIndex = find(G(r,:));
    decoded(colIndex) = parity(r);
    [G, decoded, parity, count] = subHelper(G, decoded, colIndex, parity, count);
    newSingleEdges = find(count == 1); 
end

if (sum(isnan(decoded)) == 0)
    tf = true;
else
    tf = false;
end
end

function [G, decoded, parity, count] = subHelper(G, decoded, colIndex, parity, count)
indices = find(G(:,colIndex) == 1);
G(indices, colIndex) = 0;
parity(indices) = mod(parity(indices)+decoded(colIndex), 2);
count(indices) = count(indices) - 1;
end

