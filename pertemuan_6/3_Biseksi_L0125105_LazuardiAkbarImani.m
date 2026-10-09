% L0125105_Lazuardi Akbar Imani
f = @(x) log10(x + 3) + 1.5*x - 2.5;
a = 1;
b = 2;
n = 20;
tol = 0.0001;
fprintf("L0125105_Lazuardi Akbar Imani\n")
c = Biseksi_L0125105_LazuardiAkbarImani(f, a, b, n, tol)