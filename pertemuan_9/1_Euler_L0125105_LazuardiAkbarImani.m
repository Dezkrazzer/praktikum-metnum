% L0125105_Lazuardi Akbar Imani
clear; clc;
fprintf('\nL0125105_Lazuardi Akbar Imani\n\n')
Eksak_L0125105_LazuardiAkbarImani; % Memanggil skrip Eksak

f = @(x, y) (4*x.^3 - 6*x.^2 + 1) ./ (2 + y);
a = 0;
b = 1.5;
y0 = 1;
N = 15;

metodeEuler = Euler_L0125105_LazuardiAkbarImani(f, a, b, y0, N);
fprintf('\nMetode Euler = %f\n', metodeEuler);
fprintf('Galat Abstrak Metode Euler = %f\n', abs(eksak - metodeEuler));
fprintf('Galat Relatif Metode Euler = %f\n', abs((eksak - metodeEuler) / eksak));