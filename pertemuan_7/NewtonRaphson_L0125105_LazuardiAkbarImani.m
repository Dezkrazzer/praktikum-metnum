% L0125105_Lazuardi Akbar Imani

function b = NewtonRaphson_L0125105_LazuardiAkbarImani(f, a, maxIter, tolError)
  tic
  syms x;
  f_diff = matlabFunction(diff(sym(f), 'x'));
  fprintf('Iter\ta\t\tf(a)\t\tf_diff(a)\tb\t\tfb\n');
  for i = 1:maxIter
    fa = f(a);
    fdiffa = f_diff(a);
    if fdiffa == 0
      error("Pembagian dengan 0.")
    endif
    b = a - fa / fdiffa;
    fb = f(b);
    fprintf ('%d\t%f\t%f\t%f\t%f\t%f\n', i, a, fa, fdiffa, b, fb);
    if abs(b - a) <= tolError || fb == 0
      toc
      return;
    else
      a = b;
    endif
  endfor
  toc
endfunction