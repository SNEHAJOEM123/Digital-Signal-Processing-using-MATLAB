clc,clearvars,close all
syms z;
zeros= [0.3,2.5,-0.2+1i*0.4, -0.2-1i*0.4].';
poles= [0.5,-0.75,0.6+1i*0.7,0.6-1i*0.7];
k=3.9;
[b,a] = zp2tf(zeros,poles,k);

Transfer = (b(1)*z^4+b(2)*z^3+b(3)*z^2+b(4)*z+b(5))/ (a(1)*z^4+a(2)*z^3+a(3)*z^2+a(4)*z+a(5));
pretty(Transfer)


