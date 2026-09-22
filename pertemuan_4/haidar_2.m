% Tugas 2: Perhitungan ln(1.5) dengan Deret Taylor
x = 0.5; % ln(1 + 0.5) = ln(1.5)
eksak = log(1.5);
n_list = [5, 6, 7, 8, 9, 10];

fprintf('Nilai Eksak ln(1.5) = %5.15f\n\n', eksak);
fprintf('n\t Pendekatan\t\t Galat Mutlak\n');
fprintf('-----------------------------------------------------\n');

for k = 1:length(n_list)
    n = n_list(k);
    p = 0;
    
    % Rumus: sum_{i=1}^n (-1)^(i-1) * (x^i / i)
    for i = 1:n
        p = p + ((-1)^(i - 1)) * ((x^i) / i);
    end
    
    galat = abs(eksak - p);
    fprintf('%d\t %5.15f\t %5.15f\n', n, p, galat);
end