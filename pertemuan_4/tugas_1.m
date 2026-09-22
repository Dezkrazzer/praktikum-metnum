% L0125105_Lazuardi Akbar Imani
% Tugas 1 - Iterasi Newton Raphson

disp('L0125105_Lazuardi Akbar Imani');
x_prev = 1;
toleransi = 0.000001;
error_val = 1
iterasi = 0;

fprintf('\nIterasi\t x_n\t\t Error\n');
fprintf('----------------------------------------\n');
fprintf('%d\t %f\t -\n', iterasi, x_prev);

while error_val > toleransi
    iterasi = iterasi + 1;
    % Rumus x_n = (1/3) * (2 * x_{n-1} + 3 / x_{n-1}^2)
    x_n = (1/3) * (2 * x_prev + 3 / (x_prev^2));
    
    error_val = abs(x_n - x_prev);
    
    fprintf('%d\t %f\t %f\n', iterasi, x_n, error_val);
    x_prev = x_n;
end

fprintf('----------------------------------------\n');
fprintf('Akar pangkat 3 dari 3 adalah sekitar: %f\n\n', x_prev);