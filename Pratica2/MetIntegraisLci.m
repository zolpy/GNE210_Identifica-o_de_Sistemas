clc
clear all
close all


% carrega o arquivo .mat com os dados
load('C:\Users\Luiz Carlos\Desktop\dados_ordem1.mat');    
y = y_deg_r1;

% Calcula a media dos ultimos 50 pontos da funcao
yinf = mean(y(end-50:end));  

% y normalizado 
yn=y/yinf;    

teta + tau = inte(0->inf) de u(t)-y(t)
tetatau = trapz(t,u_deg' - yn);               

tal = e*(inte(0->teta + tau) de y(y)
tal = (trapz(t(1:292),yn(1:292))*exp(1));     

% C�lculo do tempo morto teta
teta = tetatau - tal;          

% Fun��o de transfer�ncia do metodo das integrais
s = tf('s');
G = yinf*exp(-teta*s)/(tal*s +1);   
g = lsim (G,u_deg,t);

% Plota os dados reais
plot(t,y_deg_r1)  

% Mantem no mesmo grafico 
hold on   

% Plota a funcao encontrada    
plot(t,g,'r')    