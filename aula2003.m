clear all
close all
clc

x= linspace (1,2,50);
y=exp(x); 
y2= x.^2;

figure
plot (x,y,'-x');
hold on;
plot(x,y2,'ro');

break; 
