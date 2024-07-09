clc;
clear all;
close all;

N = 55; %  N values are taken as 15 or 55
n=0:(N-1);
hamming_window = 0.54 - 0.46 * cos(2 * pi * n / (N - 1)); % Hamming window

subplot(2,1,1)
plot(n,hamming_window);
title('Hamming Window for N = 55');
xlabel('n');
ylabel('Amplitude');

spectrum_hamming_window = abs(fft_radix2([hamming_window,zeros(1,256-length(hamming_window))])); %zero padding
frequencies = linspace(0, 1, length(spectrum_hamming_window));
spectrum_hamming = [spectrum_hamming_window(length(spectrum_hamming_window)/2:length(spectrum_hamming_window)),spectrum_hamming_window(1:length(spectrum_hamming_window)/2)];
subplot(2,1,2)
plot(-length(frequencies)/2:length(frequencies)/2, spectrum_hamming );
title('Magnitude Spectrum of Hamming Window');
xlabel('Frequency');
ylabel('Magnitude');
figure;
plot(linspace(-1, 1, length(spectrum_hamming)),20*log10(abs(spectrum_hamming)/max(abs(spectrum_hamming))));
xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Magnitude Response of Hamming Window');

fvtool(hamming_window)

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
