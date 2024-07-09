[y,Fs] = audioread('acoustic-guitar-loop-f-91bpm-132687.wav');
subplot(3,1,1);
plot(y);
disp(Fs);
xlabel('t');
ylabel('Amplitude');
title('Original signal');

%Upsampling
load handel.mat
filename = 'handel.wav';
audiowrite(filename,y,80000);
[z,fs] = audioread(filename);
subplot(3,1,2);
plot(z);
disp(fs);
xlabel('t');
ylabel('Amplitude');
title('Upsampled signal');


%Downsampling
filename1 = 'handel1.wav';
audiowrite(filename1,w,1000);
[w,fs1] = audioread(filename1);
subplot(3,1,3);
plot(w);
disp(fs1);
xlabel('t');
ylabel('Amplitude');
title('Downsampled signal');

