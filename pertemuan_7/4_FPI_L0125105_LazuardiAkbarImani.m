% L0125105_Lazuardi Akbar Imani

% Variasi Fungsi 1: Akar langsung (x = sqrt(5 - sin(x)))
g1 = @(x) sqrt(5 - sin(x));
a = 2;
maxIter = 20;
tolError = 10^-5;

disp("Tugas 4 - Variasi FPI 1_L0125105_LazuardiAkbarImani")
b1 = FPI_L0125105_LazuardiAkbarImani(g1, a, maxIter, tolError)

disp("\n")
% Variasi Fungsi 2: Penambahan peredam konstanta pembagi 
% Bentuk asli: 3x = x + 2x = x + 2(sqrt(5-sin(x))) 
% g2(x) = (x + 2*sqrt(5 - sin(x))) / 3
g2 = @(x) (x + 2 * sqrt(5 - sin(x))) / 3;

disp("Tugas 4 - Variasi FPI 2_L0125105_LazuardiAkbarImani")
b2 = FPI_L0125105_LazuardiAkbarImani(g2, a, maxIter, tolError)