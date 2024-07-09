clc, clearvars, close all
syms z
Nr1 = [6 1 -1] ;
Dr1 = [1 0 0];

poles1 = roots(Dr1);
zeros_of_H1 = roots(Nr1);

zplane(zeros_of_H1, poles1)
title('pole zero plot of H_1(z)');
xlabel('Real');
ylabel('Imaginary');

Nr2 = [1 -1 -6] ;
Dr2 = [1 0 0];

poles2 = roots(Dr2);
zeros_of_H2 = roots(Nr2);

zplane(zeros_of_H2, poles2)
title('pole zero plot of H_2(z)');
xlabel('Real');
ylabel('Imaginary');

