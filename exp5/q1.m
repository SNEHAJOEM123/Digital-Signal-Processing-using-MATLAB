clc;
clear all;
close all;

Fs = 1000;
N = 101;
lfc = 100;%The parameters given
hfc = 200;
fc1 = 100;
fc2 = 300;

lowpass_h = zeros(1, N);% Impulse response of the low pass filter
for n = -(N-1)/2:(N-1)/2
if n == 0
lowpass_h(n+(N+1)/2) = 2 * lfc / Fs;
else
lowpass_h(n+(N+1)/2) = sin(2*pi*lfc*n/Fs) / (pi*n);
end
end

highpass_h = zeros(1, N);%Impulse response of the high pass filter
for n = -(N-1)/2:(N-1)/2
if n == 0
highpass_h(n+(N+1)/2) = 1 - 2 * hfc / Fs;
else
highpass_h(n+(N+1)/2) = -sin(2*pi*hfc*n/Fs) / (pi*n);
end
end

bandpass_h= zeros(1, N); %Impulse response of the band pass filter
for n = -(N-1)/2:(N-1)/2
if n == 0
bandpass_h(n+(N+1)/2) = 2 * (fc2 - fc1) / Fs;
else
bandpass_h(n+(N+1)/2) = (sin(2*pi*fc2*n/Fs) - sin(2*pi*fc1*n/Fs)) / (pi*n);
end
end

bandreject_h = zeros(1, N);%Impulse response of the band reject filter
for n = -(N-1)/2:(N-1)/2
if n == 0
bandreject_h(n+(N+1)/2) = 1 - 2 * (fc2 - fc1) / Fs;
else
bandreject_h(n+(N+1)/2) = (sin(2*pi*fc1*n/Fs) - sin(2*pi*fc2*n/Fs)) / (pi*n);
end
end

lowpass_H = zeros(1, N); %DFT of the Low pass filter
for k = 0:N-1
for n = 0:N-1
lowpass_H(k+1) = lowpass_H(k+1) + lowpass_h(n+1) * exp(-1i*2*pi*k*n/N);
end
end

highpass_H = zeros(1, N);%DFT of the High pass filter
for k = 0:N-1
for n = 0:N-1
highpass_H(k+1) = highpass_H(k+1) + highpass_h(n+1) * exp(-1i*2*pi*k*n/N);
end
end

bandpass_H = zeros(1, N);%DFT of Band pass filter
for k = 0:N-1
for n = 0:N-1
bandpass_H(k+1) = bandpass_H(k+1) + bandpass_h(n+1) * exp(-1i*2*pi*k*n/N);
end
end

bandreject_H = zeros(1, N);%DFT of Band reject filter
for k = 0:N-1
for n = 0:N-1
bandreject_H(k+1) = bandreject_H(k+1) + bandreject_h(n+1) * exp(-1i*2*pi*k*n/N);
end
end

n = -(N-1)/2:(N-1)/2;
figure; %Plots
subplot(2,1,1);
stem(n, lowpass_h);
title('Impulse Response of Ideal Low Pass Filter ');
xlabel('n');
ylabel('Amplitude');
subplot(2,1,2);
stem(abs(lowpass_H));
title('DFT of Ideal Low Pass Filter');
xlabel('Frequency');
ylabel('Magnitude');

figure
subplot(2,1,1);
stem(n, highpass_h);
title(' Impulse Response of Ideal High Pass Filter');
xlabel('n');
ylabel('Amplitude');
subplot(2,1,2);
stem(abs(highpass_H));
title('DFT of Ideal High Pass Filter');
xlabel('Frequency');
ylabel('Magnitude');

figure
subplot(2,1,1);
stem(n, bandpass_h);
title('Impulse Response of Ideal Band Pass Filter ');
xlabel('n');
ylabel('Amplitude');
subplot(2,1,2);
stem(abs(bandpass_H));
title('DFT of Ideal Band Pass Filter');
xlabel('Frequency');
ylabel('Magnitude');

figure
subplot(2,1,1);
stem(n, bandreject_h);
title('Impulse Response of Ideal Band Reject Filter');
xlabel('n');
ylabel('Amplitude');
subplot(2,1,2);
stem(abs(bandreject_H));
title('DFT of Ideal Band Reject Filter');
xlabel('Frequency');
ylabel('Magnitude');
