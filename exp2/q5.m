t=0:0.00001:3;
x_t=5*sin(2*pi*t);
subplot(3,1,1);
plot(t,x_t);
hold on;
fs=20;
ts=0:1/fs:3;
x_s=5*sin(2*pi*ts);
stem(ts,x_s);
hold off;
xlabel('t');
ylabel('Amplitude');
title('Ideal Sampling');
legend('Input signal','Sampled signal');

subplot(3,1,2);
x_square=0.5*(1+sign(5*sin(20*pi*t)));
plot(t,x_t);
hold on;
plot(t,x_square);
hold off;
xlabel('t');
ylabel('Amplitude');
title('Pulse Train');
legend('Input signal','Pulse Train');

subplot(3,1,3);
plot(t,x_t);
hold on;
x_ns=x_t.*x_square;
plot(t,x_ns);
hold off;
xlabel('t');
ylabel('Amplitude');
title('Natural Sampling');
legend('Input signal','Sampled signal');

