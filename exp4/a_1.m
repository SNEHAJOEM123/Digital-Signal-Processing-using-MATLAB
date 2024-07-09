% Example usage
N = 8;
x = randn(1, N) + 1i * randn(1, N); % Random complex input sequence
% FFT
X_fft = fft_radix2(x);
% IDFT
x_idft = ifft_radix2(X_fft);
% Print results
disp('Original sequence x:');
disp(x);
disp('FFT result X:');
disp(X_fft);
disp('IDFT result x_idft:');
disp(x_idft);

subplot(3,2,1);
stem(real(x));
title('Real part of Original sequence');
xlabel('n');
ylabel('Magnitude');
subplot(3,2,2);
stem(imag(x));
title('Imaginary part of Original sequence');
xlabel('n');
ylabel('Magnitude');

subplot(3,2,3);
stem(real(X_fft));
title('Real part of FFT result');
xlabel('n');
ylabel('Magnitude');
subplot(3,2,4);
stem(imag(X_fft));
title('Imaginary part of FFT result');
xlabel('n');
ylabel('Magnitude');

subplot(3,2,5);
stem(real(x_idft));
title('Real part of IDFT result');
xlabel('n');
ylabel('Magnitude');
subplot(3,2,6);
stem(imag(x_idft));
title('Imaginary part of IDFT result');
xlabel('n');
ylabel('Magnitude');




function X = fft_radix2(x)
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

function x = ifft_radix2(X)
N = length(X);
if N <= 1
x = X;
else
even = ifft_radix2(X(1:2:end));
odd = ifft_radix2(X(2:2:end));
factor = exp(2i * pi / N);
x = [even + factor.^(0:N/2-1) .* odd, even - factor.^(0:N/2-1) .* odd] /2;
end
end