% L0125105_Lazuardi Akbar Imani
function x = IterasiJacobi_L0125105_LazuardiAkbarImani(A,b,tol,max_iter);
tic;
[n,m] = size(A);              % Mengambil jumlah baris dan kolom matriks A.
% Menghitung konstanta untuk melakukan iterasi.
for i = 1:n,
    xlama(i) = b(i)/A(i,i);
end
xlama = xlama';               % Melakukan transpose pada matriks xlama.
C = -A;
% Menyiapkan matriks sebelum melakukan iterasi.
for i = 1:n,
    C(i,i) = 0.0;             % Memberikan nilai 0 pada posisi diagonal.
    C(i,:) = C(i,:)/A(i,i);
    d(i,1) = xlama(i);
end
i = 1;
% Melakukan perhitungan secara iteratif.
while (i <= max_iter)
    xbaru = C*xlama + d;
    % Jika toleransi error terpenuhi, maka iterasi berhenti dan metode konvergen.
    if (abs(xbaru - xlama) <= tol)
        x = xbaru;
        disp ('Jacobi method konverge');
        toc;
        return;
    else
        xlama = xbaru;
    end
    i = i + 1;
end
% Jika toleransi error tidak terpenuhi, padahal iterasi maksimum telah tercapai,
% maka iterasi berhenti dan metode tidak konvergen.
disp ('Jacobi method not konverge');
x = xbaru;
toc;