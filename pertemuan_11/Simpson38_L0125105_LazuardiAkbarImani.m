% L0125105_Lazuardi Akbar Imani
function I = Simpson38_L0125105_LazuardiAkbarImani(f, a, b, n)
    if mod(n, 3) ~= 0
        printf('Peringatan: n harus habis dibagi 3 untuk metode Simpson 3/8.\n');
        I = NaN;
        return;
    end
    h = (b - a) / n;
    x = a:h:b;
    y = f(x);
    I = (3 * h / 8) * (y(1) + 3 * sum(y(2:3:end-2) + y(3:3:end-1)) + 2 * sum(y(4:3:end-3)) + y(end));
end