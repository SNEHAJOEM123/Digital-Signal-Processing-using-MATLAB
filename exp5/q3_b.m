clc;
clear all;
close all;

f_pass = 1500; %Given specifications
f_stop = 1000;
f_s = 8000;
w_p = 2 * pi * f_pass / f_s; %calculation of digital frequency
w_s = 2 * pi * f_stop / f_s;
w_c = (w_p + w_s) / 2;
N = 65;
M = N - 1;
n = 0 : M;
df = 2 * pi / f_s;
f = -pi : df : pi - df;
[HI, hn] = hpfilter(f_s, w_p, w_s, N, df);
w = 0.54 - 0.46 * cos(2 * pi * n / (N - 1));
hn = hn .* w; %Multiplying with window function
Hw = abs(fftshift(fft(hn, f_s)));


figure();
subplot(2,1,1)
stem(hn);
title("Ideal High Pass Filter in Time domain");
ylabel('Amplitude');
xlabel('n');
subplot(2,1,2)
plot(f / pi, HI);
title('Ideal High Pass Filter in frequency domain');
ylabel('Amplitude');
xlabel('Frequency');


figure();
subplot(3,1,1)
stem(w);
title('Hamming Window');
ylabel('Amplitude');
xlabel('n');
subplot(3,1,2)
stem(hn);
title("High Pass Filter with Hamming window in Time domain");
ylabel('Amplitude');
xlabel('n');
subplot(3,1,3)
plot(f / pi, Hw);
title("High Pass Filter with Hamming window in frequency domain");
ylabel('Amplitude');
xlabel('frequency');

figure();
freqz(hn, 1);
title('High Pass Filter with Hamming window -magnitude(dB) and phase');

function [H, hI] = hpfilter(Fs, wp, ws, N, df) %Ideal HPF
H = zeros(1, Fs);
no = (N - 1) / 2;
wc = (wp + ws) / 2;
n = 0 : N - 1;
H(ceil(Fs / 2 - wc / df) : Fs / 2 + wc / df) = 1;
hI = -sin(wc * (n - no)) ./ (pi * (n - no));
hI(no + 1) = 1 - wc / pi;
H = 1 - H;
end
