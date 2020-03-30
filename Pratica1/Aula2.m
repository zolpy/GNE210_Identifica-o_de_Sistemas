% Aula Pratica 02 
% Identificação de Sistemas

% Sistemas que tem integrador sao sistemas que acumulam
% Ex: Tanque que vai enchendo.
% Planta = 1/s, entrada degrau de ON na bomba (1/s também) produz uma rampa no
% nivel o tanque (1/s^2).

clear all
clc
close all

s = tf('s');

G1 = 1/s;
X1 = 1/s;

G2 = (s+0.001)/((s+0.005)*(s+0.008));

%{
subplot(2,2,1)
step(G1)
subplot(2,2,2)
step(G2)
subplot(2,2,3)
step(G2/s)
subplot(2,2,4)
step(G1*s)
%}

G3 = 10/(s+1);
G3.OutputDelay = 3;  % Colocar tempo morto no inicio do sistema

figure
subplot(1,2,1)
step(G3)
subplot(1,2,2)
impulse(G3)





