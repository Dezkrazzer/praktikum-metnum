% L0125105_Lazuardi Akbar Imani

f = @(x) log10(x + 3) + 1.5*x - 2.5;
a = 1;
b = 2;
maxIter = 20;
tolError = 0.0001;

disp("3_Secant_L0125105_LazuardiAkbarImani\n")
c = Secant_L0125105_LazuardiAkbarImani(f, a, b, maxIter, tolError)