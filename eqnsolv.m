function [tf, G, decoded, parity, count] = eqnsolv(G, message, method, row, decoded, parity, count)
%EQNSOLV Solves a system of linear equations using method
%   method is either linsolv or substitution cipher solve

k = length(message);
lastRow = G(row,:);
if (length(message) ~= length(lastRow))
    keyboard;
end
newParity = mod(dot(lastRow, message), 2);
parity = [parity; newParity];

if method == 1
    %CHECK IF WE CAN DECODE WITH LINEAR EQN SOLVER
    if row >= k
        [decoded, tf] = linearSolver(G, parity, message);     
    else
        tf = false;
    end
elseif method == 2
    %DECODE USING SUBSTITUTION CIPHER
    [ G, parity, decoded, tf, count ] = substitutionSolver( G, parity, decoded, row, count );
end
end
