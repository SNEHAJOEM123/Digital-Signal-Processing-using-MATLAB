% Define the prototype lowpass filter transfer function
s = tf('s');
H_p = 1 / (s + 1);

% Define cutoff frequencies and bandwidth for the filters
cutoff_lowpass = 40;
cutoff_highpass = 40;
center_bandpass = 100;
bandwidth_bandpass = 20;
center_bandreject = 100;
bandwidth_bandreject = 20;

% Define frequency range for plotting
w = linspace(0, 200, 1000);

% Calculate transfer functions for each filter
[~, H_lowpass] = freqresp(H_p, w);
H_highpass = 1 - H_lowpass;

% Bandpass filter
H_bandpass = freqresp(tf([0, bandwidth_bandpass], [1, center_bandpass, bandwidth_bandpass]), w);

% Bandreject filter
H_bandreject = freqresp(tf([1, 0, 1], [1, center_bandreject, bandwidth_bandreject]), w);

% Plot magnitude responses
figure;
subplot(2, 2, 1);
plot(w, abs(squeeze(H_lowpass)));
xlabel('Frequency (radians/second)');
ylabel('Magnitude');
title('Lowpass Filter');
xlim([0, 200]);

subplot(2, 2, 2);
plot(w, abs(squeeze(H_highpass)));
xlabel('Frequency (radians/second)');
ylabel('Magnitude');
title('Highpass Filter');
xlim([0, 200]);

subplot(2, 2, 3);
plot(w, abs(squeeze(H_bandpass)));
xlabel('Frequency (radians/second)');
ylabel('Magnitude');
title('Bandpass Filter');
xlim([0, 200]);

subplot(2, 2, 4);
plot(w, abs(squeeze(H_bandreject)));
xlabel('Frequency (radians/second)');
ylabel('Magnitude');
title('Bandreject Filter');
xlim([0, 200]);
