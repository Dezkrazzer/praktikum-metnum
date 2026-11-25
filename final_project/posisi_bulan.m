function [lam, beta, jarak, paralaks, eps, dpsi] = posisi_bulan(JD_UT)
  % POSISI_BULAN  Posisi tampak Bulan menurut Meeus (1998) Bab 47 (ELP-2000/82
  % ringkas, 60 suku bujur/jarak + 60 suku lintang). Hasil dalam derajat & km.
  global DT_DETIK
  persistent TLR TB
  if isempty(TLR)
    TLR = dlmread('moon_lr.csv', ',');   % kolom: D M M' F koef_bujur koef_jarak
    TB  = dlmread('moon_b.csv', ',');    % kolom: D M M' F koef_lintang
  end
  T  = (JD_UT + DT_DETIK/86400 - 2451545.0) / 36525;
  Lp = 218.3164477 + (481267.88123421 + (-0.0015786 + (1/538841 - T/65194000)*T)*T)*T;
  D  = 297.8501921 + (445267.1114034 + (-0.0018819 + (1/545868 - T/113065000)*T)*T)*T;
  M  = 357.5291092 + (35999.0502909 + (-0.0001536 + T/24490000)*T)*T;
  Mp = 134.9633964 + (477198.8675055 + (0.0087414 + (1/69699 - T/14712000)*T)*T)*T;
  F  = 93.2720950 + (483202.0175233 + (-0.0036539 + (-1/3526000 + T/863310000)*T)*T)*T;
  A1 = deg2rad(119.75 + 131.849*T);
  A2 = deg2rad(53.09 + 479264.290*T);
  A3 = deg2rad(313.45 + 481266.484*T);
  E  = 1 - 0.002516*T - 0.0000074*T^2;          % faktor eksentrisitas orbit Bumi
  arg = deg2rad(mod([D; M; Mp; F], 360));       % vektor kolom 4x1 (radian)

  % --- jumlahan suku periodik (vektorisasi) ---
  sudut = TLR(:,1:4) * arg;                     % argumen tiap suku (60x1)
  fE    = E .^ abs(TLR(:,2));                   % suku dengan M dikali E atau E^2
  sigl  = sum(TLR(:,5) .* fE .* sin(sudut));
  sigr  = sum(TLR(:,6) .* fE .* cos(sudut));
  sudutb = TB(:,1:4) * arg;
  sigb  = sum(TB(:,5) .* (E .^ abs(TB(:,2))) .* sin(sudutb));

  % --- suku tambahan (Venus, Jupiter, pepatan Bumi) ---
  Lpr = deg2rad(mod(Lp, 360)); Fr = arg(4); Mpr = arg(3);
  sigl = sigl + 3958*sin(A1) + 1962*sin(Lpr - Fr) + 318*sin(A2);
  sigb = sigb - 2235*sin(Lpr) + 382*sin(A3) + 175*sin(A1 - Fr) + 175*sin(A1 + Fr) ...
              + 127*sin(Lpr - Mpr) - 115*sin(Lpr + Mpr);

  [dpsi, eps] = nutasi(T);
  lam      = mod(Lp + sigl/1e6 + dpsi, 360);    % bujur tampak
  beta     = sigb / 1e6;                         % lintang
  jarak    = 385000.56 + sigr / 1000;            % km
  paralaks = rad2deg(asin(6378.14 / jarak));     % paralaks horizontal
end
