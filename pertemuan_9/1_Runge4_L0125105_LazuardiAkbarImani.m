% L0125105_Lazuardi Akbar Imani
clear; clc;
fprintf('\nL0125105_Lazuardi Akbar Imani\n\n')
Eksak_L0125105_LazuardiAkbarImani;

f = @(x, y) (4*x.^3 - 6*x.^2 + 1) ./ (2 + y);
a = 0;
b = 1.5;
y0 = 1;
N = 15;

metodeRunge4 = Runge4_L0125105_LazuardiAkbarImani(f, a, b, y0, N);
fprintf('\nMetode Runge4 = %f\n', metodeRunge4);
fprintf('Galat Abstrak Metode Runge4 = %f\n', abs(eksak - metodeRunge4));
fprintf('Galat Relatif Metode Runge4 = %f\n', abs((eksak - metodeRunge4) / eksak));