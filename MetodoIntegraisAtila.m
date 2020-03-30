clear all 
close all
clc

%Obter dados do processo
load dados_ordem1


figure
plot(t,y_deg_r1)

grid on

%normalizando

y_deg_r1mean=mean(y_deg_r1(end-50:end));
y_deg_r1 = y_deg_r1/y_deg_r1mean;

figure 
plot(t,y_deg_r1)

integral = trapz(t,y_deg_r1)

u_integral = trapz(t,u_deg)

Area = u_integral - integral

[ab] = max(find(t<14.4889))

tal = exp(1)*(trapz(t(1:290),y_deg_r1(1:290)))

grid on
 teta = 14.4889 - 9.3089


break