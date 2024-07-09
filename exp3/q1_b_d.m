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

sum_xn_squared=0;
for i=1:N
    sum_xn_squared=sum_xn_squared+(abs(x_n(i)))^2;
end

sum_Xk_squared=0;
for i=1:N
    sum_Xk_squared=sum_Xk_squared+(abs(X_N(i,1)))^2;
end
sum_Xk_squared=sum_Xk_squared/N;
disp('Parsevals Theorem');
disp('Sum of |x[n]|^2');
disp(sum_xn_squared);
disp('Sum of (|X[k]|^2)/N');
disp(sum_Xk_squared);