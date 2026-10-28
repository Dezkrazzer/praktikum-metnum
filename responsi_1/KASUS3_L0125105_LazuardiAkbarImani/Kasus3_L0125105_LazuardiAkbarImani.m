% L0125105_Lazuardi Akbar Imani

m = 50; h = 500; c = 10; g = 9.8;

% Fungsi s(t) dan f(t) = h - s(t)
s = @(t) (m*g/c)*t - ((m^2 * g)/(c^2)) * (1 - exp(-(c/m)*t));
f = @(t) h - s(t);

% Kecepatan v(t) yang juga merupakan s'(t)
% Karena f(t) = h - s(t), maka turunan f'(t) = -v(t)
v = @(t) (m*g/c) * (1 - exp(-(c/m)*t));
f_diff = @(t) -v(t);

% 1. Metode Grafik untuk Tebakan Awal
t_plot = 0:1:20;
figure;
plot(t_plot, f(t_plot), 'b-', 'LineWidth', 2); hold on;
line([0 20], [0 0], 'color', 'k');
xlabel('Waktu t (s)'); ylabel('f(t) = h - s(t)');
title('Grafik Kasus 3 untuk Tebakan Awal');
grid on;
% Dari grafik visual nanti, perkiraan jatuh di sekitar t = 12 s
t0_tebakan = 12;

% 2. Eksekusi Newton-Raphson
tol = 10^-5;
maxIter = 20;

fprintf('\nL0125105_Lazuardi Akbar Imani\n');

fprintf('=== HASIL ANALISIS KASUS 3 ===\n');
fprintf('Tebakan awal berdasarkan grafik: %f sekon\n\n', t0_tebakan);

t_jatuh = NewtonRaphson_L0125105(f, f_diff, t0_tebakan, maxIter, tol);

% 3. Hitung Kecepatan Saat Jatuh
v_jatuh = v(t_jatuh);

fprintf('\nKesimpulan:\n');
fprintf('Waktu saat menyentuh tanah (t) : %f sekon\n', t_jatuh);
fprintf('Kecepatan saat menyentuh tanah : %f m/s\n', v_jatuh);