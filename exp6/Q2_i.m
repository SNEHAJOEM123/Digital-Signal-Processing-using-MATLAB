num = [0.1, -0.1];
den = [1, -0.3];

w = linspace(0, pi, 1000);
freq = freqz(num, den, w);
mag = abs(freq);
phase = angle(freq);

figure;
subplot(2, 1, 1);
plot(w/pi, mag);
title('Magnitude Response (H1)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');

subplot(2, 1, 2);
plot(w/pi, phase);
title('Phase Response (H1)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');



