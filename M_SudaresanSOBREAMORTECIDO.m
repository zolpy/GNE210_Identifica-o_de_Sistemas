% SOBREAMORTECIDO
% determinar ganho em regime pergamente
% determinar a area m1
% determinar a inclinação do ponto de
% inflexao de y(t). Este e o valor de Mi
% determinar tm
% determinar lambda labi = (tm - m1)*Mi
% determinar n a parti do grafico
% determinar T1, T2 e Td usando
% T1 = (n^(n/(1-n)))/Mi
% T2 = (n^(1/(1-n)))/Mi
% Td = m1 - T1 - T2
% CODIGO
% -------
clc
close all
clear all

tau1 = input('Valor de tau1: ');
tau2 = input('Valor de tau2: ');

% tau1 = 4;
% tau2 = 5;
 teta3 = 1.0;

eta= tau1/tau2
alpha=tau1*tau2/(tau1-tau2)
Mi=(eta^(1/1-eta))/(alpha*(eta-1))

Gp3s = tf(1,[tau1*tau2 (tau1 + tau2) 1])
Gp3s.OutputDelay = teta3;
t = 0:0.05:50;
y_degs3 = step(Gp3s,t);
plot(t,y_degs3)
grid on

area = 1-y_degs3;
m1 = trapz(t,area)

% Mi = input('Valor Mi: ')
tm = input('Valor tm: ')

lamb = (tm - m1)*Mi
% eta = input('Valor de eta: ');

T1 =(eta^((eta/(1-eta))))/Mi

T2 = (eta^(1/(1-eta)))/Mi

Td = m1 - T1 - T2
s = tf('s');
H = ((exp(-Td*s))/((T1*s+1)*(T2*s+1)))
