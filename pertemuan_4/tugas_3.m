% L0125105_Lazuardi Akbar Imani
% Tugas 3 - Deret Taylor untuk tan^-1(x)

disp('L0125105_Lazuardi Akbar Imani');
x_tan = 0.5;
N_values = [1, 2, 3, 4, 5];
true_val_tan = atan(x_tan);

fprintf('Nilai asli tan^-1(0.5) = %5.15f\n\n', true_val_tan);
fprintf('N\t Aproksimasi\t\t Error\n');
fprintf('--------------------------------------------------\n');

for N = N_values
    aproksimasi_tan = 0;
    for k = 0:N
        % Rumus: (-1)^k * (x^(2k+1)) / (2k+1)
        suku_tan = ((-1)^k) * (x_tan^(2*k + 1)) / (2*k + 1);
        aproksimasi_tan = aproksimasi_tan + suku_tan;
    end
    error_tan = abs(true_val_tan - aproksimasi_tan);
    fprintf('%d\t %5.15f\t %5.15f\n', N, aproksimasi_tan, error_tan);
end
fprintf('--------------------------------------------------\n\n');