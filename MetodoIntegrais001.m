% Metodo das Integrais
close all
clear all
clc

yp1 = 1.46;
yp2 = 1.0824;
ym = 0.67;
kc = 8;
A = 1;
deltat = 2.35;
yinfinito = (yp2*yp1 - ym^2)/(yp2 + yp1 - 2*ym)
K = yinfinito/(kc*(A - yinfinito))
kf = K*kc
zeta=(-log((yinfinito-ym)/(yp1-yinfinito)))/(sqrt(pi^2+(log((yinfinito-ym)/(yp1-yinfinito)))^2))
tau = (deltat/pi)*(zeta*sqrt(kf+1)+sqrt(zeta^2*(kf+1)+kf))*sqrt((1-zeta^2)*(kf+1))
taud = (2*deltat*sqrt((1-zeta^2)*(kf+1)))/(pi*(zeta*sqrt(kf+1)+sqrt(zeta^2*(kf+1)+kf)))