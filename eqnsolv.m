function [tf, G, decoded, parity] = eqnsolv(G,message,method,row,decoded, parity)
%EQNSOLV Solves a system of linear equations using method
%   method is either linsolv or substitution cipher solve

k = length(message);
lastRow = G(row,:);
newParity = dot(lastRow, message);
parity = [parity; newParity];
    
if method == 1
    %CHECK IF WE CAN DECODE WITH LINEAR EQN SOLVER
    if row >= k && rank(G) == size(G,2)  
        decoded = G(1:row,:)\parity;
        tf = true;
    else
        tf = false;
    end
elseif method == 2
    %DECODE USING SUBSTITUTION CIPHER
    
    for i = 1:length(lastRow)
        if (~isnan(decoded(i)) && lastRow(i) == 1)
            G(row,i) = 0;
            parity(row) = mod(parity(row)+decoded(i),2);
        end
        if (sum(G(row,:)) == 1)
            colIndex = find(G(end,:));
            decoded(colIndex) = parity(end);
            [G, decoded, parity] = subHelper(G, decoded, colIndex, message, parity);
        end
    end
    if (sum(isnan(decoded)) == 0)
        keyboard;
        if (sum(decoded~=message))
            error('oops');
        end
        tf = true;
    else
        tf = false;
    end
end
end

function [G, decoded, parity] = subHelper(G, decoded, colIndex, message, parity)
for j = find(G(:,colIndex) == 1)'
   G(j,colIndex) = 0;
   parity(j) = mod(parity(j)+decoded(colIndex),2);
   if (sum(G(j,:)) == 1)
       colIndex = find(G(j,:));
       decoded(colIndex) = parity(j);
       [G, decoded, parity] = subHelper(G, decoded, colIndex, message, parity);
   end
end
end
