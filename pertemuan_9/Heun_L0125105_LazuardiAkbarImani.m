% L0125105_Lazuardi Akbar Imani
function y = Heun_L0125105_LazuardiAkbarImani(f, a, b, y0, N)
  h = (b - a) / N;
  fprintf('\nHasil Perhitungan Metode Heun\ni\txn\t\tk1\t\tk2\t\tyn\n');
  x = a;
  y = y0;
  k = [];
  fprintf('%d\t%f\t-\t\t-\t\t%f\n', 0, x, y);
  for i = 1:N
    k(1) = f(x(i), y(i));
    k(2) = f(x(i) + h, y(i) + k(1) * h);
    y(i+1) = y(i) + (h / 2) * (k(1) + k(2));
    x(i+1) = x(i) + h;
    fprintf('%d\t%f\t%f\t%f\t%f\n', i, x(i+1), k(1), k(2), y(i+1));
  endfor
  y = y(end);
end