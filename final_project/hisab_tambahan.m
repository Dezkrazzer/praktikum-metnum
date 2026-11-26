% =========================================================================
%  HISAB_TAMBAHAN.M   (Project Metode Numerik - PNL, Kelompok D_1, Minggu 15)
%  Analisis tambahan untuk paper:
%   A. Validasi ijtimak terhadap efemeris JPL Horizons (data per 2 menit)
%   B. Uji keempat metode pada fungsi terbenam Matahari g(t) (17 kota-tanggal)
%   C. Ulang perbandingan metode pada f(t) untuk grafik 3 (sumbu y diperbaiki)
%   D. Grafik baru dan grafik perbaikan (grafik3b, grafik4b, grafik6-8)
%  Butuh semua file dari paket hisab_main + horizons_ijtimak.csv.
%  Jalankan dari folder yang sama:  >> hisab_tambahan
% =========================================================================
clear; clc; close all;
global DT_DETIK
DT_DETIK = 69.184;              % TT - UTC (detik)
TOL      = 0.01/86400;          % toleransi 0,01 detik (hari)
metode   = {'Biseksi', 'Regula Falsi', 'Secant', 'ITP'};
nama     = {'Ramadan 1447 H', 'Syawal 1447 H', 'Ramadan 1448 H', 'Syawal 1448 H'};
tgl_ij   = [2026 2 17; 2026 3 19; 2027 2 6; 2027 3 8];
ref_ij   = [12+1/60+7/3600; 1+23/60+23/3600; 15+56/60+2/3600; 9+29/60+26/3600];  % BMKG (jam UT)
tic;

%% ========================================================================
%  BAGIAN A. VALIDASI IJTIMAK TERHADAP JPL HORIZONS
%  Data: bujur ekliptika tampak Bulan (301) dan Matahari (10), geosentris,
%  tiap 2 menit selama 24 menit di sekitar ijtimak. Akar data Horizons
%  dicari dengan ITP pada interpolasi spline selisih bujur.
%  ========================================================================
H = dlmread('horizons_ijtimak.csv', ',', 1, 0);   % lewati baris judul
fprintf('=== BAGIAN A. IJTIMAK: PROGRAM vs JPL HORIZONS vs BMKG (jam UT) ===\n');
fprintf('%-15s %-12s %-12s %-12s %9s %9s %9s %9s\n', 'Peristiwa', 'Horizons', 'Program', 'BMKG', ...
        'Prog-Hz', 'BMKG-Hz', 'dLamB(")', 'dLamM(")');
sel_hz = zeros(4,2);  t_hz = zeros(4,1);  akar_ij = zeros(4,1);  dlam = zeros(4,2);
for k = 1:4
  d   = H(H(:,1) == k, :);
  mnt = d(:,5);  D = d(:,6) - d(:,7);                  % selisih bujur Horizons (deg)
  fh  = @(x) interp1(mnt, D, x, 'spline');
  m_hz = itp(fh, mnt(1), mnt(end), 0.01/60);           % akar dalam menit sejak 00 UT
  t0  = jd_kalender(tgl_ij(k,1), tgl_ij(k,2), tgl_ij(k,3), 0);
  t_hz(k)    = t0 + m_hz/1440;
  akar_ij(k) = itp(@f_ijtimak, t0 - 1, t0 + 1, TOL);
  t_bm       = t0 + ref_ij(k)/24;
  sel_hz(k,:) = [(akar_ij(k) - t_hz(k))*86400, (t_bm - t_hz(k))*86400];
  % galat model posisi pada titik-titik data Horizons (detik busur)
  eB = zeros(numel(mnt),1); eM = eB;
  for i = 1:numel(mnt)
    JD = t0 + mnt(i)/1440;
    lb = posisi_bulan(JD);  lm = posisi_matahari(JD);
    eB(i) = mod(lb - d(i,6) + 180, 360) - 180;
    eM(i) = mod(lm - d(i,7) + 180, 360) - 180;
  end
  dlam(k,:) = [mean(eB), mean(eM)]*3600;
  fprintf('%-15s %-12s %-12s %-12s %+9.1f %+9.1f %+9.1f %+9.1f\n', nama{k}, jd_ke_jam(t_hz(k), 0), ...
          jd_ke_jam(akar_ij(k), 0), jd_ke_jam(t_bm, 0), sel_hz(k,1), sel_hz(k,2), dlam(k,1), dlam(k,2));
end
fprintf('Rata-rata |selisih| terhadap Horizons: program %.1f s, BMKG %.1f s\n', mean(abs(sel_hz)));
fprintf('Catatan: dLamB/dLamM = galat rata-rata bujur Bulan/Matahari program terhadap Horizons.\n');
fprintf('Laju selisih bujur Bulan-Matahari sekitar 0,5 detik busur per detik waktu,\n');
fprintf('sehingga galat (dLamB - dLamM) detik busur menggeser ijtimak sekitar 2x lipat detik waktu.\n');

%% ========================================================================
%  BAGIAN B. KEEMPAT METODE PADA FUNGSI TERBENAM g(t)
%  17 kota-tanggal (sama dengan tabel kota hisab_main), tiga interval awal
%  (jam waktu lokal): [17;19,5], [15;21], [12;24]
%  ========================================================================
kota = {'Sabang','Banda Aceh','Tua Pejat','Jakarta','Surabaya','Merauke','Jayapura', ...
        'Banda Aceh','Sabang','Jakarta','Surabaya','Jayapura', ...
        'Banda Aceh','Sabang','Jakarta','Surabaya','Jayapura'};
la = struct('sab', 5+53.63/60, 'ba', 5+33.22/60, 'tp', -(2+2.53/60), 'jkt', -(6+10.21/60), ...
            'sby', -(7+20.19/60), 'mer', -(8+29.63/60), 'jay', -(2+32.68/60));
lo = struct('sab', 95+19.44/60, 'ba', 95+19.03/60, 'tp', 99+34.95/60, 'jkt', 106+49.86/60, ...
            'sby', 112+42.90/60, 'mer', 140+24.04/60, 'jay', 140+41.95/60);
% kolom: thn bln tgl lintang bujur zona tinggiBMKG
dt = [2026 2 18 la.sab lo.sab 7 10+1.90/60;  2026 2 18 la.ba lo.ba 7 10+0.80/60;
      2026 2 18 la.tp lo.tp 7 9+21.49/60;    2026 2 18 la.jkt lo.jkt 7 8+46.86/60;
      2026 2 18 la.sby lo.sby 7 8+30.16/60;  2026 2 18 la.mer lo.mer 9 7+37.20/60;
      2026 2 18 la.jay lo.jay 9 8+5.42/60;
      2027 2 7 la.ba lo.ba 7 7+11.04/60;     2027 2 7 la.sab lo.sab 7 7+11.82/60;
      2027 2 7 la.jkt lo.jkt 7 6+13.55/60;   2027 2 7 la.sby lo.sby 7 5+59.50/60;
      2027 2 7 la.jay lo.jay 9 5+32.52/60;
      2027 3 9 la.ba lo.ba 7 9+28.73/60;     2027 3 9 la.sab lo.sab 7 9+31.21/60;
      2027 3 9 la.jkt lo.jkt 7 7+30.57/60;   2027 3 9 la.sby lo.sby 7 7+10.32/60;
      2027 3 9 la.jay lo.jay 9 7+6.92/60];
nd = size(dt,1);
jendela = [17 19.5; 15 21; 12 24];  nw = size(jendela,1);
it_tol = zeros(nd, nw, 4);  it_stop = it_tol;  n_fev = it_tol;  galat_akhir = it_tol;
h_prog = zeros(nd,1);  riwayat_g = {};
for i = 1:nd
  phi = dt(i,4); lon = dt(i,5);
  g = @(t) g_terbenam(t, phi, lon);
  t_lok0 = jd_kalender(dt(i,1), dt(i,2), dt(i,3), 0) - dt(i,6)/24;   % 00:00 waktu lokal
  akar = biseksi(g, t_lok0 + 17/24, t_lok0 + 19.5/24, 1e-9);         % akar acuan
  h_prog(i) = data_hilal(akar, phi, lon);
  for w = 1:nw
    a = t_lok0 + jendela(w,1)/24;  b = t_lok0 + jendela(w,2)/24;
    [x1, n1, r1, e1] = biseksi(g, a, b, TOL);
    [x2, n2, r2, e2] = regula_falsi(g, a, b, TOL);
    [x3, n3, r3, e3] = secant(g, a, b, TOL);
    [x4, n4, r4, e4] = itp(g, a, b, TOL);
    rr = {r1, r2, r3, r4};  xx = [x1 x2 x3 x4];
    it_stop(i,w,:) = [n1 n2 n3 n4];  n_fev(i,w,:) = [e1 e2 e3 e4];
    for m = 1:4
      it_tol(i,w,m) = iter_sampai(rr{m}, akar, TOL);
      galat_akhir(i,w,m) = abs(xx(m) - akar)*86400;
    end
    if i == 4 && w == 3, riwayat_g = rr; akar_g = akar; end         % Jakarta 18 Feb 2026
  end
end
fprintf('\n=== BAGIAN B. METODE PADA g(t) (17 kota-tanggal) ===\n');
fprintf('%-16s %-14s %8s %13s %8s %6s\n', 'Interval lokal', 'Ukuran', 'Biseksi', 'Regula Falsi', 'Secant', 'ITP');
for w = 1:nw
  lab = sprintf('[%g ; %g] jam', jendela(w,1), jendela(w,2));
  fprintf('%-16s %-14s %8.1f %13.1f %8.1f %6.1f\n', lab, 'iter->0,01 s', squeeze(mean(it_tol(:,w,:), 1)));
  fprintf('%-16s %-14s %8.1f %13.1f %8.1f %6.1f\n', '', 'iter berhenti', squeeze(mean(it_stop(:,w,:), 1)));
  fprintf('%-16s %-14s %8.1f %13.1f %8.1f %6.1f\n', '', 'evaluasi g', squeeze(mean(n_fev(:,w,:), 1)));
  fprintf('%-16s %-14s %8.4f %13.4f %8.4f %6.4f\n', '', 'galat maks (s)', squeeze(max(galat_akhir(:,w,:), [], 1)));
end
fprintf('Kasus gagal (tidak pernah mencapai 0,01 s): %d\n', sum(isnan(it_tol(:))));

%% ========================================================================
%  BAGIAN C. ULANG PERBANDINGAN PADA f(t) UNTUK GRAFIK 3
%  ========================================================================
lebar = [1 3 7];  iter_tol = zeros(4, numel(lebar), 4);
for k = 1:4
  t0 = jd_kalender(tgl_ij(k,1), tgl_ij(k,2), tgl_ij(k,3), 0);
  akar_ref = biseksi(@f_ijtimak, t0 - 1, t0 + 1, 1e-9);
  for w = 1:numel(lebar)
    a = t0 - lebar(w); b = t0 + lebar(w);
    [~,~,r1] = biseksi(@f_ijtimak, a, b, TOL);  [~,~,r2] = regula_falsi(@f_ijtimak, a, b, TOL);
    [~,~,r3] = secant(@f_ijtimak, a, b, TOL);   [~,~,r4] = itp(@f_ijtimak, a, b, TOL);
    rr = {r1, r2, r3, r4};
    for m = 1:4, iter_tol(k,w,m) = iter_sampai(rr{m}, akar_ref, TOL); end
  end
end
rata3 = squeeze(mean(iter_tol, 1));
fprintf('\n=== BAGIAN C. RATA-RATA ITERASI PADA f(t) (grafik 3b) ===\n');
for w = 1:numel(lebar), fprintf('+-%d hari: %5.2f %5.2f %5.2f %5.2f\n', lebar(w), rata3(w,:)); end

%% ========================================================================
%  BAGIAN D. GRAFIK
%  ========================================================================
% 3b. Grafik 3 diperbaiki: sumbu y tidak memotong batang Biseksi, nilai tertulis
figure(1, 'Position', [100 100 760 480]);
hb = bar(lebar, rata3); grid on; ylim([0 max(rata3(:)) + 4]);
for w = 1:numel(lebar)
  for m = 1:4
    xpos = lebar(w) + (m - 2.5)*0.8/4*2;         % posisi kira-kira tengah batang
    text(xpos, rata3(w,m) + 0.6, sprintf('%.1f', rata3(w,m)), 'HorizontalAlignment', 'center', 'FontSize', 8);
  end
end
xlabel('Setengah lebar interval awal (hari)'); ylabel('Rata-rata iterasi sampai galat \leq 0,01 s');
title('Pengaruh lebar interval awal pada f(t) (4 peristiwa ijtimak)');
legend(metode, 'Location', 'northwest');
print('-dpng', '-r150', 'grafik3b_lebar_interval.png');

% 4b. Grafik 4 diperbaiki: batang horizontal, label kota + tanggal
lab = cell(nd,1);
for i = 1:nd, lab{i} = sprintf('%s %d/%d/%d', kota{i}, dt(i,3), dt(i,2), dt(i,1)); end
figure(2, 'Position', [100 100 760 620]);
barh([h_prog, dt(:,7)]); grid on; hold on;
plot([3 3], [0.5 nd+0.5], 'r--', 'LineWidth', 1.5);
set(gca, 'YTick', 1:nd, 'YTickLabel', lab, 'FontSize', 8, 'YDir', 'reverse');
xlabel('Tinggi hilal saat Matahari terbenam (derajat)');
title('Tinggi hilal: program vs BMKG');
legend('Program', 'BMKG', 'Batas MABIMS 3\circ', 'Location', 'southeast');
print('-dpng', '-r150', 'grafik4b_tinggi_hilal.png');

% 6. Selisih waktu ijtimak terhadap JPL Horizons
figure(3, 'Position', [100 100 760 450]);
bar(sel_hz); grid on; hold on;
set(gca, 'XTick', 1:4, 'XTickLabel', nama);
ylabel('Selisih terhadap JPL Horizons (detik)');
title('Waktu ijtimak: program (ITP + Meeus) dan BMKG dibandingkan JPL Horizons');
legend('Program - Horizons', 'BMKG - Horizons', 'Location', 'northeast');
for k = 1:4
  text(k - 0.15, sel_hz(k,1) + 2, sprintf('%+.1f', sel_hz(k,1)), 'HorizontalAlignment', 'center', 'FontSize', 8);
  text(k + 0.15, sel_hz(k,2) + 2, sprintf('%+.1f', sel_hz(k,2)), 'HorizontalAlignment', 'center', 'FontSize', 8);
end
print('-dpng', '-r150', 'grafik6_selisih_horizons.png');

% 7. Rata-rata iterasi pada g(t) untuk tiga interval
figure(4, 'Position', [100 100 760 450]);
rata_g = squeeze(mean(it_tol, 1));
bar(rata_g); grid on; ylim([0 max(rata_g(:)) + 4]);
set(gca, 'XTick', 1:nw, 'XTickLabel', {'[17 ; 19,5] jam', '[15 ; 21] jam', '[12 ; 24] jam'});
ylabel('Rata-rata iterasi sampai galat \leq 0,01 s');
title('Metode pada fungsi terbenam g(t), 17 kota-tanggal');
legend(metode, 'Location', 'northwest');
print('-dpng', '-r150', 'grafik7_metode_terbenam.png');

% 8. Konvergensi pada g(t): Jakarta 18 Feb 2026, interval [12 ; 24] jam
figure(5, 'Position', [100 100 760 450]);
gaya = {'k-o', 'b-s', 'g-^', 'r-d'};
for m = 1:4
  e = abs(riwayat_g{m} - akar_g)*86400;  e(e == 0) = 1e-6;
  semilogy(1:numel(e), e, gaya{m}, 'LineWidth', 1.2); hold on;
end
plot([0 30], [0.01 0.01], 'm--'); grid on;
xlabel('Iterasi'); ylabel('|t_k - t^*| (detik)');
title('Konvergensi waktu terbenam Jakarta, 18 Feb 2026 (interval 12-24 WIB)');
legend([metode, {'toleransi 0,01 s'}]);
print('-dpng', '-r150', 'grafik8_konvergensi_terbenam.png');

fprintf('\nSelesai dalam %.1f detik. Grafik: grafik3b, grafik4b, grafik6, grafik7, grafik8 (PNG).\n', toc);
