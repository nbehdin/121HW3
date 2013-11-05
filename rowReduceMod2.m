%% rreff   Reduced row echelon form
%%      R = rref (A, tol) returns the reduced row echelon form of a.
%%      tol defaults to eps * max (size (A)) * norm (A, inf)
%%
%%      [R, k] = rref (...) returns the vector of "bound variables",
%%      which are those columns on which elimination has been performed.

function [A, k] = rowReduceMod2 (A)

[rows,cols] = size (A);


tolerance = eps * max (rows, cols) * norm (A, inf);


used = zeros(1,cols);
r = 1;
for c=1:cols
    %% Find the pivot row
    [m, pivot] = max (abs (A (r:rows, c)));
    pivot = r + pivot - 1;
    
    if (m <= tolerance)
        %% Skip column c, making sure the approximately zero terms are
        %% actually zero.
        A (r:rows, c) = zeros (rows-r+1, 1);
        
    else
        %% keep track of bound variables
        used (1, c) = 1;
        
        %% Swap current row and pivot row
        A ([pivot, r], c:cols) = A ([r, pivot], c:cols);
        
        %% Normalize pivot row
        %A (r, c:cols) = mod(A (r, c:cols) * findModInv(A (r, c), 2),2);
        
        %% Eliminate the current column
        ridx = [1:r-1, r+1:rows];
        A (ridx, c:cols) = mod(A (ridx, c:cols) - A (ridx, c) * A(r, c:cols), 2);
        
        %% Check if done
        if ((r+1) == rows) 
            break;
        else
            r=r+1;
        end
    end
end
k = find(used);


%% Get the matrix into rref form
for r = 1:rows-1
    for c = r+1:cols-1
        if A(r,c) == 1
            A(r,:) = mod(A(r,:) + A(c,:), 2);
        end
    end
end

end