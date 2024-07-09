%parallel form realization
clc
clear
close all
Nr =0.4*[1 0 -1];
Dr = [1 1.2 0.32];
figure
dim = [.09 .46 .5 .5];
[res,pole,k_gains] = residuez(Nr,Dr);

par_eqn = strcat('$ Parallel \: form \: realization \: H(z)= ',  makeEqn1(res, pole, k_gains), '$');
annotation('textbox',dim , 'String',par_eqn,'Interpreter', "latex" , 'FitBoxToText','on', 'FontSize',18');

function eqn=makeEqn1(ro, po, ~)
    eqn='';
    for i=1:length(ro)
        if i==length(ro)
        eqn = strcat(eqn, '\frac{ ', num2str(ro(i)), '}{1 - z^{-1}(', num2str(po(i)), ')', '}');
        else
        eqn = strcat(eqn, '\frac{ ', num2str(ro(i)), '}{1 - z^{-1}(', num2str(po(i)), ')', '}', '+');
        end
    end
end
