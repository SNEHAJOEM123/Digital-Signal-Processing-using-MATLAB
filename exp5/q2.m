clc;
clear all;
close all;
N = 15;
n = 0:N-1;

w_rect = ones(1, N);
W_rect = abs(my_fft(w_rect, N));

w_bartlett = 1 - (2*abs(n - (N-1)/2) / (N-1));
W_bartlett = abs(my_fft(w_bartlett, N));

w_hanning = 0.5 * (1 - cos(2*pi*n/(N-1)));
W_hanning = abs(my_fft(w_hanning, N));

w_hamming = 0.54 - 0.46 * cos(2*pi*n/(N-1));
W_hamming = abs(my_fft(w_hamming, N));

alpha = 0.16;
a0 = (1 - alpha) / 2;
a1 = 0.5;
a2 = alpha / 2;
w_blackman = a0 - a1 * cos(2*pi*n/(N-1)) + a2 * cos(4*pi*n/(N-1)); % Blackman window function
W_blackman = abs(my_fft(w_blackman, N));

n1 = -1*(N-1)/2 : 1: (N-1)/2;

figure
subplot(2,1,1);
stem(n1, w_rect,"filled");
title('Rectangular Window');
xlabel('n');
ylabel('w[n]');
subplot(2,1,2);
stem(n, W_rect,"filled");
title('Magnitude Spectrum (Rectangular Window)');
xlabel('\omega');
ylabel('|W(\omega)|');


figure
subplot(2,1,1);
stem(n1, w_bartlett,"filled");
title('Bartlett (Triangular) Window');
xlabel('n');
ylabel('w[n]');
subplot(2,1,2);
plot(n, W_bartlett,'LineWidth',1);
title('Magnitude Spectrum (Bartlett Window)');
xlabel('\omega');
ylabel('|W(\omega)|');


figure
subplot(2,1,1);
stem(n1, w_hanning,"filled");
title('Hanning Window');
xlabel('n');
ylabel('w[n]');
subplot(2,1,2);
plot(n, W_hanning,'LineWidth',1);
title('Magnitude Spectrum (Hanning Window)');
xlabel('\omega');
ylabel('|W(\omega)|');


figure
subplot(2,1,1);
stem(n1, w_hamming,"filled");
title('Hamming Window');
xlabel('n');
ylabel('w[n]');
subplot(2,1,2);
stem(n, W_hamming,"filled");
title('Magnitude Spectrum (Hamming Window)');
xlabel('\omega');
ylabel('|W(\omega)|');


figure
subplot(2,1,1);
stem(n1, w_blackman,"filled");
title('Blackman Window');
xlabel('n');
ylabel('w[n]');
subplot(2,1,2);
plot(n, W_blackman,'LineWidth',1);
title('Magnitude Spectrum (Blackman Window)');
xlabel('\omega');
ylabel('|W(\omega)|');




function X = my_fft(x, N)
X = zeros(1, N);
for k = 0:N-1
for n = 0:N-1
X(k+1) = X(k+1) + x(n+1) * exp(-1i*2*pi*k*n/N);
end
end
end