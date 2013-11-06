function [ numDecoded, decoded, solved, numErasures ] = partP(  )
numTrials = 1;
numDecoded = zeros(1, numTrials);
for i = 1:numTrials
    numErasures = 0;
    G = generateParityMatrix(1000);
    message = randi([0 1], 1, 1000);
    k = length(message);
    parity = mod(G*message', 2);
    
    row = k/10;
    decoded = NaN(1, k);
    if size(G, 2) > 1000
        keyboard;
    end
    
    %initialize erasures
    temp = zeros(k,k);
    tempParity = zeros(k,1);
    for j=1:k
        if rand > 0.05
            temp(j, j) = 1;
            tempParity(j) = message(j);
            numErasures = numErasures + 1;
        end
    end
    
    parity = [tempParity; parity];
    G = [temp; G];
    
    count = sum(G')';
    
    [ G, parity, decoded, solved, count, numDecoded ] = substitutionSolver2( G, parity, decoded, count );
        
    if (sum(decoded ~= message) ~= 0)
        display('incorrect decoding');
    end
end

end

function [ G, parity, decoded, tf, count, numDecoded ] = substitutionSolver2( G, parity, decoded, count )
% substitutionSolver Attempt to solve by substitution
%   use this iterively. solve for as many bits as you can given new row
numDecoded = [];

newSingleEdges = find(count == 1);
while (~isempty(newSingleEdges))
    if (sum(isnan(decoded)) == 0)
        break;
    end
    for r = newSingleEdges'
        if count(r) == 1
            colIndex = find(G(r,:));
            decoded(colIndex) = parity(r);
            [G, decoded, parity, count] = subHelper(G, decoded, colIndex, parity, count);
        end
    end
    numDecoded = [numDecoded; sum(isnan(decoded))];
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

