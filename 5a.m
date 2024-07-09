clc;
clear all;
close all;

Fpass = 1000;
Fstop = 1500;
Fs = 8000;

wp = 2 * pi * Fpass / Fs;
ws = 2 * pi * Fstop / Fs;
wc = (wp + ws) / 2;

N = 81;
M = N - 1;
n = 0 : 1 : M;
df = pi / (Fs/2);
f = -pi : df : pi-df;

[H, hd] = myLP(Fs, wc, df, M);

ham_win = 0.54 - 0.46*cos(2*pi*n/M);
Filter = ham_win .* hd;

HF = abs(fftshift(fft(Filter)));

ax = (-40:1:40) / 40;
t1 = 0 : 1 : length(ax)-1;
x = sin(2*pi* 200 * t1/Fs) + sin(2*pi* 500 * t1/Fs) + sin(2*pi* 1000 * t1/Fs) + sin(2*pi* 2000 * t1/Fs) + sin(2*pi* 4000 * t1/Fs);
X = fftshift(abs(fft(x)));

figure("Name", 'Ideal filter')
subplot(2,1,1)
plot(f / pi, H, 'LineWidth', 1.5);
grid;
title('Ideal low pass filter')
ylabel('Amplitude')
xlabel('Frequency (x pi)')

subplot(2,1,2)
stem(n, hd, 'LineWidth', 1.5);
grid;
title('Ideal low pass filter in time domain')
ylabel('Amplitude')
xlabel('n')
figure("Name", 'Filter by Windowing')

subplot(3,1,1)
plot(n, ham_win, 'LineWidth', 1.5);
grid;
title('Hamming window')
ylabel('Amplitude')
xlabel('n')

subplot(3,1,2)
stem(n, Filter, 'LineWidth', 1.5);
grid;
title('LPF with hamming window')
ylabel('Amplitude')
xlabel('n')

subplot(3,1,3)
bx=(-40:1:40)/40
plot(bx, HF, 'LineWidth', 1.5)
grid;
title('LPF with hamming window - frequency domain')
ylabel('Amplitude')
xlabel('win pi')
figure("Name", 'Magnitude and phase of Filter');
freqz(Filter, 1);
grid on;
title('LPF with hamming window - magnitude (dB) and phase')
figure("Name", "For Low pass filter")
subplot(4,1,1)
plot(bx, HF, 'LineWidth', 1.5)
grid;
title('Low pass filter')
ylabel('Amplitude')
xlabel('win \pi')
subplot(4,1,2)
stem(t1, x, 'LineWidth', 1.5)
grid;
title('Input signal x')
ylabel('Amplitude')
xlabel('n')
subplot(4,1,3)
stem(ax*4000, X, 'LineWidth', 1.5)
grid;
title('Signal in frequency domain')
ylabel('Amplitude')
xlabel('win \pi')
X_filterd = X .* HF;
subplot(4,1,4)
stem(ax*4000, X_filterd, 'LineWidth', 1.5)
grid;
title('Signal in frequency domain after filtering')
ylabel('Amplitude')
xlabel('win \pi')
figure
plot(abs((x)))
function [H, hd] = myLP(Fs, wc, df, M)
    H = zeros(1, Fs);
    H(ceil(Fs/2 - wc/df) : Fs/2 + wc/df) = 1;
    n = 0 : 1 : M;
    m = n - M/2;
    hd = (wc/pi) * sinc((wc/pi) * m);
end
