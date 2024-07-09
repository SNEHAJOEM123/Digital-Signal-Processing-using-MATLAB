clc;
clear all;
close all;

f_pass = 1000; %The specifications which are given
f_stop = 1500;
f_s = 8000;
w_p = 2 * pi * f_pass / f_s;
w_s = 2 * pi * f_stop / f_s;
w_c = (w_p + w_s) / 2;
N = 41;
M = N - 1;
n = 0:1:M;
df = 2 * pi / f_s;
f = -pi:df:pi-df;
[H, hd] = myLP(f_s, w_c, df, M);
hamming_window = 0.54 - 0.46 * cos(2 * pi * n / M); %Hamming window
filter = hamming_window  .* hd;
HF = abs(fftshift(fft(filter)));


figure;
subplot(2,1,1);
stem(n, hd);
title('Ideal low pass filter in time domain');
ylabel('Amplitude');
xlabel('n');
subplot(2,1,2);
plot(f / pi, H);
title('Ideal low pass filter in frequency domain');
ylabel('Amplitude');
xlabel('Frequency');


figure;
subplot(3,1,1);
plot(n, hamming_window);
title('Hamming window');
ylabel('Amplitude');
xlabel('n');
subplot(3,1,2);
stem(n, filter);
title('Low Pass Filter with Hamming window in time domain');
ylabel('Amplitude');
xlabel('n');

ax = (-20:1:20) / 20;
subplot(3,1,3)
plot(ax, HF)
title('Low Pass Filter with Hamming window in frequency domain');
ylabel('Amplitude');
xlabel('Frequency');

figure;
freqz(filter, 1);
title('Low Pass filter  with Hamming window - The magnitude (dB) and phase plots');

function [H, hd] = myLP(f_s, w_c, df, M) %function for ideal LPF
H = zeros(1, f_s);
H(ceil(f_s/2 - w_c/df):f_s/2 + w_c/df) = 1;
n = 0:1:M;
m = n - M/2;
hd = (w_c/pi) * sinc((w_c/pi) * m);
end
