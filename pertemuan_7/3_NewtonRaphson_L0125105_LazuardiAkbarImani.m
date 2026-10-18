% L0125105_Lazuardi Akbar Imani
warning('off', 'all');

f = @(x) log10(x + 3) + 1.5*x - 2.5;
a = 2;
maxIter = 20;
tolError = 0.0001;

disp("3_NewtonRaphson_L0125105_LazuardiAkbarImani\n")
b = NewtonRaphson_L0125105_LazuardiAkbarImani(f, a, maxIter, tolError)