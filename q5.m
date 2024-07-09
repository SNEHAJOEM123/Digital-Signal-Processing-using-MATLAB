clc;
clear;
Fpass = 1500;
Fstop = 1000;
Fs = 8000;
wp = 2 * pi * Fpass / Fs;
ws = 2 * pi * Fstop / Fs;
wc = (wp + ws) / 2;
N = 65;
M = N - 1;
n = 0 : M;
df = 2 * pi / Fs;
f = -pi : df : pi - df;
[HI, hn] = hpfilter(Fs, wp, ws, N, df);
figure();
subplot(211)
plot(f / pi, HI, 'LineWidth', 1.5);
grid;
title('IDEAL HIGH PASS FILTER');
ylabel('Amplitude --->');
xlabel('Normalized Frequency in terms of \pi');
subplot(212)
stem(hn, 'filled', 'LineWidth', 1.5);
title("IDEAL IMPULSE RESPONSE OF HPF");
ylabel('Amplitude --->');
xlabel('n (samples) --->');
grid on;
w = 0.54 - 0.46 * cos(2 * pi * n / (N - 1));
hn = hn .* w;
Hw = abs(fftshift(fft(hn, Fs)));
figure();
subplot(311)
stem(w, 'filled', 'LineWidth', 1.5);
grid;
title('HAMMING WINDOW');
ylabel('Amplitude --->');
xlabel('n (samples) --->');
subplot(312)
stem(hn, 'filled', 'LineWidth', 1.5);
title("WINDOWED IMPULSE RESPONSE (FIR HPF FILTER)");
ylabel('Amplitude --->');
xlabel('n (samples) --->');
grid on;
subplot(313)
plot(f / pi, Hw, 'LineWidth', 1.5);
title("HPF WITH HAMMING WINDOW - FREQUENCY DOMAIN");
ylabel('Gain in dB');
xlabel('Normalized frequency in terms of \pi');
grid;
figure();
freqz(hn, 1);
grid on;
title('HPF WITH HAMMING WINDOW - MAGNITUDE(dB) and PHASE');
% Save filter variables for question 7
%save('highpass.mat', "HF", "ax", "Fs")
function [H, hI] = hpfilter(Fs, wp, ws, N, df)
H = zeros(1, Fs);
no = (N - 1) / 2;
wc = (wp + ws) / 2;
n = 0 : N - 1;
H(ceil(Fs / 2 - wc / df) : Fs / 2 + wc / df) = 1;
hI = -sin(wc * (n - no)) ./ (pi * (n - no));
hI(no + 1) = 1 - wc / pi;
H = 1 - H;
end