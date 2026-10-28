# L0125105_Lazuardi Akbar Imani

% Matriks A (Bahan baku) yang sudah disusun Dominan Diagonal
A = [10, 1.5, 2, 0.5;
     0.5, 6, 1.5, 1;
     1, 0.75, 5, 1.25;
     0.25, 1, 0.5, 3];
 
% Matriks B (Total harga)
b = [229000; 195250; 221500; 169125];

fprintf('\nL0125105_Lazuardi Akbar Imani\n');

fprintf('=== ANALISIS KEKONVERGENAN SPL KASUS 2 ===\n');
% Cek Dominan Diagonal: |A(i,i)| >= sum(abs(A(i, j != i)))
is_dominan = true;
for i = 1:4
    sum_baris = sum(abs(A(i,:))) - abs(A(i,i));
    if abs(A(i,i)) <= sum_baris
        is_dominan = false;
    end
end

if is_dominan
    fprintf('Matriks A sudah DOMINAN DIAGONAL. SPL dapat diselesaikan dengan metode iteratif.\n\n');
else
    fprintf('Matriks A TIDAK Dominan Diagonal. Metode iteratif berisiko tidak konvergen.\n\n');
end

% Metode Iteratif
tol = 10^-4;
max_iter = 100; % Batas amannya iterasi

fprintf('--- Metode Jacobi ---\n');
x_jacobi = IterasiJacobi(A, b, tol, max_iter);
disp('Harga (Terigu, Gula, Telur, Mentega):'); disp(x_jacobi);

fprintf('\n--- Metode Gauss-Seidel ---\n');
x_seidel = IterasiGaussSeidel(A, b, tol, max_iter);
disp('Harga (Terigu, Gula, Telur, Mentega):'); disp(x_seidel);

% Verifikasi dengan Metode Langsung (LU)
fprintf('\n--- Verifikasi Metode Dekomposisi LU ---\n');
x_lu = LU_Solusi(A, b);
disp('Harga Verifikasi (LU):'); disp(x_lu);