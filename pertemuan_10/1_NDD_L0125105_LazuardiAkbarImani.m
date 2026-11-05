% L0125105_Lazuardi Akbar Imani
xy = [15 32.5; 25 44; 35 51.5];

disp('L0125105_LazuardiAkbarImani');
disp('Metode Newton Divided-Difference Order 2');

f = NDD_L0125105_LazuardiAkbarImani(xy)

fprintf('Nilai f(22) = %f\n\n', f(22));