clc,clearvars,close all
[x,fs1]=audioread("acoustic.wav");
[h,fs2]= audioread("impulse_cathedral.wav");
%xn=[exp(-1i*2*pi/2),exp(-1i*2*pi/3),exp(-1i*2*pi/4),exp(-1i*2*pi/5)];
xn= x.';
hn= h.';
m= length(x);
n= length(h);
max_value = 2^max(ceil(log2(m)),ceil(log2(n)));
xo= [xn, zeros(1,max_value-m)];
ho= [hn, zeros(1,max_value-n)];
tic
X= fft_radix2(xo);
H= fft_radix2(ho);
Y= (X).*(H);
yconv= real(ifft_radix2(Y));
conv_time= toc;
disp("Time required for convolution using fft is:");
disp(conv_time);
plot(yconv);

yfun= real(conv(xn,hn));

function X = fft_radix2(x)
N = length(x);
if N == 1
X = x;
else
even = fft_radix2(x(1:2:N-1));
odd = fft_radix2(x(2:2:N));
factor = exp(-2i * pi / N) .^ (0:N/2-1);
X = [even + factor .* odd, even - factor .* odd];
end
end

function x = ifft_radix2(X)
N = length(X);
if N == 1
x = X;
else
even = ifft_radix2(X(1:2:N-1));
odd = ifft_radix2(X(2:2:N));
factor = exp(2i * pi / N) .^ (0:N/2-1);
x = [even + factor .* odd, even - factor .* odd] / 2;
end
end