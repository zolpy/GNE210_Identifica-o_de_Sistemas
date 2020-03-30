clear all
close all
clc

%Minha entrada
% y = [12.2 11.8 11.6 11.6 11.8 12.2 13 14.4 16.2 15.8]
% u = [2.5 2.5 2.5 2.5 2.5 2.23 2.2 2.2 2.21 2.2];

y = zeros(1,2048)
u = randn(1,2048)'
y=dlsim([1 0.5], [1 -1.5 0.7],u);
y = y + 0.5*randn(size(y));

ny = 2; %numero de coluna de y
nu = 2; %numero de coluna de u
MaxAtraso = max([ny nu])
yAux = y(MaxAtraso+1:end)

%Matriz de Regressores
for i =1:ny
    MatRegressores(:,i) = y(MaxAtraso+1-i:end-i')'
end

for i =1:nu
    MatRegressores(:,ny+i) = u(MaxAtraso+1-i:end-i')'
end

teta =pinv(MatRegressores)*yAux


[r_uu,lags] = xcorr(u,1000,'biased');
[r_uy,lags] = xcorr(y,u,1000,'biased');


for l = 1:1000 %linha
     for c = 1:1000 %coluna
        Ruu(l,c)=r_uu(1000 - c + l);
    end
end

% H = Ruu^(-1) * r_uy(1000:1999);
% figure
% % plot(H)
% t=0:0.1:100;
% s1 = sin(pi*t)+ randn(length(t),1)';
% s2 = cos(pi*t) + randn(length(t),1)';
% [c_ww,lags] = xcorr(s1,s2,40,'coeff');
%  figure 
% plot(t,s1);
