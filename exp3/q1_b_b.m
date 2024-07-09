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
no=2;
x_n1=circshift(x_n,no);
X_N1=dft*x_n1.';

X2=zeros(1,N);
for n=0:N-1
        X2(n+1)=X_N(n+1)*W^(no*n);
end

figure('Name','Time Shifting Property');
subplot(2,1,1);
stem(real(X_N1));
xlabel('n');
ylabel('Magnitude');
title('Real part of DFT of x[n-no]');
subplot(2,1,2);
stem(imag(X_N1));
title('Imaginary part of DFT of x[n-no]');
xlabel('n');
ylabel('Magnitude');


figure('Name','Time Shifting Property');
subplot(2,1,1);
stem(real(X2));
xlabel('n');
ylabel('Magnitude');
title('Real part of X[k]*exp(2*pi*no*k/N)');
subplot(2,1,2);
stem(imag(X2));
title('Imaginary part of X[k]*exp(2*pi*no*k/N)');
xlabel('n');
ylabel('Magnitude');

disp(X_N1);
disp(X2);