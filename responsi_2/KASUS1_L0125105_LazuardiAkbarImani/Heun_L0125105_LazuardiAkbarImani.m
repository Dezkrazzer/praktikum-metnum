% L0125105_Lazuardi Akbar Imani

function y_akhir = Heun_L0125105_LazuardiAkbarImani(f, a, b, y0, N)
  step = (b - a) / N;
  fprintf('\nHasil Perhitungan Metode Heun (N = %d, step = %f s)\n', N, step);
  fprintf('i\tt_i\t\tk1\t\tk2\t\th_i\n');
  fprintf('--------------------------------------------------------------------\n');

  t = zeros(1, N + 1);
  y = zeros(1, N + 1);
  t(1) = a;
  y(1) = y0;

  fprintf('%d\t%f\t-\t\t-\t\t%f\n', 0, t(1), y(1));

  for i = 1:N
    k1 = f(t(i), y(i));
    k2 = f(t(i) + step, y(i) + k1 * step);
    y(i+1) = y(i) + (step / 2) * (k1 + k2);
    t(i+1) = t(i) + step;
    fprintf('%d\t%f\t%f\t%f\t%f\n', i, t(i+1), k1, k2, y(i+1));
  end

  y_akhir = y(end);
end