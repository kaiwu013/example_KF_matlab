clc;
clear all
close all

%load veter with raw data
load raw

time=1:length(raw);
Q=1.1;
R=5;
%Q>R:trust raw value
%R>Q:trust computer

x_hat=zeros(1,length(raw));
%x_hat:estimate of the singal
P=zeros(1,length(raw));

A=1.01;
x_hat(1)=raw(1);

for ii=2:length(raw)
    % KF algorithm
    
    xhatm(ii)=A*x_hat(ii-1);
    Pmx(ii)=A*P(ii-1)*A'+Q;
    
    
    Kx(ii)=Pmx(ii)/(Pmx(ii)+R);
    x_hat(ii)=xhatm(ii)+Kx(ii)*(raw(ii)-xhatm(ii));
    P(ii)=(1-Kx(ii))*Pmx(ii);
    
end

tat=sprintf('Q=%g, R=%g, A=%g',Q,R,A);
plot(time,raw,'.--',time,x_hat)
grid on
legend('raw','estimated','Location','southeast')
title(tat)
xlabel('time')
ylabel('amplitude')
print -dpng test
