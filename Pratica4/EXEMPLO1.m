clc
clear all
close all
fs=1
y=zeros(1,2048);
u=randn(1,2048)';

y=dlsim([1 0.5],[1 -1.5 0.7],u); %estima a resposta para a entrada u
y=y+0.5*randn(size(y));% ruido
plot(y)

%Auto Correlação
[ruu,lags]=xcorr (u);
R = xcorr(u,u);
S = xcorr(y,u);
k=2048;


ruum=zeros([2048,2048])


% figure 
% subplot(2,1,1,'align');
% plot(y)
% grid on
% subplot(2,1,2,'align');
% plot(lags,ruu)
% grid on

for i=1:2048
    for j=1:2048
      ruum(i,j)=R(k-1);
    end
   k=k+1;
end

for t=2047:4095
    d(1,t)= S(t+1);
end
h = d*inv(ruum);
    