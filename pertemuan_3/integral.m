% L0125105_Lazuardi Akbar Imani
% Integral
disp('L0125105_Lazuardi Akbar Imani');
f = input('Masukkan bentuk persamaan f(x) = ');
f_asli = sym(f);
f_integral = int(f_asli, 'x')