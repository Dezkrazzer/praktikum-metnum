% L0125105_Lazuardi Akbar Imani
function y = Runge4_L0125105_LazuardiAkbarImani(f, a, b, y0, N)
  h = (b - a) / N;
  fprintf('\nHasil Perhitungan Metode Runge-Kutta Orde 4\ni\txn\t\tk1\t\tk2\t\tk3\t\tk4\t\tyn\n');
  x = a;
  y = y0;
  k = [];
  fprintf('%d\t%f\t-\t\t-\t\t-\t\t-\t\t%f\n', 0, x, y);
  for i = 1:N
    k(1) = f(x(i), y(i));
    k(2) = f(x(i) + h / 2, y(i) + k(1) * (h / 2));
    k(3) = f(x(i) + h / 2, y(i) + k(2) * (h / 2));
    k(4) = f(x(i) + h, y(i) + k(3) * h);
    y(i+1) = y(i) + (h / 6) * (k(1) + 2*k(2) + 2*k(3) + k(4));
    x(i+1) = x(i) + h;
    fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\n', i, x(i+1), k(1), k(2), k(3), k(4), y(i+1));
  endfor
  y = y(end);
end