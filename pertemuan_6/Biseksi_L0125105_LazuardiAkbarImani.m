% L0125105_Lazuardi Akbar Imani
function c = Biseksi_L0125105_LazuardiAkbarImani(f, a, b, maxIter, tolError)
  tic;
  fa = f(a);
  fb = f(b);
  if fa * fb > 0
    error('Warning: f(a) dan f(b) sama tanda.')
  endif
  fprintf('Iter\ta\t\tb\t\tfa\t\tfb\t\tc\t\tfc\n');
  for i = 1:maxIter
    c = (a + b) / 2;
    fc = f(c);
    fprintf ('%d\t%f\t%f\t%f\t%f\t%f\t%f\n', i, a, b, fa, fb, c, fc);
    if abs(c - a) <= tolError || abs(c - b) <= tolError
      break;
    endif
    if fa * fc == 0
      break;
    elseif fa * fc < 0
      b = c;
      fb = f(b);
    else
      a = c;
      fa = f(a);
    endif
  endfor
  toc;
end