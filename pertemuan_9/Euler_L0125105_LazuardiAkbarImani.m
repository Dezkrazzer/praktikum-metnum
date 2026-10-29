% L0125105_Lazuardi Akbar Imani
function y = Euler_L0125105_LazuardiAkbarImani(f, a, b, y0, N)
  h = (b - a) / N;
  fprintf('\nHasil Perhitungan Metode Euler\ni\txn\t\tyn\n');
  x = a;
  y = y0;
  fprintf('%d\t%f\t%f\n', 0, x, y);
  for i = 1:N
    y(i+1) = y(i) + h * f(x(i), y(i));
    x(i+1) = x(i) + h;
    fprintf('%d\t%f\t%f\n', i, x(i+1), y(i+1));
  endfor
  y = y(end);
end