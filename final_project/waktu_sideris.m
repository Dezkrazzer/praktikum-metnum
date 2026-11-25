function th = waktu_sideris(JD_UT, dpsi, eps)
  % Waktu sideris tampak Greenwich (derajat), Meeus Bab 12.
  T  = (JD_UT - 2451545.0) / 36525;
  th = 280.46061837 + 360.98564736629*(JD_UT - 2451545.0) + 0.000387933*T^2 - T^3/38710000;
  th = mod(th + dpsi*cosd(eps), 360);
end
