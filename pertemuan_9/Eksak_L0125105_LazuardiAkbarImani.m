% L0125105_Lazuardi Akbar Imani
fasli = @(x) -2 + sqrt(4 - 2 * (-x.^4 + 2*x.^3 - x - 2.5));
eksak = fasli(1.5);

fprintf('Nilai Eksak = %f', eksak);