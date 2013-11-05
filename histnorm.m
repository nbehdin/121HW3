function pmf = histnorm(trials)
% histnorm takes in an array of trials and returns an estimate
% of the pmf of the process.
pN = zeros(1,max(trials));
for i = 1:length(trials)
    pN(trials(i)) = pN(trials(i)) + 1;
end

pmf = pN/sum(pN);
end