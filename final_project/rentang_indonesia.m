function R = rentang_indonesia(thn, bln, tgl, langkah)
  % RENTANG_INDONESIA  Hitung tinggi hilal dan elongasi saat Matahari terbenam
  % pada grid lintang -11..6 dan bujur 95..141 (wilayah Indonesia), lalu
  % ringkas nilai minimum/maksimum dan jumlah titik yang memenuhi MABIMS.
  % Waktu terbenam tiap titik dicari dengan metode ITP (toleransi 1 detik).
  if nargin < 4, langkah = 1; end
  lat = -11:langkah:6;  lon = 95:langkah:141;
  H = zeros(numel(lat), numel(lon));  E = H;
  for i = 1:numel(lat)
    for j = 1:numel(lon)
      if lon(j) < 114, zona = 7; elseif lon(j) < 126, zona = 8; else, zona = 9; end
      t0 = jd_kalender(thn, bln, tgl, 0) - zona/24;
      g = @(t) g_terbenam(t, lat(i), lon(j));
      ts = itp(g, t0 + 17/24, t0 + 19.5/24, 1/86400);
      [h_obs, h_topo, el] = data_hilal(ts, lat(i), lon(j));
      H(i,j) = h_obs;  E(i,j) = el;
    end
  end
  R.lat = lat; R.lon = lon; R.H = H; R.E = E;
  R.hmin = min(H(:)); R.hmax = max(H(:)); R.emin = min(E(:)); R.emax = max(E(:));
  R.lolos = sum(H(:) >= 3 & E(:) >= 6.4);     % titik yang memenuhi MABIMS
end
