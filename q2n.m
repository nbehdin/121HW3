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

colors = ['r' 'y' 'b' 'm'];
i = 1;
for p = 0.05:.011:0.083
    f = p*(1 - (1 - x).^(29)).^2;
    y = x;
    drawnow
    plot(x,f,colors(i))
    i = i + 1;
end
plot(x,y,'g')

title('Probability of Error for Increasing p')
legend('f(x), p = 0.05','f(x), p = 0.061','f(x), p = 0.072','f(x), p = 0.083','x')
xlabel('p_e[j]')
ylabel('p_e[j - 1]')