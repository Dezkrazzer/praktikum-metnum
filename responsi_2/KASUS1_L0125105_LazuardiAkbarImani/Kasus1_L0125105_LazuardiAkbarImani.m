% L0125105_Lazuardi Akbar Imani
clear; clc;

R  = 1;       % jari-jari tangki (m)
r  = 0.05;    % jari-jari lubang bocor (m)
h0 = 4;       % ketinggian awal air (m)
Cd = 0.6;     % koefisien debit
g  = 9.81;    % percepatan gravitasi (m/s^2)
h_target = 1; % batas ketinggian air (m)

% Penyederhanaan ke bentuk dh/dt = -k * sqrt(h)
A_tangki = pi * R^2;
a_lubang = pi * r^2;
k = Cd * (a_lubang / A_tangki) * sqrt(2 * g);

fprintf('Kasus1_L0125105_Lazuardi Akbar Imani\n')
fprintf('Konstanta k = %.6f m^(1/2)/s\n\n', k);

% --- a. METODE EKSAK ---
% Solusi analitik: h(t) = (sqrt(h0) - (k/2)*t)^2
h_eksak_func = @(t) (sqrt(h0) - (k / 2) * t).^2;
t_target = (2 / k) * (sqrt(h0) - sqrt(h_target));

fprintf('--- Poin (a): Penyelesaian Metode Eksak ---\n');
fprintf('Persamaan eksak             : h(t) = (%.4f - %.6f * t)^2\n', sqrt(h0), k / 2);
fprintf('Waktu saat h(t) tepat 1 m   : t = %.6f detik (%.2f menit)\n', t_target, t_target / 60);
fprintf('Ketinggian air berada di bawah 1 m setelah t > %.6f detik.\n\n', t_target);

% --- b. METODE HEUN (RUNGE-KUTTA ORDE 2) ---
f = @(t, h) -k * sqrt(h);
a = 0;
b = t_target; % Nilai b diambil dari nilai t pada poin (a)
N = 60;

fprintf('--- Poin (b): Penyelesaian Metode Heun (N = %d) ---\n', N);
fprintf('Interval waktu: a = %.6f s hingga b = %.6f s\n', a, b);

h_heun = Heun_L0125105_LazuardiAkbarImani(f, a, b, h0, N);
h_eksak_b = h_eksak_func(b);

galat_mutlak  = abs(h_eksak_b - h_heun);
galat_relatif = abs((h_eksak_b - h_heun) / h_eksak_b);

fprintf('\n=== RINGKASAN HASIL ===\n');
fprintf('Nilai Eksak h(b)            : %.6f m\n', h_eksak_b);
fprintf('Nilai Metode Heun h(b)      : %.6f m\n', h_heun);
fprintf('Galat Mutlak                : %.6f m (%.6e m)\n', galat_mutlak, galat_mutlak);
fprintf('Galat Relatif               : %.6f (%.6e atau %.6f%%)\n', ...
        galat_relatif, galat_relatif, galat_relatif * 100);