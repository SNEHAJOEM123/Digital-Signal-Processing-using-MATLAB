% Define the numerator and denominator coefficients of the transfer function
numerator = [0.35 0.35];
denominator = [1 -0.3];

% Frequency response analysis
[h, w] = freqz(numerator, denominator);

% Plot the magnitude response
subplot(2,1,1);
plot(w/pi, 20*log10(abs(h)));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('Magnitude Response');

% Plot the phase response
subplot(2,1,2);
plot(w/pi, angle(h)*180/pi);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (degrees)');
title('Phase Response');