% EE 121
% HW 3
% Problem 2
% Part k


x = linspace(0,0.1,1001);
z = zeros(1,length(x));
w = zeros(1,length(x));
t = zeros(1,length(x));

figure
hold on

p = 0.05;
f = p*(1 - (1 - x).^(29)).^2;
y = x;
plot(x,f,'b')
plot(x,y,'g')
title('Probability of Error')
legend('f(x)','x')
xlabel('p_e[j]')
ylabel('p_e[j - 1]')
