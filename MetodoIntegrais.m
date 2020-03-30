clear all;
close all;
clc; 

%Teta=5 + tal=10(constante de tempo) = integral (0 a infiito) (u(t) - y(y))
%dt

%obter dados do processo
load dados_ordem1


%fazendo a media

ym = mean(y_deg_r1(end-50:end))
y_deg_r2 = y_deg_r1/ym;

%Area do trapezio
Area1 = trapz(t,y_deg_r2)
%Area2 = trapz(t(1:ind),y(1:ind));
Area2 = trapz(t,u_deg)

AreaTotal= Area2-Area1

%[a b] = find (t<tetaTau)
%[ab] = find (t<14.4456)
%ind=max(find(t<14.4456))
[ab]=max(find(t<AreaTotal))

tal = exp(1)*(trapz(t(1:290),y_deg_r2(1:290)))%Atila


teta = AreaTotal - tal

%Grafico não normalizado
figure 
subplot(2,1,1,'align');
plot(t,y_deg_r1)
legend('Saída: Não Normalizado','Location','SouthEast');
xlabel('Tempo em Segundos');
ylabel('Ganho em V');
grid on;

%Grafico Normalizado
subplot(2,1,2,'align');
plot(t,y_deg_r2)
legend('Saída: Normalizado','Location','SouthEast');
xlabel('Tempo em Segundos');
ylabel('Ganho em V');
grid on;
break