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
        [decoded, tf] = linearSolver(G, parity, message);     
    else
        tf = false;
    end
elseif method == 2
    %DECODE USING SUBSTITUTION CIPHER
    [ G, parity, decoded, tf ] = substitutionSolver( G, parity, message, decoded, row );
end
end
