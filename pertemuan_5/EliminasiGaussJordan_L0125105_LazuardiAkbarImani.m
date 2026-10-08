% L0125105_Lazuardi Akbar Imani
function x = EliminasiGaussJordan_L0125105_LazuardiAkbarImani(A,b)
tic
[n,l] = size(A);                      % Mengambil jumlah baris pada matriks A.
for i = 1 : n-1,
    [pivot,k] = max(abs(A(i:n, i)));  % Mengambil nilai tertinggi pada baris tertentu.
    % Menukar baris jika nilai tertinggi tidak berada dalam posisi diagonal.
    if (k ~= 1)
        temp1 = A(i, :);
        temp2 = b(i, :);
        A(i,:) = A(i+k-1,:);
        b(i,:) = b(i+k-1,:);
        A(i+k-1,:) = temp1;
        b(i+k-1,:) = temp2;
    end
    % Melakukan forward elimination.
    for (h = i+1 : n),
        m = A(h,i)/A(i,i);
        A(h,:) = A(h,:) - m*A(i,:);
        b(h,:) = b(h,:) - m*b(i,:);
    end
end
% Menampilkan hasil forward elimination.
fprintf('Hasil forward elimination:\n')
A
% Menghitung backwards elimination.
for i = n:-1:2
    for h = i-1:-1:1
        m = A(h,i)/A(i,i);
        A(h,:) = A(h,:)-m*A(i,:);
        b(h,:) = b(h,:)-m*b(i,:);
    end
end
% Menampilkan hasil backwards elimination.
fprintf('Hasil backwards elimination:\n')
A
% Menghitung hasil penyelesaian.
for i = 1:n
    x(i,:) = b(i,:)/A(i,i);
end
toc