clc,clearvars,close all

syms z;
r = [0.5 -0.1667];
p = [1 1/3];
k = [] ;
[b,a] = residuez(r,p,k);
h = ( b(1)*z^-1)/(a(3)*z^-2+a(2)*z^-1+a(1)) ;
pretty(h)

