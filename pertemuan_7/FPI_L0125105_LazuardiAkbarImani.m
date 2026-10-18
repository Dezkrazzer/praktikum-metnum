% L0125105_Lazuardi Akbar Imani

function b = FPI_L0125105_LazuardiAkbarImani(g, a, maxIter, tolError)
  tic
  syms x;
  g_diff = matlabFunction(diff(sym(g), 'x'));
  c_score = abs(g_diff(a));
  
  if c_score < 0 || c_score > 1
    error("Fungsi tidak layak digunakan (tidak konvergen).")
  endif

  fprintf('Iter\ta\t\tb\t\tgb\n');
  for i = 1:maxIter
    b = g(a);
    gb = g(b);
    fprintf ('%d\t%f\t%f\t%f\n', i, a, b, gb);
    if abs(b - a) <= tolError || gb == 0
      toc
      return;
    else
      a = b;
    endif
  endfor
end