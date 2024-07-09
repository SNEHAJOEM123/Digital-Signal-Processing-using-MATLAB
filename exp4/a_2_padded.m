clc, clearvars,close all

% Test signals
N = 16;
fs = 100; % Sampling frequency

% a. Rectangular signal
rect_signal = ones(1, N);

% Observe the effect of zero padding
figure;
paddedFFT1 = fft_radix2([rect_signal, zeros(1, N)]);
idft_paddedFFT1=ifft_radix2(paddedFFT1);
subplot(3,1,1);
stem(rect_signal);
title('Rectangular signal');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 2);
stem(abs(paddedFFT1));
title('DFT of rectangular signal padded with N zeros');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 3);
stem(abs(idft_paddedFFT1));
title('Reconstructed signal');
xlabel('n');
ylabel('Magnitude');

figure;
paddedFFT2 = fft_radix2([rect_signal, zeros(1, 3*N)]);
idft_paddedFFT2=ifft_radix2(paddedFFT2);
subplot(3,1,1);
stem(rect_signal);
title('Rectangular signal');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 2);
stem(abs(paddedFFT2));
title('DFT of rectangular signal padded with 3*N zeros');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 3);
stem(abs(idft_paddedFFT2));
title('Reconstructed signal');
xlabel('n');
ylabel('Magnitude');

figure;
paddedFFT3 = fft_radix2([rect_signal, zeros(1, 7*N)]);
idft_paddedFFT3=ifft_radix2(paddedFFT3);
subplot(3,1,1);
stem(rect_signal);
title('Rectangular signal');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 2);
stem(abs(paddedFFT3));
title('DFT of rectangular signal padded with 7*N zeros');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 3);
stem(abs(idft_paddedFFT3));
title('Reconstructed signal');
xlabel('n');
ylabel('Magnitude');





function X = fft_radix2(x)
N = length(x);
if N <= 1
X = x;
else
even = fft_radix2(x(1:2:end));
odd = fft_radix2(x(2:2:end));
factor = exp(-2i * pi / N);
X = [even + factor.^(0:N/2-1) .* odd, even - factor.^(0:N/2-1) .* odd];
end
end

function x = ifft_radix2(X)
N = length(X);
if N <= 1
x = X;
else
even = ifft_radix2(X(1:2:end));
odd = ifft_radix2(X(2:2:end));
factor = exp(2i * pi / N);
x = [even + factor.^(0:N/2-1) .* odd, even - factor.^(0:N/2-1) .* odd] /2;
end
end