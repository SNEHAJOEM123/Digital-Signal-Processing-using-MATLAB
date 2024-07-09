[y,Fs] = audioread('acoustic-guitar-loop-f-91bpm-132687.wav');
subplot(3,1,1);
plot(y);
disp(Fs);

%Downsampling
load handel.mat
filename = 'handel.wav';
audiowrite(filename,z,200);
[z,fs] = audioread(filename);
subplot(3,1,3);
plot(z);
disp(fs);