% Transfer function coefficients
numerator_coefficients = [2, 5, 9, 5, 3];
denominator_coefficients = [5, 45, 2, 1, 1];

% Display factored form of the transfer function
numerator_roots = roots(numerator_coefficients);
denominator_roots = roots(denominator_coefficients);
disp('Factored form of the transfer function:');
disp(['Numerator: ', format_poly(numerator_roots, 'z')]);
disp(['Denominator: ', format_poly(denominator_roots, 'z')]);

% Generate pole-zero plot
figure;
zplane(numerator_coefficients, denominator_coefficients);
title('Pole-Zero Plot');
xlabel('Real');
ylabel('Imaginary');
% Display poles and zeros
poles = roots(denominator_coefficients);
zeros = roots(numerator_coefficients);
disp('Poles:');
disp(poles);
disp('Zeros:');
disp(zeros);

function poly_str = format_poly(roots, variable)
n = length(roots);
poly_str = '';
for i = 1:n
if i > 1
poly_str = [poly_str, ' * '];
end
if isreal(roots(i))
poly_str = [poly_str, '(' variable ' - ' num2str(roots(i)) ')'];
else
poly_str = [poly_str, '(' variable ' - (' num2str(real(roots(i))) '+' num2str(abs(imag(roots(i)))) 'i))'];
end
end
end