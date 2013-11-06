% EE 121
% HW 3
% Problem 1
% Generating Plots

%% a) Uniform: PMF

% k = 10
trials = rateless(10,'u','l',1000);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 10 bits')
xlabel('Number of Equations')
ylabel('Probability')
%%
% k = 100
trials = rateless(100,'u','l',100);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 100 bits')
xlabel('Number of Equations')
ylabel('Probability')

%% a) Uniform: Median, 90-Percent Quantile
med = zeros(1,100);
NPQ = zeros(1,100);

for k = 10:5:100
   trials = rateless(k,'u','l',10);
   PDF = histnorm(trials);
   med(k) = median(trials);
   CDF = cumsum(PDF);
   NPQ_temp = find(CDF >= 0.9);
   NPQ(k) = NPQ_temp(1);
end

figure
stem(med)
title('Estimated Median of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('Median')

figure
stem(NPQ)
title('Estimated 90-Percent Quantile of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('90-Percent Quantile')

%% b) Ideal Soliton: PMF

% k = 10
trials = rateless(10,'i','l',1000);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 10 bits')
xlabel('Number of Equations')
ylabel('Probability')
%%
% k = 100
trials = rateless(100,'i','l',100);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 100 bits')
xlabel('Number of Equations')
ylabel('Probability')

%% b) Ideal Soliton: Median, 90-Percent Quantile
med = zeros(1,100);
NPQ = zeros(1,100);

for k = 10:5:100
   trials = rateless(k,'i','l',10);
   PDF = histnorm(trials);
   med(k) = median(trials);
   CDF = cumsum(PDF);
   NPQ_temp = find(CDF >= 0.9);
   NPQ(k) = NPQ_temp(1);
end

figure
stem(med)
title('Estimated Median of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('Median')

figure
stem(NPQ)
title('Estimated 90-Percent Quantile of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('90-Percent Quantile')


%% b) Robust Soliton: PMF

% k = 10
trials = rateless(10,'r','l',1000);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 10 bits')
xlabel('Number of Equations')
ylabel('Probability')
%%
% k = 100
trials = rateless(100,'r','l',100);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 100 bits')
xlabel('Number of Equations')
ylabel('Probability')

%% b) Robust Soliton: Median, 90-Percent Quantile
med = zeros(1,100);
NPQ = zeros(1,100);

for k = 10:5:100
   trials = rateless(k,'r','l',10);
   PDF = histnorm(trials);
   med(k) = median(trials);
   CDF = cumsum(PDF);
   NPQ_temp = find(CDF >= 0.9);
   NPQ(k) = NPQ_temp(1);
end

figure
stem(med)
title('Estimated Median of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('Median')

figure
stem(NPQ)
title('Estimated 90-Percent Quantile of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('90-Percent Quantile')

%% c) Ideal Soliton with Substitution Solving: PMF

% k = 10
trials = rateless(10,'i','s',1000);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 10 bits')
xlabel('Number of Equations')
ylabel('Probability')
%%
% k = 100
trials = rateless(100,'i','s',100);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 100 bits')
xlabel('Number of Equations')
ylabel('Probability')

%% c) Ideal Soliton with Substitution Solving: Median, 90-Percent Quantile
med = zeros(1,100);
NPQ = zeros(1,100);

for k = 10:5:100
   trials = rateless(k,'i','s',10);
   PDF = histnorm(trials);
   med(k) = median(trials);
   CDF = cumsum(PDF);
   NPQ_temp = find(CDF >= 0.9);
   NPQ(k) = NPQ_temp(1);
end

figure
stem(med)
title('Estimated Median of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('Median')

figure
stem(NPQ)
title('Estimated 90-Percent Quantile of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('90-Percent Quantile')


%% c) Robust Soliton with Substitution Solving: PMF

% k = 10
trials = rateless(10,'r','s',1000);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 10 bits')
xlabel('Number of Equations')
ylabel('Probability')
%%
% k = 100
trials = rateless(100,'r','s',100);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 100 bits')
xlabel('Number of Equations')
ylabel('Probability')

%% c) Robust Soliton with Substitution Solving: Median, 90-Percent Quantile
med = zeros(1,100);
NPQ = zeros(1,100);

for k = 10:5:100
   trials = rateless(k,'r','s',10);
   PDF = histnorm(trials);
   med(k) = median(trials);
   CDF = cumsum(PDF);
   NPQ_temp = find(CDF >= 0.9);
   NPQ(k) = NPQ_temp(1);
end

figure
stem(med)
title('Estimated Median of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('Median')

figure
stem(NPQ)
title('Estimated 90-Percent Quantile of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('90-Percent Quantile')

%% d) Robust Soliton with Substitution Solving: PMF

% higher values of k
trials = rateless(1000,'r','s',10);
PMF = histnorm(trials);
stem(PMF)
title('Estimated PMF of N for k = 10 bits')
xlabel('Number of Equations')
ylabel('Probability')
%% d) Robust Soliton with Substitution Solving: Median, 90-Percent Quantile
med = zeros(1,100);
NPQ = zeros(1,100);

for k = 1000
   trials = rateless(k,'r','s',10);
   PDF = histnorm(trials);
   med(k) = median(trials);
   CDF = cumsum(PDF);
   NPQ_temp = find(CDF >= 0.9);
   NPQ(k) = NPQ_temp(1);
end

figure
stem(med)
title('Estimated Median of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('Median')

figure
stem(NPQ)
title('Estimated 90-Percent Quantile of N for k = 10:5:100 bits')
xlabel('Number of Message Bits')
ylabel('90-Percent Quantile')


