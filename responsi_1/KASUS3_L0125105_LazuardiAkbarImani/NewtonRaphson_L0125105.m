# L0125105_Lazuardi Akbar Imani

function b = NewtonRaphson_L0125105(f, f_diff, a, maxIter, tolError)
  fprintf('Iter\tt_i\t\tf(t_i)\t\tf''(t_i)\t\tt_{i+1}\t\tError\n');
  for i=1:maxIter
    fa = f(a);
    fdiffa = f_diff(a);
    b = a - fa/fdiffa;
    error_val = abs(b - a);
    fprintf ('%d\t%f\t%f\t%f\t%f\t%f\n', i, a, fa, fdiffa, b, error_val);
    
    if error_val <= tolError
      return;
    else
      a = b;
    endif
  endfor
end