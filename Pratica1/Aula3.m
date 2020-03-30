% Aula 3 Identificacao de Sistemas

% Criar sistema de primeira ordem com tempo morto e ruídos

Gp1 = tf(3,[10 1]); % 3/10s+1 => 10s de cte de tempo
Gp1.OutputDelay = 5;  % tempo morto de 5s
t = 0:0.05:50;
y_deg1 = step(Gp1,t);
u_deg = ones(1,length(y_deg1));
r_deg = 0.1*randn(1,length(y_deg1));
y_deg_r1 = y_deg1 + r_deg';


figure
plot(t,r_deg)
figure
plot(t,y_deg_r1)

save dados_ordem1 y_deg_r1 u_deg t

