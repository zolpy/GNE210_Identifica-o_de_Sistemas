clear all
close all
clc

ww = sqrt(3)*randn (10000, 1);
[c_ww,lags] =xcorr(ww, 10, 'biased');
% figure
% stem(lags,c_ww)

ww2 = randn(10000,1);
[c_ww,lags] = xcorr(ww,ww2,10,'coeff');
% figure
% stem(lags,c_ww)

t=0:0.1:100;
s1 = sin(pi*t);
s2 = cos(pi*t);
[c_ww,lags] = xcorr(s1,s2,40,'coeff');
% figure
% stem(lags,c_ww)

t=0:0.1:100;
s1 = sin(pi*t)+ randn(length(t),1)';
s2 = cos(pi*t) + randn(length(t),1)';
[c_ww,lags] = xcorr(s1,s2,40,'coeff');
% figure
% stem(lags,c_ww)

figure 
plot(t,s1);
hold on
% plot(t,s2,'r')