% L0125105_Lazuardi Akbar Imani

f = @(x) 2*x.^3 + x.^2 + 2*x - 4;
a = 0;
b = 1;
maxIter = 20;
tolError = 0.0001;

disp("1_Secant_L0125105_LazuardiAkbarImani\n")
c = Secant_L0125105_LazuardiAkbarImani(f, a, b, maxIter, tolError)