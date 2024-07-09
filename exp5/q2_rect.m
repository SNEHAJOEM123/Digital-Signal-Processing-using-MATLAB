clc;
clear all;
close all;
N = 55; 			%  N values are taken as 15 or 55
rectangular_window = ones(1, N); % Rectangular window
subplot(2,1,1)
stem(0:N-1, rectangular_window);
title('Rectangular Window for N = 55');
xlabel('n');
ylabel('Amplitude');

spectrum_rectangular_window = abs(fft_radix2([rectangular_window,zeros(1,256-length(rectangular_window))])); %zero padding 
frequencies = linspace(0, 1, length(spectrum_rectangular_window));
spectrum_rect = [spectrum_rectangular_window(length(spectrum_rectangular_window)/2:length(spectrum_rectangular_window)),spectrum_rectangular_window(1:length(spectrum_rectangular_window)/2)];
subplot(2,1,2) %plots
plot(-length(frequencies)/2:length(frequencies)/2, spectrum_rect);
title('Magnitude Spectrum of Rectangular Window ');
xlabel('Frequency');
ylabel('Magnitude');

figure;
plot(linspace(-1, 1, length(spectrum_rect)),20*log10(abs(spectrum_rect)/max(abs(spectrum_rect))));
xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Magnitude Response of the Rectangular window');
fvtool(rectangular_window)

function X = fft_radix2(x) %Function to calculate DFT
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
