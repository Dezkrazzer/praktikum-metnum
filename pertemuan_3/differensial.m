% L0125105_Lazuardi Akbar Imani
% Differensial
disp('L0125105_Lazuardi Akbar Imani');
f = input('Masukkan bentuk persamaan f(x) = ');
f_asli = sym(f);
f_turunan = diff(f_asli, 'x')