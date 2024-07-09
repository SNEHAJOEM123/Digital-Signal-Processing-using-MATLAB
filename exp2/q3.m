%Analog Signal
subplot(3,1,1);
t=0:0.00001:0.1;
x_t=5*cos(2*pi*100*t);
plot(t,x_t);
xlabel('t');
ylabel('Magnitude');
title('Original signal');

%Undersampling
f_s=1.3*100;
t_s=0:1/f_s:0.1;
x_s=5*cos(2*pi*100*t_s);
subplot(3,1,2);
stem(t_s,x_s);
xlabel('t');
ylabel('Magnitude');
title('Undersampled signal');

%Oversampling
f_s=2.2*100;
t_s=0:1/f_s:0.1;
x_s=5*cos(2*pi*100*t_s);
subplot(3,1,3);
stem(t_s,x_s);
xlabel('t');
ylabel('Magnitude');
title('Oversampled signal');

