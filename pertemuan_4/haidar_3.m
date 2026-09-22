% Tugas 3: Perhitungan atan(0.5) dalam radian dengan Deret Taylor
x = 0.5;
eksak = atan(x);
N_list = [1, 2, 3, 4, 5];

fprintf('Nilai Eksak atan(0.5) = %5.15f rad\n\n', eksak);
fprintf('N\t Pendekatan\t\t Galat Mutlak\n');
fprintf('-----------------------------------------------------\n');

for k = 1:length(N_list)
    N = N_list(k);
    p = 0;
    
    % Rumus: sum_{n=0}^N (-1)^n * (x^(2n+1) / (2n+1))
    for n = 0:N
        p = p + ((-1)^n) * ((x^(2*n + 1)) / (2*n + 1));
    end
    
    galat = abs(eksak - p);
    fprintf('%d\t %5.15f\t %5.15f\n', N, p, galat);
end