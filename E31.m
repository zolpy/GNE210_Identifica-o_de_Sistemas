clear all
close all
clc

K=1;

 fprintf('K= %d',K);
s=tf('s'); 
G=K/(2*s+1) 

figure,step(G);
grid on;
%s=tf('s'); 
%g=K/S(S+5)
%H=1
%T=feedback(G,H)
%figure,step(T)