clc, clearvars,close all

% Test signals
N = 16;
fs = 100; % Sampling frequency

% a. Rectangular signal
rect_signal = ones(1, N);
X_rect = fft_radix2(rect_signal);
rect_reconstructed = ifft_radix2(X_rect);

% b. Sinusoidal signal
t = 0:(1/fs):(N-1)*(1/fs);
sinusoidal_signal = sin(2 * pi * 5 * t); % 5 Hz sinusoidal signal
X_sinusoidal = fft_radix2(sinusoidal_signal);
sinusoidal_reconstructed = ifft_radix2(X_sinusoidal);

% c. Unit impulse
unit_impulse = zeros(1, N);
unit_impulse(1) = 1;
X_impulse = fft_radix2(unit_impulse);
impulse_reconstructed = ifft_radix2(X_impulse);

% Plotting
figure;
subplot(3, 1, 1);
stem(rect_signal);
title('Rectangular Signal (Original)');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 2);
stem(abs(X_rect));
title('DFT of Rectangular Signal');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 3);
stem(abs(rect_reconstructed));
title(' Reconstructed Signal');
xlabel('n');
ylabel('Magnitude');

figure;
subplot(3, 1, 1);
stem(sinusoidal_signal);
title('Sinusoidal Signal (Original)');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 2);
stem(abs(X_sinusoidal));
title('DFT of Sinusoidal Signal');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 3);
stem(sinusoidal_reconstructed);
title('Reconstructed Signal');
xlabel('n');
ylabel('Magnitude');

figure;
subplot(3, 1, 1);
stem(unit_impulse);
title('Impulse Signal (Original)');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 2);
stem(X_impulse);
title('DFT of Impulse Signal');
xlabel('n');
ylabel('Magnitude');
subplot(3, 1, 3);
stem(impulse_reconstructed);
title('Reconstructed Signal (Original)');
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