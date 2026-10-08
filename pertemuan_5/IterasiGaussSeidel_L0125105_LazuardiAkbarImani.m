% L0125105_Lazuardi Akbar Imani
function x = IterasiGaussSeidel_L0125105_LazuardiAkbarImani(A,b,tol,max_iter)
tic;
[n,m] = size(A);                  % Mengambil jumlah baris dan kolom matriks A.
% Menghitung nilai x awal terlebih dahulu.
for i = 1:n,
    if (i == 1)
        x(i) = b(i)/A(i,i);
    else
        x(i) = 0;
    end
end
x = x';                           % Melakukan transpose pada matriks x.
C = -A;
% Menyiapkan matriks sebelum melakukan iterasi.
for i = 1:n,
    C(i,i) = 0.0;                 % Memberikan nilai 0 pada posisi diagonal.
    C(i,:) = C(i,:)/A(i,i);
    d(i,1) = b(i)/A(i,i);
end
i = 1;
% Melakukan perhitungan secara iteratif.
while (i <= max_iter)
    xlama = x;
    % Melakukan perhitungan nilai x yang baru.
    for j = 1 : n,
        x(j) = C(j,:)*x + d(j);
    end
    % Jika toleransi error terpenuhi, maka iterasi berhenti dan metode konvergen.
    if (abs(xlama - x) <= tol)
        disp ('Gauss Seidel method konverge');
        toc;
        return
    end
%    disp([i x']);
    i = i + 1;
end
% Jika toleransi error tidak terpenuhi, padahal iterasi maksimum telah tercapai,
% maka iterasi berhenti dan metode tidak konvergen.
disp ('Gauss Seidel method not konverge');
toc;