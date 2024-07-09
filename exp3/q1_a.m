clc;
close all;
N=8;
dft=zeros(N,N);
W=exp(-2i*pi/N);
for n=0:N-1
    for k=0:N-1
        dft(n+1,k+1)=W^(n*k);
    end
end
idft=conj(dft)/N;
unit_matrix=dft*idft;
disp('DFT=');
disp(dft);
disp('IDFT=');
disp(idft);
disp('Unit matrix=')
disp(unit_matrix);


