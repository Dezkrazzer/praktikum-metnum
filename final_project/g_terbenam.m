function y = g_terbenam(JD_UT, phi, lon, elev)
  % G_TERBENAM  Fungsi yang akarnya waktu terbenam Matahari (persamaan 2):
  % g(t) = h_matahari(t) - h0, dengan h0 = -(refraksi 34' + semidiameter + kerendahan ufuk).
  % phi = lintang (+LU), lon = bujur (+BT), elev = tinggi tempat (m).
  if nargin < 4, elev = 0; end
  [lam, R, eps, dpsi] = posisi_matahari(JD_UT);
  [ra, dec] = ekliptika_ke_ekuator(lam, 0, eps);
  H  = waktu_sideris(JD_UT, dpsi, eps) + lon - ra;      % sudut jam lokal
  sd = 959.63 / 3600 / R;                                % semidiameter Matahari
  h0 = -(34/60 + sd + 1.76/60*sqrt(elev));
  y  = tinggi_benda(phi, dec, H) - h0;
end
