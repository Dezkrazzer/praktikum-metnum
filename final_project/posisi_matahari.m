function [lam, R, eps, dpsi] = posisi_matahari(JD_UT)
  % POSISI_MATAHARI  Bujur ekliptika tampak Matahari (derajat, ekuinoks sesaat).
  % Meeus (1998) Bab 25 (ketelitian sekitar 0,01 derajat) + nutasi + aberasi.
  % R = jarak Bumi-Matahari (AU).
  global DT_DETIK
  T  = (JD_UT + DT_DETIK/86400 - 2451545.0) / 36525;   % abad Julian TT
  L0 = 280.46646 + 36000.76983*T + 0.0003032*T^2;       % bujur rata-rata
  M  = 357.52911 + 35999.05029*T - 0.0001537*T^2;       % anomali rata-rata
  e  = 0.016708634 - 0.000042037*T - 0.0000001267*T^2;  % eksentrisitas orbit Bumi
  Mr = deg2rad(M);
  C  = (1.914602 - 0.004817*T - 0.000014*T^2) * sin(Mr) ...
     + (0.019993 - 0.000101*T) * sin(2*Mr) + 0.000289 * sin(3*Mr);   % persamaan pusat
  v  = deg2rad(M + C);                                   % anomali benar
  R  = 1.000001018 * (1 - e^2) / (1 + e*cos(v));
  [dpsi, eps] = nutasi(T);
  lam = mod(L0 + C + dpsi - 20.4898/3600/R, 360);        % + nutasi - aberasi
end
