% L0125105_Lazuardi Akbar Imani

function c = Secant_L0125105_LazuardiAkbarImani(f, a, b, maxIter, tolError)
  tic
  fprintf('Iter\ta\t\tb\t\tfa\t\tfb\t\tc\t\tfc\n');
  for i = 1:maxIter
    fa = f(a);
    fb = f(b);
    if fb == fa
      error("Pembagian dengan 0.")
    endif
    c = b - (fb * (b - a)) / (fb - fa);
    fc = f(c);
    fprintf ('%d\t%f\t%f\t%f\t%f\t%f\t%f\n', i, a, b, fa, fb, c, fc);
    if abs(c - b) <= tolError || fc == 0
      toc
      return;
    else
      a = b;
      b = c;
    endif
  endfor
  toc
end