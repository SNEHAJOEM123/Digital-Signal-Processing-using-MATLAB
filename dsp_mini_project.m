clc;
clear;
close all;
%LMS algorithm
% Load the ECG signal from the text file
file_path = "C:\Users\hp\Downloads\archive\Person_11.txt";
ecg_signal = load(file_path);
D= ecg_signal(:,2);
%Generating signal corrupted with noise
n=numel(D);
A=D(1:n)+0.5*rand(1,n);
M=25;
wi=zeros(1,M);
E=zeros(1,n);
mu=0.003;
Est=zeros(n,1);
for i=M:n
   E(i)=D(i)-wi*A(i:-1:i-M+1)';
   wi=wi+2*mu*E(i)*A(i:-1:i-M+1);
   j=A(i:-1:i-M+1);
   Est(i)=((wi)*(j)');
end
%Computing the error signal
Err=Est-D;
%Display of signals
subplot(4,1,1);
plot(D);
title('Desired signal');
subplot(4,1,2);
plot(A);
title('Signal corrupted with noise');
subplot(4,1,3);
plot(Est);
title('Estimation signal');
subplot(4,1,4);
plot(Err);
title('Error signal');