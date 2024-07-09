clc;
clear;
close all;

x_n=[1,2i,3+6i,4+5i,3];
h_n=[4,9i,5+7i,6+1i];
L=length(x_n);
M=length(h_n);
x_n_padded=[x_n,zeros(1,M-1)];
h_n_padded=[h_n,zeros(1,L-1)];
N=L+M-1;

dft=zeros(N,N);
W=exp(-2i*pi/N);
for n=0:N-1
    for k=0:N-1
        dft(n+1,k+1)=W^(n*k);
    end
end
idft=conj(dft)/N;

X=dft*x_n_padded.';
H=dft*h_n_padded.';
Y=X.*H;
y=idft*Y;
y1=conv(x_n,h_n);

figure('Name','Convolution');
subplot(2,1,1);
stem(abs(y));
xlabel('n');
ylabel('Magnitude');
title('Magnitude of convolution using dft');
subplot(2,1,2);
stem(angle(y));
title('Phase of convolution using dft');
xlabel('n');
ylabel('Phase');


figure('Name','Convolution');
subplot(2,1,1);
stem(abs(y1));
xlabel('n');
ylabel('Magnitude');
title('Magnitude of convolution using conv function');
subplot(2,1,2);
stem(angle(y));
title('Phase of convolution using conv function');
xlabel('n');
ylabel('Phase');

