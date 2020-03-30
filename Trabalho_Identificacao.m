clc;
clear all;
close all;

resposta = load('out.txt');

valor_final=mean(resposta(end-50:end,3));  %ganho do final do sistema

normalizado=resposta(1:end,3)/valor_final;  %normalização
%%
%Parte 3
%Método das integrais
vetor_TetaTau=resposta(1:end,2)-normalizado;
TetaTau=trapz(vetor_TetaTau)*0.5;
vetor_Tau=normalizado(1:218);
Tau=exp(1)*trapz(vetor_Tau)*0.5; 
Teta=TetaTau-Tau;  %tempo morto
%simular resposta
H_int = tf([valor_final],[Tau 1]);  %Função de transferência de primeira ordem pelo métodos das integrais
H_int.OutputDelay=Teta;
simulacaoint=step(H_int,resposta(1:end,1)); %resposta ao degrau
figure
plot(resposta(1:end,1),simulacaoint,'red','linewidth',2)
title('Resposta ao Degrau')
grid on
hold on
plot(resposta(1:end,1),resposta(1:end,3))
legend('Método das Integrais','Sinal Amostrado',4);

%%
% Parte 4
%Método de Sundaresan
area = 1-normalizado;%Área sob o gráfico
m1 = trapz(area)*0.5;%Cálculo de m1
Mi = 1/(140-Teta);%obtido do gráfico
tm = 140;%obtido do gráfico
lamb = (tm - m1)*Mi;%Cálculo do lambida
eta = 0.18;%obtido do gráfico
T1 =(eta^((eta/(1-eta))))/Mi;%Constante de tempo T1
T2 = (eta^(1/(1-eta)))/Mi;%Constante de tempo T2
Td = m1 - T1 - T2;%Constante de tempo Td
s = tf('s');
%Função de transferencia para método de Sundaresan
H_sunda = ((exp(-Td*s))/((T1*s+1)*(T2*s+1)));

H_int.OutputDelay=Td;
simulacao_sunda=step(H_sunda,resposta(1:end,1));%Resposta ao degrau

%Figura do gráfico dos métodos de Sundaresan
figure
plot(resposta(1:end,1),simulacao_sunda,'red','linewidth',2)
hold on
plot(resposta(1:end,1),normalizado)
title('Resposta ao Degrau')
grid on
legend('Método de Sundaresan','Sinal Amostrado Normalizado',4);



%%
%Parte 5
%PRBS

%Saída PRBS do programa
out_prbs = load('out_prbs.txt');

%Simulação
simulacao_sun=lsim(H_sunda*valor_final,out_prbs(1:end,2),out_prbs(1:end,1));
simulacao_int=lsim(H_int,out_prbs(1:end,2),out_prbs(1:end,1));

%Gráfico das simulações
figure
grid on
grid on
plot(out_prbs(1:end,1),simulacao_int,'green','linewidth',1)
hold on
plot(out_prbs(1:end,1),simulacao_sun,'red','linewidth',1)
hold on
plot(out_prbs(1:end,1),out_prbs(1:end,3),'linewidth',1)
legend('Metodo das Integrais','Metodo de Sundaresan','Sinal Amostrado')
title('Comparativo dos Metodos ao Aplicar uma entrada PRBS')




%Cálculo das diferença do gráfico da simulçao(integrais) e saida PRBS
diferenca_int=(simulacao_int - out_prbs(1:end,3)).^2;

%Cálculo das diferença do gráfico da simulçao(Sundareasan) e saida PRBS
diferenca_sun=(simulacao_sun - out_prbs(1:end,3)).^2;

media_int = mean(diferenca_int);%Média das diferença(integrais)
media_sun = mean(diferenca_sun);%Média das diferença(sundareasan)

%%
%Parte 6

%determinar periodo de amostragem
figure
[c,lags]=xcorr((out_prbs(1:2:end,3)-mean(out_prbs(1:2:end,3))),30,'coeff');
stem(lags,c);
title('FAC');

y=out_prbs(1:2:end,3);
u=out_prbs(1:2:end,2);


%para 2 parâmetros
for i=2:200
    Psi2(i-1,:)=[y(i-1) u(i-1)];
end
Teta_1=pinv(Psi2)*y(2:end);  
erro=y(2:end)-Psi2*Teta_1;
AIC(2)=200*log(var(erro).^2)+2*2;

%para 3 parâmetros
for i=3:200
    Psi3(i-2,:)=[y(i-1) y(i-2) u(i-1)];
end
Teta_1=pinv(Psi3)*y(3:end);  
erro=y(3:end)-Psi3*Teta_1;
AIC(3)=200*log(var(erro).^2)+2*3;

%para 4 parâmetros
for i=3:200
    Psi4(i-2,:)=[y(i-1) y(i-2) u(i-1) u(i-2)];
end
Teta_1=pinv(Psi4)*y(3:end);  
erro=y(3:end)-Psi4*Teta_1;
AIC(4)=200*log(var(erro).^2)+2*4;

%para 5 parâmetros
for i=4:200
    Psi5(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2)];
end
Teta_1=pinv(Psi5)*y(4:end);  
erro=y(4:end)-Psi5*Teta_1;
AIC(5)=200*log(var(erro).^2)+2*5;

%para 6 parâmetros
for i=4:200
    Psi6(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3)];
end
Teta_1=pinv(Psi6)*y(4:end);  
erro=y(4:end)-Psi6*Teta_1;
AIC(6)=200*log(var(erro).^2)+2*6;

%para 7 parâmetros
for i=5:200
    Psi7(i-4,:)=[y(i-1) y(i-2) y(i-3) y(i-4) u(i-1) u(i-2) u(i-3)];
end
Teta_1=pinv(Psi7)*y(5:end);  
erro=y(5:end)-Psi7*Teta_1;
AIC(7)=200*log(var(erro).^2)+2*7;

%para 8 parâmetros
for i=5:200
    Psi8(i-4,:)=[y(i-1) y(i-2) y(i-3) y(i-4) u(i-1) u(i-2) u(i-3) u(i-4)];
end
Teta_1=pinv(Psi8)*y(5:end);  
erro=y(5:end)-Psi8*Teta_1;
AIC(8)=200*log(var(erro).^2)+2*8;

%para 9 parâmetros
for i=6:200
    Psi9(i-5,:)=[y(i-1) y(i-2) y(i-3) y(i-4) y(i-5) u(i-1) u(i-2) u(i-3) u(i-4)];
end
Teta_1=pinv(Psi9)*y(6:end);  
erro=y(6:end)-Psi9*Teta_1;
AIC(9)=200*log(var(erro).^2)+2*9;

%para 10 parâmetros
for i=6:200
    Psi10(i-5,:)=[y(i-1) y(i-2) y(i-3) y(i-4) y(i-5) u(i-1) u(i-2) u(i-3) u(i-4) u(i-5)];
end
Teta_1=pinv(Psi10)*y(6:end);  
erro=y(6:end)-Psi10*Teta_1;
AIC(10)=200*log(var(erro).^2)+2*10;

figure
hold on
plot(AIC);
title('Critério de Akaike')


%% Mínimos Quadrados
%Para 6 parâmetros

for i=4:200
    Psi6(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3)];
end
Teta_1 = pinv(Psi6)*y(4:end);  
erro = y(4:end)-Psi6*Teta_1;


%modelo ARX
y_MQ = zeros(1,200);
for k=4:200
    y_MQ(k)=Teta_1(1)*y_MQ(k-1)+Teta_1(2)*y_MQ(k-2)+Teta_1(3)*y(k-3)+Teta_1(4)*u(k-1)+Teta_1(5)*u(k-2)+Teta_1(6)*u(k-3);
end




%% Mínimos Quadrados Extendido

EMQ = []; %erro médio quadrático
v = zeros(1,200);
v(4:200) = y(4:200)-Psi6*Teta_1; % Erro 1
EMQ(1)= mean(v(6:190).^2);
Teta_1=[];


%Primeira iteração
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end

Teta_1(:,1)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,1);
EMQ(2)=mean(v(4:190).^2);


%segunda iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end

Teta_1(:,2)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,2);
EMQ(3)=mean(v(6:190).^2);

%terceira iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,3)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,3);
EMQ(4)=mean(v(4:190).^2);

%quarta iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,4)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,4);
EMQ(5)=mean(v(6:190).^2);

%quinta iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,5)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,5);
EMQ(6)=mean(v(4:190).^2);

%sexta iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,6)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,4);
EMQ(7)=mean(v(4:190).^2);

%sétima iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,7)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,7);
EMQ(8)=mean(v(4:190).^2);

%oitava iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,8)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,4);
EMQ(9)=mean(v(4:190).^2);

%nona iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,9)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,9);
EMQ(10)=mean(v(4:190).^2);

%décima iteração
clear Psi;
for i=4:200
    Psi(i-3,:)=[y(i-1) y(i-2) y(i-3) u(i-1) u(i-2) u(i-3) v(i-1) v(i-2) v(i-3)];
end
Teta_1(:,10)=pinv(Psi)*y(4:200);
v(4:200)=y(4:200)-Psi(:,1:4)*Teta_1(1:4,10);
EMQ(11)=mean(v(4:190).^2);




%% Modelo ARMAX

y_MQE = zeros(1,200);

for k=4:200
    y_MQE(k) = Teta_1(1)*y_MQE(k-1) + Teta_1(2)*y_MQE(k-2) + Teta_1(3)*y_MQE(k-3) + Teta_1(4)*u(k-1) + Teta_1(5)*u(k-2) + Teta_1(6)*u(k-3);
end


figure
plot(y,'b', 'LineWidth', 1.1);
title('Sinal Amostrado');
hold on
plot(y_MQ,'r', 'LineWidth', 1.1);
title('Mínimos Quadrados');
hold on
plot(y_MQE,'g', 'LineWidth', 1.1);
title('Mínimos Quadradros Extendidos');
hold on
plot(y,'b', 'LineWidth', 1.1)
hold on
plot(y_MQ,'r', 'LineWidth', 1.1)
hold on
plot(y_MQE,'g', 'LineWidth', 1.1)
legend('Sinal Amostrado', 'Mínimos Quadrados', 'Mínimos Quadrados Extendido')
title('Comparativo entre o Sinal Amostrado, MMQ e MMQE');



%comparação dos erros médios quadráticos dos dois métodos
EMQ_MQ = mean((y_MQ(4:200)-y(4:200)').^2);
EMQ_MQE= mean((y_MQE(4:200)-y(4:200)').^2);
