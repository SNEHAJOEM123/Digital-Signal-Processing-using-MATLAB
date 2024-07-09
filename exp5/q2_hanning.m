clc;
clear all;
close all;

N = 55;%  N values are taken as 15 or 55
n=0:(N-1);
hanning_window = 0.5 * (1 - cos(2 * pi * n / (N - 1))); %Hanning window

subplot(2,1,1)
plot(n,hanning_window);
title('Hanning Window for N = 55');
xlabel('n');
ylabel('Amplitude');
spectrum_hanning_window = abs(fft_radix2([hanning_window,zeros(1,256-length(hanning_window))])); %zero padding to make N power of 2
frequencies = linspace(0, 1, length(spectrum_hanning_window));
spectrum_hanning= [spectrum_hanning_window(length(spectrum_hanning_window)/2:length(spectrum_hanning_window)),spectrum_hanning_window(1:length(spectrum_hanning_window)/2)];
subplot(2,1,2)
plot(-length(frequencies)/2:length(frequencies)/2, spectrum_hanning);
title('Magnitude Spectrum of Hanning Window');
xlabel('Frequency');
ylabel('Magnitude');

figure;
plot(linspace(-1, 1, length(spectrum_hanning)),20*log10(abs(spectrum_hanning)/max(abs(spectrum_hanning))));
xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Magnitude Response of Hanning Window');

fvtool(hanning_window)

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
