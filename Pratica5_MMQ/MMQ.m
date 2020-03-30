clear all
close all
clc

% Minha entrada
y = [12.2 11.8 11.6 11.6 11.8 12.2 13 14.4 16.2 15.8]
u = [2.5 2.5 2.5 2.5 2.5 2.23 2.2 2.2 2.21 2.2];

ny = 2; %numero de coluna de y
nu = 3; %numero de coluna de u
MaxAtraso = max([ny nu])
yAux = y(MaxAtraso+1:end)

%Matriz de Regressores
for i =1:ny
    MatRegressores(:,i) = y(MaxAtraso+1-i:end-i')'
end

for i =1:nu
    MatRegressores(:,ny+i) = u(MaxAtraso+1-i:end-i')'
end

teta =pinv(MatRegressores)*yAux'


