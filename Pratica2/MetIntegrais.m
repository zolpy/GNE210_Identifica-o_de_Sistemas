
clc
clear all
close all

% carrega o arquivo .mat com os dados
load('C:\Users\Luiz Carlos\Desktop\dados_ordem1.mat');
y = y_deg_r1;
u = u_deg;
f=input('Digite o per�odo de amostragem: ');

%deteminar o ganho:
aux = length(y);
aux = mean(y(aux-10:end))
k = aux./u;  %k eh o ganho do sistema

%Normalizacao
yn = y/aux;
un = u;
plot(t,yn,'g')  %Plotagem do gr�fico normalizado
grid on
hold on


teta_tau=trapz(un-yn)*f;  %trapz para calcular a integral de un-yn
tt=round(teta_tau*(1/f));
tau=exp(1)*(trapz(yn(1:tt))*f);
teta=teta_tau-tau + 7;
teta = teta - 5;
num=[k];
den=[tau 1];
sys1=tf(num,den);
sys1.OutputDelay=teta;
lsim(sys1,u,t,'r');
legend('Sa�da','Simulado');
xlabel('Tempo em s');
ylabel('Ganho em V');
grid on

