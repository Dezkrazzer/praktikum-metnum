% L0125105_Lazuardi Akbar Imani
% Tugas 2 - Deret Taylor untuk ln(1.5)

disp('L0125105_Lazuardi Akbar Imani');
x = 0.5;
n_values = [5, 6, 7, 8, 9, 10];
true_val_ln = log(1.5);

fprintf('Nilai asli ln(1.5) = %5.15f\n\n', true_val_ln);
fprintf('n\t Aproksimasi\t\t Error\n');
fprintf('--------------------------------------------------\n');

for n = n_values
    aproksimasi_ln = 0;
    for i = 1:n
    % Rumus: (-1)^(i-1) * (x^i) / i
        suku = ((-1)^(i-1)) * (x^i) / i;
        aproksimasi_ln = aproksimasi_ln + suku;
    end
    error_ln = abs(true_val_ln - aproksimasi_ln);
    fprintf('%d\t %5.15f\t %5.15f\n', n, aproksimasi_ln, error_ln);
end
fprintf('--------------------------------------------------\n');
fprintf('\n');