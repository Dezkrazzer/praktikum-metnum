% L0125105_Lazuardi Akbar Imani
clear; clc;

% Data uji coba mobil listrik [t (s), v(t) (m/s)]
data_all = [ 0,  0.0;
            10,  7.6;
            25, 16.8;
            40, 23.4;
            55, 27.5;
            70, 29.2];

t_uji = 48;

fprintf('Kasus2_L0125105_Lazuardi Akbar Imani\n');
fprintf('KASUS 2 - BAGIAN 1\n');

% --- 1a. Polinomial Orde-3 ---
% 4 titik paling dekat dengan t = 48: t = 25, 40, 55, 70
data_orde3 = [25, 16.8;
              40, 23.4;
              55, 27.5;
              70, 29.2];

fprintf('--- 1a. Interpolasi Orde-3 v3(48) ---\n');
fprintf('4 titik terdekat yang digunakan: t = 25, 40, 55, 70\n');
[v3, tabel_v3] = NDD_L0125105_LazuardiAkbarImani(data_orde3, true);

fprintf('Fungsi polinomial orde-3 v3(t):\n');
disp(v3);

v3_48 = v3(t_uji);
fprintf('Kecepatan mobil pada t = 48 s, v3(48)  = %.6f m/s\n\n', v3_48);

% --- 1b. Estimasi Galat Relatif v3(48) ---
% 3 titik paling dekat dengan t = 48 untuk v2(t): t = 40, 55, 70
data_orde2 = [40, 23.4;
              55, 27.5;
              70, 29.2];

fprintf('--- 1b. Estimasi Galat Relatif v3(48) ---\n');
fprintf('3 titik terdekat untuk v2(t)   : t = 40, 55, 70\n');
[v2, tabel_v2] = NDD_L0125105_LazuardiAkbarImani(data_orde2, false);

v2_48 = v2(t_uji);
galat_relatif_v3 = abs((v3_48 - v2_48) / v3_48);

fprintf('Kecepatan orde-2, v2(48)               = %.6f m/s\n', v2_48);
fprintf('Kecepatan orde-3, v3(48)               = %.6f m/s\n', v3_48);
fprintf('Estimasi Galat Relatif |v3-v2|/|v3|    = %.6e (%.4f%%)\n\n', ...
        galat_relatif_v3, galat_relatif_v3 * 100);

fprintf('KASUS 2 - BAGIAN 2\n')

fprintf('Membentuk polinomial orde-5 v5(t) dari seluruh 6 titik data:\n');
[v5, tabel_v5] = NDD_L0125105_LazuardiAkbarImani(data_all, true);

fprintf('Fungsi polinomial orde-5 v5(t):\n');
disp(v5);

a = 0;
b = 60;
N = 60;

s_simpson13 = Simpson13_L0125105_LazuardiAkbarImani(v5, a, b, N);

s_referensi = integral(v5, a, b);
galat_simpson = abs(s_referensi - s_simpson13);

fprintf('--- Hasil Integrasi Simpson 1/3 (0 <= t <= 60) ---\n');
fprintf('Jumlah pias (N)                        = %d (h = %.2f detik)\n', N, (b - a) / N);
fprintf('Jarak tempuh (Simpson 1/3)             = %.6f meter\n', s_simpson13);
fprintf('Jarak tempuh (Verifikasi integral())   = %.6f meter\n', s_referensi);
fprintf('Selisih terhadap referensi             = %.6e meter\n', galat_simpson);