clc,clearvars,close all

syms z;

num= [1 0];
den= [3,-4,1];

zeros= roots(num);
poles= roots(den);
k=1;

[h,t]= impz(num,den,10);
subplot(2,1,1);
stem(t,h);
title('Using impz function')
xlabel('n')
ylabel('h(n)')
[r,p,k] = residuez(num , den)

transfer = (r(1)*z)/(z-p(1)) +  (r(2)*z)/(z-p(2)) ;
 pretty(transfer)
 h1 = iztrans(transfer)


 n =0:1:10 ;
subplot(2,1,2);
xlim([0 10]);
G = subs(h1,n);
stem(n,G);
title('Inverse Z transform from partial form')
xlabel('n')
ylabel('h(n)')


  
