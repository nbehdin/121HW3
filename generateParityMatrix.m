function [ mat, badRows ] = generateParityMatrix( k )
rows = k/10;
cols = k;
mat = zeros(rows, cols);
badRows = [];
for r = 1:rows
    % put thrity ones in each row
    count = 0;
    while sum(mat(r,:)) < 30
        index = randi([1 k]);
        if mat(r, index) ~= 1 && sum(mat(:,index)) < 3
            mat(r, index) = 1;
        end
        if count > 3*k
            badRows = [badRows, r];
            break;
        end
        count = count + 1;
    end
end

end

