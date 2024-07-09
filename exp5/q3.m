passband_edge_freq = 1500;
stopband_edge_freq = 1000;
min_stopband_attenuation = 50;
max_passband_attenuation = 0.9;
sampling_frequency = 8000;

N = ceil(8*pi*8000/(2*pi*(passband_edge_freq - stopband_edge_freq)));
fc = 1250;
ts = 1/8000;

window = hamming(N + 1);
n1 = (-1*N)/2 : 1 : N/2;
h_ideal = 2*fc*ts*sinc(2*fc*ts*(n1));
h_ideal((N/2)+1) = (2*pi*fc*ts/pi);

h_windowed = h_ideal .* window';

n = 0:N;
figure;

subplot(2, 3, 1);
plot(n, h_ideal);
title('Ideal Impulse Response');
xlabel('n');
ylabel('Amplitude');

subplot(2, 3, 2);
plot(n, window);
title('Hamming Window Function');
xlabel('n');
ylabel('Amplitude');

subplot(2, 3, 3);
stem(n, h_windowed);
title('Designed Filter Impulse Response');
xlabel('n');
ylabel('Amplitude');

% Frequency response
[H, w] = freqz(h_windowed, 1, 'half', 1024, sampling_frequency);
magnitude_response = 20 * log10(abs(H));
phase_response = unwrap(angle(H));

subplot(2, 3, [4, 5]);
plot(w, magnitude_response);
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(2, 3, 6);
plot(w, phase_response);
title('Phase Spectrum');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

passband_edge_idx = round(passband_edge_freq * length(w) / sampling_frequency);
stopband_edge_idx = round(stopband_edge_freq * length(w) / sampling_frequency);

passband_attenuation_actual = max(magnitude_response(1:passband_edge_idx));
stopband_attenuation_actual = min(magnitude_response(stopband_edge_idx:end));

fprintf('Actual Passband Attenuation: %.2f dB\n', passband_attenuation_actual);
fprintf('Actual Stopband Attenuation: %.2f dB\n', stopband_attenuation_actual);





clc, clearvars, close all;

% Parameters
Fs = 8000; % Sampling frequency
Fp = 1000; % Pass band edge frequency
Fs_stop = 1500; % Stop band edge frequency
Asp = 0.9; % Maximum pass band attenuation
Ast = 50; % Minimum stop band attenuation

% Window function
N = 200; % Filter order
w = linspace(0, pi, N+2); % Window function frequency
w = w(1:end-1); % Exclude DC component

% Window function coefficients
beta = 0.1102*(Asp + Ast) - 0.5842*sqrt((Asp + Ast)^2 - 1) + 0.7071;
window = 0.54 - 0.46*cos(w); % Blackman-Harris window

% FIR filter coefficients
h = zeros(1, N+1); % Filter coefficients

% Pass band
for n = 1:N+1
    if (n-1)*Fs/N <= Fp/pi && (n-1)*Fs/N >= -Fp/pi
        h(n) = 2*Asp*Fp/Fs * sinc(2*Fp*(n-1)/Fs);
    end
end

% Stop band
for n = 1:N+1
    if (n-1)*Fs/N <= Fs_stop/pi && (n-1)*Fs/N >= -Fs_stop/pi
        h(n) = h(n) - 2*Ast*Fs_stop/Fs * sinc(2*Fs_stop*(n-1)/Fs);
    end
end

% Windowing
h = h.*window(1:length(h)); % Adjust window size to match h

% Normalize filter coefficients
h = h/sum(h);

% Plot window function
figure;
subplot(3, 1, 1);
plot(w, window(1:length(h))); % Adjust window size to match h
title('Window Function');
xlabel('Frequency (rad/sample)');
ylabel('Amplitude');

% Plot ideal impulse response
subplot(3, 1, 2);
stem(0:N, h);
title('Ideal Impulse Response');
xlabel('Sample');
ylabel('Amplitude');

% Plot impulse response
subplot(3, 1, 3);
impz(h, 1024, Fs);
title('Impulse Response');
xlabel('Sample');
ylabel('Amplitude');

% Plot magnitude and phase spectrum
figure;
subplot(2, 1, 1);
freqz(h, 1, 1024, Fs);
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(2, 1, 2);
freqz(h, 1, 1024, Fs);
title('Phase Spectrum');
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
