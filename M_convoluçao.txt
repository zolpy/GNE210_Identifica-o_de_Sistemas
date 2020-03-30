y = zeros(1,2000);
u = randn(1,2000);

figure
plot(u)
figure
hist(u,40)

for k = 3:2000
    y(k) = 1.5*y(k-1)-0.7*y(k-2)+u(k-1)+0.5*u(k-2);
end

y = y+0.1*randn(1,2000);
plot (y)

for i = 1:1000
  U(i,:) = u(999+i:-1:i);
end

h = inv(U)*y(1000:1999)';

yi = dimpulse([1 0.5],[1 -1.5 0.7], length(h));

figure
plot(h(1:40))
hold on
plot(yi(1:40),'red')