function [samples] = sampleFromDist(distribution,values,n)
%SAMPLEFROMDIST takes n samples from distribution
if abs(1-sum(distribution)) > .001
    %%% BE WARNED normr WORKED VERY WEIRD FOR SOLITON
    distribution = normr(distribution);
end

random = rand(1,n);
random = sort(random);

samples = zeros(1,n);
distPos = 1;
samplePos = 1;
cdf = distribution(1);
while samplePos <= n    
    if random(samplePos) < cdf
        samples(samplePos) = values(distPos);
        samplePos = samplePos + 1;
    else
        distPos = distPos + 1;
        cdf = cdf + distribution(distPos);
    end
end
end

