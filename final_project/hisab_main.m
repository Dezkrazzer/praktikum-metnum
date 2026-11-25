% =========================================================================
%  HISAB_MAIN.M   (Project Metode Numerik - PNL, Kelompok D_1)
%  Penentuan waktu ijtimak dan tinggi hilal awal Ramadan & Syawal
%  Metode baru: ITP  |  Pembanding: Biseksi, Regula Falsi, Secant
%
%  Alur: (1) uji model posisi, (2) VALIDASI tahun 1447 H (2026) terhadap
%  BMKG, Kemenag, dan JPL Horizons, (3) PREDIKSI tahun 1448 H (2027) dan
%  dibandingkan dengan buku Peta Ketinggian Hilal 2027 BMKG,
%  (4) perbandingan metode numerik, (5) grafik.
%  Jalankan dari folder yang berisi semua file:  >> hisab_main
% =========================================================================
clear; clc; close all;
global DT_DETIK
DT_DETIK = 69.184;          % TT - UTC = 32,184 s + 37 s detik kabisat
TOL      = 0.01/86400;      % toleransi 0,01 detik (satuan hari)
metode   = {'Biseksi', 'Regula Falsi', 'Secant', 'ITP'};
hari     = {'Minggu','Senin','Selasa','Rabu','Kamis','Jumat','Sabtu'};
tic;

%% ========================================================================
%  BAGIAN 1. UJI MODEL POSISI
%  ========================================================================
fprintf('=== BAGIAN 1. UJI MODEL POSISI ===\n');
j = jd_kalender(1992, 4, 12, 0) - DT_DETIK/86400;
[lb, bb, db] = posisi_bulan(j);
fprintf('Contoh Meeus 47.a : bujur %.6f (buku 133.167264), lintang %.6f (buku -3.229126), jarak %.1f km (buku 368409.7)\n', lb, bb, db);
acuan = [2026 2 17 12+1/60  328.8274929 328.8287685;
         2026 3 19  1+23/60 358.4467294 358.4510413];
for i = 1:2
  j = jd_kalender(acuan(i,1), acuan(i,2), acuan(i,3), acuan(i,4));
  lb = posisi_bulan(j); lm = posisi_matahari(j);
  fprintf('%04d-%02d-%02d : selisih bujur Bulan %+6.1f", Matahari %+6.1f" terhadap JPL Horizons\n', ...
          acuan(i,1), acuan(i,2), acuan(i,3), (lb-acuan(i,5))*3600, (lm-acuan(i,6))*3600);
end

%% ========================================================================
%  Data peristiwa: [thn bln tgl(perkiraan ijtimak)  thn bln tgl(29 Hijriah)]
%  acuan ijtimak dari BMKG dalam jam UT desimal
%  ========================================================================
nama  = {'Ramadan 1447 H', 'Syawal 1447 H', 'Ramadan 1448 H', 'Syawal 1448 H'};
tgl_ij = [2026 2 17; 2026 3 19; 2027 2 6; 2027 3 8];          % tanggal ijtimak
tgl_29 = [2026 2 17; 2026 3 19; 2027 2 6; 2027 3 8];          % malam rukyat (29 Hijriah)
ref_ij = [12+1/60+7/3600; 1+23/60+23/3600; 15+56/60+2/3600; 9+29/60+26/3600];   % BMKG (UT)
resmi_kemenag = {'Kamis, 19 Februari 2026', 'Sabtu, 21 Maret 2026', 'belum ditetapkan', 'belum ditetapkan (SKB libur: 10-11 Mar 2027)'};
resmi_khgt    = {'Rabu, 18 Februari 2026', 'Jumat, 20 Maret 2026', 'Senin, 8 Februari 2027', 'Selasa, 9 Maret 2027'};

%% ========================================================================
%  BAGIAN 2 & 3. IJTIMAK, RENTANG HILAL SE-INDONESIA, DAN KEPUTUSAN MABIMS
%  ========================================================================
akar_ij = zeros(4,1);  hasil_R = cell(4,1);
for k = 1:4
  if k == 1, fprintf('\n=== BAGIAN 2. VALIDASI TAHUN 1447 H (2026) ===\n'); end
  if k == 3, fprintf('\n=== BAGIAN 3. PREDIKSI TAHUN 1448 H (2027) ===\n'); end
  t0 = jd_kalender(tgl_ij(k,1), tgl_ij(k,2), tgl_ij(k,3), 0);
  akar_ij(k) = itp(@f_ijtimak, t0 - 1, t0 + 1, TOL);
  t_ref = t0 + ref_ij(k)/24;
  fprintf('\n[%s]\n', nama{k});
  fprintf('Ijtimak (ITP) : %02d-%02d-%04d %s WIB | BMKG %s WIB | selisih %+.0f detik\n', ...
          tgl_ij(k,3), tgl_ij(k,2), tgl_ij(k,1), jd_ke_jam(akar_ij(k), 7), jd_ke_jam(t_ref, 7), (akar_ij(k) - t_ref)*86400);
  % rentang tinggi & elongasi hilal se-Indonesia pada malam 29 Hijriah
  R = rentang_indonesia(tgl_29(k,1), tgl_29(k,2), tgl_29(k,3), 1);
  hasil_R{k} = R;
  fprintf('Malam %02d-%02d-%04d: tinggi hilal %.2f s.d. %.2f deg, elongasi %.2f s.d. %.2f deg, titik memenuhi MABIMS = %d\n', ...
          tgl_29(k,3), tgl_29(k,2), tgl_29(k,1), R.hmin, R.hmax, R.emin, R.emax, R.lolos);
  % keputusan: jika ada titik memenuhi MABIMS -> besok tanggal 1; jika tidak -> istikmal (lusa)
  t29 = jd_kalender(tgl_29(k,1), tgl_29(k,2), tgl_29(k,3), 12);
  if R.lolos > 0, t1 = t29 + 1; ket = 'memenuhi MABIMS'; else, t1 = t29 + 2; ket = 'tidak memenuhi -> istikmal (bulan digenapkan 30 hari)'; end
  [yy, mm, dd] = datevec_jd(t1);
  idx = mod(floor(t1 + 1.5), 7) + 1;                       % hari dalam pekan
  fprintf('Keputusan     : %s\n', ket);
  fprintf('1 %s menurut program (MABIMS): %s, %d-%02d-%04d\n', nama{k}, hari{idx}, dd, mm, yy);
  fprintf('Kemenag resmi : %s  |  Muhammadiyah (KHGT): %s\n', resmi_kemenag{k}, resmi_khgt{k});
end
% Acuan rentang dari Kemenag (19 Mar 2026): tinggi 0,91-3,13; elongasi 4,54-6,10
fprintf('\nPembanding Kemenag 19 Mar 2026: tinggi 0.91 s.d. 3.13 deg, elongasi 4.54 s.d. 6.10 deg\n');

%% ========================================================================
%  BAGIAN 2b & 3b. TABEL KOTA (hilal di atas ufuk) dibandingkan BMKG
%  ========================================================================
% kolom: tahun bulan tanggal lintang bujur zona terbenamBMKG(jam) tinggiBMKG elongBMKG
kota = {'Sabang','Banda Aceh','Tua Pejat','Jakarta','Surabaya','Merauke','Jayapura', ...
        'Banda Aceh','Sabang','Jakarta','Surabaya','Jayapura', ...
        'Banda Aceh','Sabang','Jakarta','Surabaya','Jayapura'};
la = struct('sab', 5+53.63/60, 'ba', 5+33.22/60, 'tp', -(2+2.53/60), 'jkt', -(6+10.21/60), ...
            'sby', -(7+20.19/60), 'mer', -(8+29.63/60), 'jay', -(2+32.68/60));
lo = struct('sab', 95+19.44/60, 'ba', 95+19.03/60, 'tp', 99+34.95/60, 'jkt', 106+49.86/60, ...
            'sby', 112+42.90/60, 'mer', 140+24.04/60, 'jay', 140+41.95/60);
dt = [2026 2 18 la.sab lo.sab 7 18+51/60+10/3600 10+1.90/60  12+12.15/60;
      2026 2 18 la.ba  lo.ba  7 18+51/60+29/3600 10+0.80/60  12+12.31/60;
      2026 2 18 la.tp  lo.tp  7 18+40/60+37/3600  9+21.49/60 12+6.68/60;
      2026 2 18 la.jkt lo.jkt 7 18+15/60+ 2/3600  8+46.86/60 11+53.44/60;
      2026 2 18 la.sby lo.sby 7 17+52/60+29/3600  8+30.16/60 11+41.76/60;
      2026 2 18 la.mer lo.mer 9 18+ 2/60+44/3600  7+37.20/60 10+45.04/60;
      2026 2 18 la.jay lo.jay 9 17+56/60+35/3600  8+ 5.42/60 10+41.86/60;
      2027 2  7 la.ba  lo.ba  7 18+50/60+12/3600  7+11.04/60  9+11.09/60;
      2027 2  7 la.sab lo.sab 7 18+49/60+48/3600  7+11.82/60  9+10.90/60;
      2027 2  7 la.jkt lo.jkt 7 18+17/60+ 1/3600  6+13.55/60  8+55.67/60;
      2027 2  7 la.sby lo.sby 7 17+54/60+47/3600  5+59.50/60  8+45.34/60;
      2027 2  7 la.jay lo.jay 9 17+57/60+32/3600  5+32.52/60  7+50.91/60;
      2027 3  9 la.ba  lo.ba  7 18+50/60+55/3600  9+28.73/60 13+15.72/60;
      2027 3  9 la.sab lo.sab 7 18+50/60+47/3600  9+31.21/60 13+15.66/60;
      2027 3  9 la.jkt lo.jkt 7 18+ 8/60+34/3600  7+30.57/60 12+55.24/60;
      2027 3  9 la.sby lo.sby 7 17+45/60+25/3600  7+10.32/60 12+44.06/60;
      2027 3  9 la.jay lo.jay 9 17+51/60+57/3600  7+ 6.92/60 11+49.40/60];
nd = size(dt,1); sel = zeros(nd,3); h_prog = zeros(nd,1);
fprintf('\n=== TABEL KOTA: PROGRAM vs BMKG ===\n');
fprintf('%-11s %-10s %-12s %8s %8s %8s %8s %8s\n', 'Kota', 'Tanggal', 'Terbenam', 'Sel.(s)', 'Tinggi', 'BMKG', 'Elong', 'BMKG');
for i = 1:nd
  phi = dt(i,4); lon = dt(i,5); zona = dt(i,6);
  t_lokal0 = jd_kalender(dt(i,1), dt(i,2), dt(i,3), 0) - zona/24;
  ts = itp(@(t) g_terbenam(t, phi, lon), t_lokal0 + 17/24, t_lokal0 + 19.5/24, TOL);
  [h_obs, ~, el] = data_hilal(ts, phi, lon);
  t_bmkg = t_lokal0 + dt(i,7)/24;
  sel(i,:) = [(ts - t_bmkg)*86400, h_obs - dt(i,8), el - dt(i,9)];
  h_prog(i) = h_obs;
  fprintf('%-11s %02d-%02d-%04d %-12s %8.1f %8.3f %8.3f %8.3f %8.3f\n', kota{i}, dt(i,3), dt(i,2), dt(i,1), ...
          jd_ke_jam(ts, zona), sel(i,1), h_obs, dt(i,8), el, dt(i,9));
end
fprintf('Rata-rata |selisih|: terbenam %.1f s, tinggi %.3f deg, elongasi %.3f deg (%d data)\n', ...
        mean(abs(sel(:,1))), mean(abs(sel(:,2))), mean(abs(sel(:,3))), nd);

%% ========================================================================
%  BAGIAN 4. PERBANDINGAN METODE NUMERIK (ijtimak keempat peristiwa)
%  ========================================================================
fprintf('\n=== BAGIAN 4. PERBANDINGAN METODE (iterasi sampai galat <= 0,01 detik) ===\n');
lebar = [1 3 7];  iter_tol = zeros(4, numel(lebar), 4);  riwayat_plot = cell(1,4);
fprintf('%-15s %-9s %8s %13s %8s %6s\n', 'Peristiwa', 'Interval', 'Biseksi', 'Regula Falsi', 'Secant', 'ITP');
for k = 1:4
  t0 = jd_kalender(tgl_ij(k,1), tgl_ij(k,2), tgl_ij(k,3), 0);
  akar_ref = biseksi(@f_ijtimak, t0 - 1, t0 + 1, 1e-9);        % akar acuan sangat ketat
  for w = 1:numel(lebar)
    a = t0 - lebar(w); b = t0 + lebar(w);
    [~,~,r1] = biseksi(@f_ijtimak, a, b, TOL);
    [~,~,r2] = regula_falsi(@f_ijtimak, a, b, TOL);
    [~,~,r3] = secant(@f_ijtimak, a, b, TOL);
    [~,~,r4] = itp(@f_ijtimak, a, b, TOL);
    rr = {r1, r2, r3, r4};
    for m = 1:4, iter_tol(k,w,m) = iter_sampai(rr{m}, akar_ref, TOL); end
    if k == 1 && w == 2, riwayat_plot = rr; akar_plot = akar_ref; end
    fprintf('%-15s +-%d hari %8d %13d %8d %6d\n', nama{k}, lebar(w), iter_tol(k,w,:));
  end
end
fprintf('Rata-rata iterasi: Biseksi %.1f | Regula Falsi %.1f | Secant %.1f | ITP %.1f\n', ...
        mean(reshape(iter_tol(:,:,1),[],1)), mean(reshape(iter_tol(:,:,2),[],1)), ...
        mean(reshape(iter_tol(:,:,3),[],1)), mean(reshape(iter_tol(:,:,4),[],1)));
fprintf('\nSensitivitas parameter k1 ITP (Ramadan 1447 H, interval +-3 hari):\n');
t0 = jd_kalender(2026, 2, 17, 0); a = t0 - 3; b = t0 + 3;
for c = [0.2 0.05 0.01 0.001]
  [~, it, rw] = itp(@f_ijtimak, a, b, TOL, c/(b - a));
  fprintf('  k1 = %.3f/(b-a): berhenti setelah %2d iterasi, galat <= 0,01 s pada iterasi ke-%d\n', c, it, iter_sampai(rw, akar_plot, TOL));
end

%% ========================================================================
%  BAGIAN 5. GRAFIK (disimpan sebagai PNG)
%  ========================================================================
t0 = jd_kalender(2026, 2, 17, 0);
tt = linspace(t0 - 2, t0 + 2, 300); ff = arrayfun(@f_ijtimak, tt);
figure(1); plot((tt - t0)*24, ff, 'b-', 'LineWidth', 1.5); hold on;
plot((akar_ij(1) - t0)*24, 0, 'ro', 'MarkerFaceColor', 'r'); grid on;
xlabel('Jam sejak 17 Feb 2026 00:00 UT'); ylabel('f(t) (derajat)');
title('Fungsi ijtimak f(t) Ramadan 1447 H'); legend('f(t)', 'akar', 'Location', 'northwest');
print('-dpng', 'grafik1_fungsi_ijtimak.png');

figure(2); gaya = {'k-o', 'b-s', 'g-^', 'r-d'};
for m = 1:4
  galat = abs(riwayat_plot{m} - akar_plot)*86400; galat(galat == 0) = 1e-6;
  semilogy(1:numel(galat), galat, gaya{m}, 'LineWidth', 1.2); hold on;
end
grid on; xlabel('Iterasi'); ylabel('|t_k - t^*| (detik)');
title('Konvergensi ijtimak Ramadan 1447 H (interval \pm3 hari)'); legend(metode);
print('-dpng', 'grafik2_konvergensi.png');

figure(3); bar(lebar, squeeze(mean(iter_tol, 1))); grid on;
xlabel('Setengah lebar interval awal (hari)'); ylabel('Rata-rata iterasi sampai galat \leq 0,01 s');
title('Pengaruh lebar interval awal (4 peristiwa ijtimak)'); legend(metode, 'Location', 'northwest');
print('-dpng', 'grafik3_lebar_interval.png');

figure(4); bar([h_prog, dt(:,8)]); grid on; hold on;
plot([0.5 nd+0.5], [3 3], 'r--');
set(gca, 'XTick', 1:nd, 'XTickLabel', kota, 'FontSize', 7);
ylabel('Tinggi hilal (derajat)'); title('Tinggi hilal: program vs BMKG (18 Feb 2026, 7 Feb 2027, 9 Mar 2027)');
legend('Program', 'BMKG', 'Batas MABIMS 3\circ');
print('-dpng', 'grafik4_tinggi_hilal.png');

R = rentang_indonesia(2027, 2, 7, 0.5);                 % peta prediksi 1 Ramadan 1448 H
figure(5); contourf(R.lon, R.lat, R.H, 12); colorbar; hold on;
contour(R.lon, R.lat, R.H, [3 3], 'r', 'LineWidth', 2);
xlabel('Bujur (BT)'); ylabel('Lintang'); axis equal tight;
title('Prediksi tinggi hilal 7 Februari 2027 saat Matahari terbenam (derajat)');
print('-dpng', 'grafik5_peta_hilal_2027.png');
fprintf('\nSelesai dalam %.1f detik. Lima grafik PNG tersimpan di folder kerja.\n', toc);
