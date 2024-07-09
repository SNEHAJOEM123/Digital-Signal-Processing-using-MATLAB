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
X_N1=dft*X_N;

x_n1=zeros(1,N);
x_n1(1)=x_n(1);
for n=2:N
    x_n1(n)=x_n(N-n+2);
end

x_n2=N*x_n1;

figure('Name','Duality Property');
subplot(2,1,1);
stem(real(X_N1));
xlabel('n');
ylabel('Magnitude');
title('Real part of DFT of X[k]');
subplot(2,1,2);
stem(imag(X_N1));
title('Imaginary part of DFT of X[k]');
xlabel('n');
ylabel('Magnitude');


figure('Name','Duality Property');
subplot(2,1,1);
stem(real(x_n2));
xlabel('n');
ylabel('Magnitude');
title('Real part of N*x[N-k]');
subplot(2,1,2);
stem(imag(x_n2));
title('Imaginary part of N*x[N-k]');
xlabel('n');
ylabel('Magnitude');






