function [dpsi, eps] = nutasi(T)
  % NUTASI  Nutasi bujur (dpsi) dan kemiringan ekliptika sejati (eps), derajat.
  % Versi ringkas Meeus (1998) Bab 22, teliti sekitar 0,5 detik busur.
  % T = abad Julian TT sejak J2000.0
  Om = deg2rad(125.04452 - 1934.136261 * T);   % node naik orbit Bulan
  L  = deg2rad(280.4665 + 36000.7698 * T);     % bujur rata-rata Matahari
  Lp = deg2rad(218.3165 + 481267.8813 * T);    % bujur rata-rata Bulan
  dpsi = (-17.20*sin(Om) - 1.32*sin(2*L) - 0.23*sin(2*Lp) + 0.21*sin(2*Om)) / 3600;
  deps = (  9.20*cos(Om) + 0.57*cos(2*L) + 0.10*cos(2*Lp) - 0.09*cos(2*Om)) / 3600;
  eps0 = 23 + 26/60 + 21.448/3600 - (46.8150*T + 0.00059*T^2 - 0.001813*T^3) / 3600;
  eps  = eps0 + deps;
end
