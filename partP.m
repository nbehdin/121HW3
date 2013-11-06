function [ numDecoded ] = partP( numTrials )

numDecoded = zeros(1, numTrials);
for i = 1:numTrials
    G = generateParityMatrix(1000);
    message = randi([0 1], 1, 1000);
    k = length(message);
    parity = mod(G*message', 2);
    
    row = k/10;
    solved = false;
    decoded = NaN(1, k);
    j = 0;
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
        end
    end
    
    parity = [tempParity; parity];
    G = [temp; G];
    
    count = sum(G')';
    
    [solved, G, decoded, parity, count, numDecoded] = eqnsolv(G,message,2,row,decoded, parity, count);
        
    if (sum(decoded ~= message) ~= 0)
        display('incorrect decoding');
    end
end

end