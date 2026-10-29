% L0125105_Lazuardi Akbar Imani
clear; clc;
fprintf('\nL0125105_Lazuardi Akbar Imani\n\n')
Eksak_L0125105_LazuardiAkbarImani;

f = @(x, y) (4*x.^3 - 6*x.^2 + 1) ./ (2 + y);
a = 0;
b = 1.5;
y0 = 1;
N = 15;

metodeHeun = Heun_L0125105_LazuardiAkbarImani(f, a, b, y0, N);
fprintf('\nMetode Heun = %f\n', metodeHeun);
fprintf('Galat Abstrak Metode Heun = %f\n', abs(eksak - metodeHeun));
fprintf('Galat Relatif Metode Heun = %f\n', abs((eksak - metodeHeun) / eksak));