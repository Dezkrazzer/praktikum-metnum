# L0125105_Lazuardi Akbar Imani
function hasil = cos_maclaurin(x, n)
    hasil = zeros(size(x));
    for i = 0:(n-1)
        hasil = hasil + ((-1)^i) * (x.^(2*i)) / factorial(2*i);
    end
end