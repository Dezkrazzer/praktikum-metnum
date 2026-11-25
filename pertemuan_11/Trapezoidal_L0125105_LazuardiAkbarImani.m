% L0125105_Lazuardi Akbar Imani
function I = Trapezoidal_L0125105_LazuardiAkbarImani(f, a, b, n)
    if n < 1
        printf('Peringatan: n harus lebih dari 1 untuk metode Trapezoidal.\n');
        I = NaN;
        return;
    end
    h = (b - a) / n;
    x = a:h:b;
    y = f(x);
    I = h * (0.5 * y(1) + sum(y(2:end-1)) + 0.5 * y(end));
end