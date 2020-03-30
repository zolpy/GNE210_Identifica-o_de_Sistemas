clear all
close all
clc
Gp1 = tf(3,[10 1]);
Gp1.OutputDelay= 5;
t = 0:0.05:50;
y_deg1 = step(Gp1,t);
u_deg = ones(1,length(y_deg1));
r_deg = 0.1*randn(1,length(y_deg1));
y_deg_r1 = y_deg1 + r_deg';


figure
plot(t,y_deg_r1)
grid on;

save dados_ordem1 y_deg_r1 u_deg t