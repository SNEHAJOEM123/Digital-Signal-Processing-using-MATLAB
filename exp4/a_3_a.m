clc,clearvars,close all
[acoustic,fs1]=audioread("acoustic.wav");
[cathedral,fs2]= audioread("impulse_cathedral.wav");
newac= acoustic.';
newcat= cathedral.';
tic
output= myconv(newac,newcat);
conv_time= toc;
disp("Time required for convolution is:");
disp(conv_time);
plot(output);
function y= myconv(newac,newcat)
m= length(newac);
n= length(newcat);
X= [newac, zeros(1,n-1)];
H= [newcat, zeros(1,m-1)];
for i = 1:n+m-1
y(i)= 0 ;
for j = 1:i
y(i) = y(i) + X(j)*H(i-j+1);
end
end
end