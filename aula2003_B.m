close all 
clear all 
clc

g=tf([10], [1 1])
g.OutputDelay = 2;
s=tf('s');

impulse(g);

tau1=100
tau2=[0.1 1 10 30 70 100]
t = 0: 0.01:100; 
figure
hold on
for i=1:6
    g(i) =tf(1,[tau1*tau2(i) (tau1+tau2(i)) 1])
    g(i).OutputDelay =30;
end
step(g(1),g(2),g(3),g(4),g(5),g(6));

% comentario cntro R e tira control T
% G2=10/(s
% step(G)
% break
% hs=10/(s-1);
% step hs; 