function [ N, numDecoded ] = partP( numTrials )
G = generateParityMatrix(1000);
message = randi([0 1], 1, 1000);
parity = G*message';
count = sum(G')';
k = length(message);
N = zeros(1,numTrials);
numDecoded = zeros(1, numTrials);
for i = 1:numTrials
    row = k/10;
    solved = false;
    decoded = NaN(1, k);
    j = 0;
    while ~solved || j > k %cannot solve for message
        row = row + 1;
        j = j + 1;
        G(row,:) = zeros(1,k);
        if rand > 0.05
            G(row, j) = 1;
        end
        [solved, G, decoded, parity, count] = eqnsolv(G,message,2,row,decoded, parity, count);
    end
    keyboard;
    if (sum(decoded ~= message) ~= 0)
        display('incorrect decoding');
    end
    N(i) = row;
    numDecoded(i) = sum(~isnan(decoded));
end

end