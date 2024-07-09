clc;
clear all;
close all;

N = 55;%  N values are taken as 15 or 55
bartlett_window = zeros(1, N); %Bartlett window
for n = 1:N
if n <= (N - 1) / 2
bartlett_window(n) = 2 * n / (N - 1);
else
bartlett_window(n) = 2 - (2 * n / (N - 1));
end
end
bartlett_window = bartlett_window / max(bartlett_window);

subplot(2,1,1)
stem(0:N-1,bartlett_window);
title('Bartlett Window for N = 55');
xlabel('n');
ylabel('Amplitude');
spectrum_bartlett_window = abs(fft_radix2([bartlett_window,zeros(1,256-length(bartlett_window))]));		%zero padding
frequencies = linspace(0, 1, length(spectrum_bartlett_window));
spectrum_bartlett = [spectrum_bartlett_window(length(spectrum_bartlett_window)/2:length(spectrum_bartlett_window)),spectrum_bartlett_window(1:length(spectrum_bartlett_window)/2)];
subplot(2,1,2)
plot(-length(frequencies)/2:length(frequencies)/2, spectrum_bartlett);
title('Magnitude Spectrum of Bartlett Window');
xlabel('Frequency');
ylabel('Magnitude');

figure;
plot(linspace(-1, 1, length(spectrum_bartlett)),20*log10(abs(spectrum_bartlett)/max(abs(spectrum_bartlett))));
xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Magnitude Response of Bartlett Window');
fvtool(bartlett_window)

function X = fft_radix2(x) %function to plot DFT
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
