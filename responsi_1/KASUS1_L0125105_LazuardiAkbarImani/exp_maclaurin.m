# L0125105_Lazuardi Akbar Imani
function hasil = exp_maclaurin(x, n)
    hasil = zeros(size(x));
    for i = 0:(n-1)
        hasil = hasil + (x.^i) / factorial(i);
    end
end