clear all
close all
clc


%Usar as funções de correlação e autocorrelação para obter H -> resposta ao
%impulso
%Métodos não paramétricos
fs = 1;

nu = input('Coloque o Nu: ');
ny = input('Coloque o Ny: ');
ne = input('Coloque o Ne: ');
k = input('Coloque o número de iterações: ');

y = zeros(1, 2048);
u = randn(1, 2048);

y = dlsim([1 0.5], [1 -1.5 0.7], u);%sistema discreto simulado

y = y +.5*randn(size(y)); %ruido

max_atraso = max( [nu,ny] ); 
yaux = y(max_atraso+1:end);

X =  zeros(length(yaux),nu+ny);

for i=1:(nu+ny)
    if (i <= ny)
     X(:,i) = y((max_atraso + 1 - i):(end-i));   
    end
    if (i>ny)
     j = i - ny;
     X(:,i) = u((max_atraso + 1 - j):(end-j));
    end 
end

Xpin = pinv(X);
teta = Xpin*yaux;
ynovo = X*teta;
erro = yaux - ynovo;
Erro = 0;
for i=1:length(erro)
    Erro = Erro + erro(i)^2;
end
Erro = Erro/length(erro);
figure 
plot(yaux)
hold
plot(ynovo,'r')

%ESTENDENDO O MÉTODO DOS MÍNIMOS QUADRADOS

ERRO = zeros(length(erro),ne);


for (i=1:k)
    for j = 1:ne
        ERRO(j+1:end,j) = erro(1:end-j);
    end
    X2 = [X,ERRO];
    Xpin2 = pinv(X2);
    teta2 = Xpin2*yaux;
    ynovo2 = X2*teta2;
    erro2 = yaux - ynovo2;
end

Erro2 = 0;
for i=1:length(erro2)
    Erro2 = Erro2 + erro2(i)^2;
end
Erro2 = Erro2/length(erro2);
figure
plot(yaux)
hold
plot(ynovo2,'r')
