% L0125105_Lazuardi Akbar Imani

f = @(x) exp(x) + 2*x - 3;
a = 1;
maxIter = 20;
tolError = 0.0001;

disp("2_NewtonRaphson_L0125105_LazuardiAkbarImani\n")
b = NewtonRaphson_L0125105_LazuardiAkbarImani(f, a, maxIter, tolError)