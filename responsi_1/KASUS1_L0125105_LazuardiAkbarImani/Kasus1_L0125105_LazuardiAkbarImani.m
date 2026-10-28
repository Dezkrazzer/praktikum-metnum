% L0125105_Lazuardi Akbar Imani

I0 = 4; a = 0.9; w = 4; phi = pi/6;
t = 0:0.1:4.5; % Rentang waktu

% Fungsi Eksak
f_eksak = I0 * exp(-a*t) .* cos(w*t + phi);

% Fungsi Pendekatan (Deret Maclaurin)
x_exp = -a*t;
x_cos = w*t + phi;

f_n20 = I0 * exp_maclaurin(x_exp, 20) .* cos_maclaurin(x_cos, 20);
f_n22 = I0 * exp_maclaurin(x_exp, 22) .* cos_maclaurin(x_cos, 22);
f_n24 = I0 * exp_maclaurin(x_exp, 24) .* cos_maclaurin(x_cos, 24);

% Grafik
figure;
plot(t, f_eksak, 'k-', 'LineWidth', 2); hold on;
plot(t, f_n20, 'r--', 'LineWidth', 1.5);
plot(t, f_n22, 'g-.', 'LineWidth', 1.5);
plot(t, f_n24, 'b:', 'LineWidth', 1.5);
ylim([-5 5]);
xlabel('Waktu (t)'); ylabel('Arus I(t)');
title('Perbandingan I(t) Eksak vs Maclaurin');
legend('Eksak', 'n=20', 'n=22', 'n=24');
grid on;

% Rata-rata galat mutlak
galat_n20 = mean(abs(f_eksak - f_n20));
galat_n22 = mean(abs(f_eksak - f_n22));
galat_n24 = mean(abs(f_eksak - f_n24));

fprintf('\nL0125105_Lazuardi Akbar Imani\n');

fprintf('=== HASIL ANALISIS KASUS 1 ===\n');
fprintf('Rerata Galat Mutlak n=20 : %f A\n', galat_n20);
fprintf('Rerata Galat Mutlak n=22 : %f A\n', galat_n22);
fprintf('Rerata Galat Mutlak n=24 : %f A\n', galat_n24);

% Toleransi
tol = 0.01;
fprintf('\nKesimpulan:\n');
if galat_n20 <= tol, fprintf('- n=20 LAYAK digunakan.\n'); end
if galat_n22 <= tol, fprintf('- n=22 LAYAK digunakan.\n'); end
if galat_n24 <= tol, fprintf('- n=24 LAYAK digunakan.\n'); end