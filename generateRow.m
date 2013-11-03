function [row] = generateRow(k,distribution)
%GENERATEROW Generate length k row of generator matrix according to
%distribution

i = 1:k;

if distribution == 1
    %UNIFORM DISTRIBUTION
    row = randi([0 1],1,k);
elseif distribution == 2
    %IDEAL SOLITON DISTRIBUTION
    rho(1) = 1/k;rho(2:k) = 1./(i(2:end).*(i(2:end) - 1)); %make P_d
    D = sampleFromDist(rho,1:length(rho),1); %draw from P_d(.)
    onePositions = randperm(k);
    onePositions = onePositions(1:D);%D positions uniformly from [1,k]
    row = zeros(1,k);
    row(onePositions) = 1; %Put ones in the D positions chosen
elseif distribution == 3
    %ROBUST SOLITON DISTRIBUTION
    % success probability
    delta = 0.09;
    % i.e. choose delta s.t. (1 - delta) is okay failure probability
    c = 0.09;
    R = c*sqrt(k).*(log(k) + log(1/delta));
    tau(1:floor(k/R) - 1) = (1./k).*(R./i(1:floor(k/R) - 1));
    tau(floor(k/R)) = (1./k).*(R*(log(R) + log(1/delta)));
    tau(floor(k/R)+1:k) = 0;
    rho(1) = 1/k;rho(2:k) = 1./(i(2:end).*(i(2:end) - 1));
    beta = sum(rho + tau);
    mu = (rho + tau)/beta;
    D = sampleFromDist(mu,1:length(mu),1); %draw from P_d(.)
    onePositions = randperm(k);
    onePositions = onePositions(1:D);%D positions uniformly from [1,k]
    row = zeros(1,k);
    row(onePositions) = 1; %Put ones in the D positions chosen
end
if (sum(row) == 0)
    error('SHIT');
end

end

