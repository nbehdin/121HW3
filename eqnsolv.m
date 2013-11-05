function [tf, G, decoded, parity] = eqnsolv(G,message,method,row,decoded, parity)
%EQNSOLV Solves a system of linear equations using method
%   method is either linsolv or substitution cipher solve

k = length(message);
lastRow = G(row,:);
newParity = mod(dot(lastRow, message), 2);
parity = [parity; newParity];

if method == 1
    %CHECK IF WE CAN DECODE WITH LINEAR EQN SOLVER
    if row >= k && rank(G) == size(G,2)
        keyboard;
        decoded = mod(G(1:row,:)\parity, 2);
        if (sum(decoded ~= message') ~= 0)
            error('decoded incorrectly')
        end
            
        tf = true;
    else
        tf = false;
    end
elseif method == 2
    %DECODE USING SUBSTITUTION CIPHER
    
    for i = find(~isnan(decoded))
        if (~isnan(decoded(i)) && lastRow(i) == 1)
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
