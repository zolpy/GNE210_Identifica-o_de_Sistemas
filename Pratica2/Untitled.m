%Metodo Sudarese
clear all;
clc;
close all;

taus31 = 4;
taus32 = 5;
tetas3 = 1.0;
Gp3s = tf(1,[taus31*taus32 (taus31+taus32) 1]);
t=0:0.05:100;  
y_deg1= step(Gp3s,t); 
u_deg= ones(1,length(y_deg1)); 
r_deg=0.1*randn(1,length(y_deg1)); 
y_deg_r1=y_deg1+ r_deg';  

figure
plot(t,y_deg_r1) 
grid on
Tal_mais_Teta= sum(u_deg)*0.05 - sum(y_deg_r1)*0.05; 
ind=find(t<=Tal_mais_Teta); 
a=max(ind); 
Tal=exp(1) * sum(y_deg_r1(1:a))*0.05; 
Teta= Tal_mais_Teta-Tal; 
fprintf('O valor da soma de tal mais teta é :  %.3f segundos\n ', Tal_mais_Teta); 
fprintf('O valor de tal é :  %.3f segundos\n ', Tal);
fprintf('O valor do indice de atraso sofrindo pela a função é : %.3f segundos\n',Teta);
% 
% t=0:0.5:50;
% y_degs3 = step(Gp3s,t);
% plot(t,y_degs3)
% grid on;

