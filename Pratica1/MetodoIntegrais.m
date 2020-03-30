clear all
close all
clc

% Obter dados do arquivo
load dados_ordem1

%figure
%plot(t,y_deg_r1);

ym = mean(y_deg_r1(end:50:end));   % Pegar media da funcao

%figure
%plot(t,y_deg_r1)

y_deg_r1 = y_deg_r1/ym;   % Normalizar dividindo pela media

%figure
%plot(t,y_deg_r1)

% Usar método trapezoidal para calcular a integral

Z = trapz(t,y_deg_r1)  % area da funcao

U = trapz(t,u_deg)   % area do degrau

TetaMaisTau = U-Z  % Area do degrau menos area da funcao

% Agora quero soh o Tau, que eh integral de y(t) nos limites 0 até Teta +
% tau, multiplicado por exp(1)

ind = max(find(t < TetaMaisTau));  % Acha o maior indice de t que ainda eh menor que TetaMais Tau

a = trapz(t(1:ind),y_deg_r1(1:ind));
tau = exp(1)*a

teta = TetaMaisTau - tau