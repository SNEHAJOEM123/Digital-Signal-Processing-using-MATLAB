clc;
clear all;
close all;

N = 55;%  N values are taken as 15 or 55
n=0:(N-1);
blackman_window = 0.42 - 0.5 * cos(2 * pi * n / (N-1)) + 0.08 * cos(4 * pi * n / (N-1));%Blackman window
subplot(2,1,1)
plot(n,blackman_window);
title('Blackman Window for N = 55');
xlabel('n');
ylabel('Amplitude');

spectrum_blackman_window = abs(fft_radix2([blackman_window,zeros(1,256-length(blackman_window))]));%zero padding
frequencies = linspace(0, 1, length(spectrum_blackman_window));
spectrum_blackman = [spectrum_blackman_window(length(spectrum_blackman_window)/2:length(spectrum_blackman_window)),spectrum_blackman_window(1:length(spectrum_blackman_window)/2)];
subplot(2,1,2)
plot(-length(frequencies)/2:length(frequencies)/2, spectrum_blackman);
title('Magnitude Spectrum of Blackman Window');
xlabel('Frequency’');
ylabel('Magnitude');
figure;
plot(linspace(-1, 1, length(spectrum_blackman)),20*log10(abs(spectrum_blackman)/max(abs(spectrum_blackman))));
xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Magnitude Response of Blackman Window');

fvtool(blackman_window)
function X = fft_radix2(x) %function to calculate DFT
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
