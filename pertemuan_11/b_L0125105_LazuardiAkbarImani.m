% L0125105_Lazuardi Akbar Imani
clear; clc;
f = @(x) x.^2 + exp(2*x);
a = 0;
b = 3;
N_list = [2, 3, 6];

fprintf('\nL0125105_Lazuardi Akbar Imani\n');
eksak = integral(f, a, b);
fprintf('Nilai Integral Eksak = %f\n\n', eksak);

for i = 1:length(N_list)
    n = N_list(i);
    fprintf('=== Evaluasi n = %d ===\n', n);
    
    % Trapezoidal
    I_trap = Trapezoidal_L0125105_LazuardiAkbarImani(f, a, b, n);
    fprintf('Hasil Trapezoidal   : %f (Error: %f)\n', I_trap, abs(eksak - I_trap));
    
    % Simpson 1/3
    if mod(n, 2) == 0
        I_simp13 = Simpson13_L0125105_LazuardiAkbarImani(f, a, b, n);
        fprintf('Hasil Simpson 1/3   : %f (Error: %f)\n', I_simp13, abs(eksak - I_simp13));
    else
        fprintf('Hasil Simpson 1/3   : [Diabaikan, n ganjil]\n');
    end
    
    % Simpson 3/8
    if mod(n, 3) == 0
        I_simp38 = Simpson38_L0125105_LazuardiAkbarImani(f, a, b, n);
        fprintf('Hasil Simpson 3/8   : %f (Error: %f)\n', I_simp38, abs(eksak - I_simp38));
    else
        fprintf('Hasil Simpson 3/8   : [Diabaikan, n bukan kelipatan 3]\n');
    end
    fprintf('\n');
end