clc;
clear;
close all;
N=8;
dft=zeros(N,N);
W=exp(-2i*pi/N);
for n=0:N-1
    for k=0:N-1
        dft(n+1,k+1)=W^(n*k);
    end
end
idft=conj(dft)/N;

x_n=[2,1+1i,3+4i,7i,8,5+3i,3,9i];
X_N=dft*x_n.';

xe=0.5*(x_n+conj(flip(x_n)));
xo=0.5*(x_n-conj(flip(x_n)));

Xe=dft*xe.';
Xo=dft*xo.';
X1=Xe+Xo;

figure('Name','Symmetry Property');
subplot(2,1,1);
stem(real(X_N));
xlabel('n');
ylabel('Magnitude');
title('Real part of dft of x[n]');
subplot(2,1,2);
stem(imag(X_N));
title('Imaginary part of DFT of x[n]');
xlabel('n');
ylabel('Magnitude');

figure('Name','Symmetry Property');
subplot(2,1,1);
stem(Xe);
xlabel('n');
ylabel('Magnitude');
title('DFT of xe[n]');
subplot(2,1,2);
stem(Xo);
title('DFT of xo[n]');
xlabel('n');
ylabel('Magnitude');


figure('Name','Symmetry Property');
subplot(2,1,1);
stem(real(X1));
xlabel('n');
ylabel('Magnitude');
title('Real part of sum of dft(xe) and dft(xo)');
subplot(2,1,2);
stem(imag(X1));
title('Imaginary part of sum of dft(xe) and dft(xo)');
xlabel('n');
ylabel('Magnitude');
