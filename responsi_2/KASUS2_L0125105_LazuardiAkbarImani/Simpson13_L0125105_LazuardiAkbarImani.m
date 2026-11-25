% L0125105_Lazuardi Akbar Imani
function I = Simpson13_L0125105_LazuardiAkbarImani(f, a, b, n)
  if mod(n, 2) ~= 0 || n < 2
    fprintf('Peringatan: n harus bilangan genap (>= 2) untuk metode Simpson 1/3.\n');
    I = NaN;
    return;
  end
  h = (b - a) / n;
  x = a:h:b;
  y = f(x);
  I = (h / 3) * (y(1) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)) + y(end));
end