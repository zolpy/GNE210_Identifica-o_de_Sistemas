clc
clear all
close all
fs=1
y=zeros(1,2048)
u=randn(1,2048)

y=dlsim([1 0.5],[1 -1.5 0.7],u);
y=y+0.5*randn(size(y));
plot(y);