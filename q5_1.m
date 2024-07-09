clc;
clear all;
close all;
Fpass = 1500;
Fstop = 1000;
Fs = 8000;
wp = 2 * pi * Fpass / Fs;
ws = 2 * pi * Fstop / Fs;
wc = (wp + ws) / 2;
N = 81;
M = N - 1;
n = 0 : 1 : M;
df = pi / (Fs/2);
f = -pi : df : pi - df;
[HI, hn] = hpf(Fs, wp, ws, N, df);
w = 0.54 - 0.46 * cos(2*pi*n / (N - 1));%hamming window
hn = hn .* w;%
Hw = abs(fftshift(fft(hn, Fs)));
t2 = 0 : 1 : 4000;
y = sin(2 * pi * 200 * t2 / Fs) + sin(2 * pi * 500 * t2 / Fs) + sin(2 * pi * 1000 * t2 / Fs) + sin(2 * pi * 2000 * t2 / Fs) + sin(2 * pi * 4000 * t2 / Fs);
Y = fftshift(abs(fft(y, 8000)));
Y_filtered = Y .* Hw;
figure;
subplot(2,1,1);
plot(f/pi, HI, 'LineWidth', 1);
title('IDEAL HIGH PASS FILTER');
ylabel('Amplitude --->');
xlabel('Normalized Frequency in terms of \pi');
grid on;
subplot(2,1,2);
stem(hn, 'filled');
title("IDEAL IMPULSE RESPONSE OF HPF");
ylabel('Amplitude --->');
xlabel('n (samples) --->');
grid on;
figure;
subplot(3,1,1);
stem(w, 'filled');
title('HAMMING WINDOW');
ylabel('Amplitude --->');
xlabel('n (samples) --->');
grid on;
subplot(3,1,2);
stem(hn, 'filled');
title("WINDOWED IMPULSE RESPONSE (FIR HPF FILTER)");
ylabel('Amplitude --->');
xlabel('n (samples) --->');
grid on;
subplot(3,1,3);
plot(f/pi, Hw, 'LineWidth', 1);
title("HPF WITH HAMMING WINDOW - FREQUENCY DOMAIN");
ylabel('Gain in dB');
xlabel('Normalized frequency in terms of \pi');
grid on;
figure;
freqz(hn, 1);
grid on;
title('HPF WITH HAMMING WINDOW - MAGNITUDE(dB) and PHASE');
figure("Name", "For High pass filter")
subplot(4,1,1);
plot(f / pi, Hw, 'LineWidth', 1)
title('High pass filter');
ylabel('Amplitude');
xlabel('win \pi');
grid on;
subplot(4,1,2)
plot(t2, y, 'LineWidth', 1)
title('Input signal y');
ylabel('Amplitude');
xlabel('n');
grid on;
subplot(4,1,3)
plot(f/pi, Y, 'LineWidth', 1);
title('Signal in frequency domain')
ylabel('Amplitude')
xlabel('win \pi')
grid on;
subplot(4,1,4);
plot(f, Y_filtered, 'LineWidth', 1)
title('Signal in frequency domain after filtering');
ylabel('Amplitude');
xlabel('win \pi');
grid on;
function [H, hI] = hpf(Fs, wp, ws, N, df)
    no = (N - 1) / 2;
    wc = (wp + ws) / 2;
    n  = 0 : N - 1;
    H  = zeros(1, Fs);
    H( ceil(Fs/2 - wc/df) : Fs/2 + wc/df ) = 1;
    hI = -sin(wc*(n-no)) ./ (pi*(n-no));
    hI(no + 1) = 1 - wc/pi;
    H = 1 - H;
end