% L0125105_Lazuardi Akbar Imani
function x = LU_Solusi_L0125105_LazuardiAkbarImani (A,b)
tic;
% Menampilkan hasil dekomposisi LU.
fprintf('Hasil dekomposisi LU\n')
[L,U,b] = LU_Dekomposisi_L0125105_LazuardiAkbarImani(A,b)         % Memanggil fungsi LU_fwdelim.
[n,~] = size(L);                  % Mengambil jumlah baris dan kolom matriks L.
% Mendeklarasikan matriks z dengan zeros.
z = zeros(n,1);
% Mendeklarasikan matriks x dengan zeros.
x = zeros(n,1);
% Mendefinisikan nilai z(1).
z(1) = b(1)/L(1,1);
% Menghitung nilai matriks z.
for i = 2:n
    z(i) = (b(i) - L(i, 1:i-1)*z(1:i-1)) / L(i,i);
end
% Menghitung nilai matriks x dengan iterasi mundur.
x(n) = z(n)/U(n,n);
for i = n-1:-1:1
    x(i) = (z(i) - U(i,i+1:n)*x(i+1:n)) / U(i,i);
end
toc;