function I = Simpson13(f, a, b, n)

    if mod(n, 2) ~= 0
        printf('Peringatan: n harus genap untuk metode Simpson 1/3.\n');
        I = NaN;
        return;
    end

    h = (b - a) / n;
    x = a:h:b;
    y = f(x);

    % Rumus metode Simpson 1/3
    I = (h / 3) * (y(1) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)) + y(end));
end
