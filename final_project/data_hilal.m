function [h_obs, h_topo, elong] = data_hilal(JD_UT, phi, lon, elev)
  % DATA_HILAL  Tinggi hilal dan elongasi pada waktu JD_UT (biasanya saat terbenam).
  % h_topo = tinggi toposentrik (koreksi paralaks, Meeus Bab 40)
  % h_obs  = h_topo + refraksi (definisi yang cocok dengan tabel BMKG)
  % elong  = elongasi geosentrik Bulan-Matahari
  if nargin < 4, elev = 0; end
  [lam, beta, ~, par, eps, dpsi] = posisi_bulan(JD_UT);
  [ra, dec] = ekliptika_ke_ekuator(lam, beta, eps);
  H = waktu_sideris(JD_UT, dpsi, eps) + lon - ra;
  % --- koreksi paralaks: koordinat toposentrik ---
  u  = atan(0.99664719 * tand(phi));
  rs = 0.99664719*sin(u) + elev/6378140*sind(phi);   % rho sin(phi')
  rc = cos(u)            + elev/6378140*cosd(phi);   % rho cos(phi')
  sp = sind(par);
  dra  = atan2(-rc*sp*sind(H), cosd(dec) - rc*sp*cosd(H));
  dtop = atan2((sind(dec) - rs*sp)*cos(dra), cosd(dec) - rc*sp*cosd(H));
  h_topo = tinggi_benda(phi, rad2deg(dtop), H - rad2deg(dra));
  h_obs  = h_topo + refraksi(h_topo);
  % --- elongasi ---
  lm = posisi_matahari(JD_UT);
  [ras, decs] = ekliptika_ke_ekuator(lm, 0, eps);
  elong = acosd(sind(dec)*sind(decs) + cosd(dec)*cosd(decs)*cosd(ra - ras));
end
