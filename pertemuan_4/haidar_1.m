% Tugas 1: Akar Pangkat 3 dari 3 (Newton-Raphson)
toleransi = 0.000001;
x_prev = 1; % x0 = 1
iter = 0;
selisih = 1;

fprintf('Iterasi\t x_n\t\t\t Error Antar-Iterasi\n');
fprintf('-----------------------------------------------------\n');
fprintf('%d\t %5.15f\t -\n', iter, x_prev);

while selisih >= toleransi
    iter = iter + 1;
    % Rumus: x_n = (1/3) * (2*x_(n-1) + 3 / x_(n-1)^2)
    x_curr = (1/3) * (2 * x_prev + (3 / (x_prev^2)));
    selisih = abs(x_curr - x_prev);
    
    fprintf('%d\t %5.15f\t %5.15f\n', iter, x_curr, selisih);
    x_prev = x_curr;
end

fprintf('\nHasil konvergen pada iterasi ke-%d: %5.15f\n', iter, x_prev);