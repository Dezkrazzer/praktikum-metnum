function [ra, dec] = ekliptika_ke_ekuator(lam, beta, eps)
  % Konversi koordinat ekliptika -> ekuator (Meeus Bab 13). Semua derajat.
  l = deg2rad(lam); b = deg2rad(beta); e = deg2rad(eps);
  ra  = mod(rad2deg(atan2(sin(l)*cos(e) - tan(b)*sin(e), cos(l))), 360);
  dec = rad2deg(asin(sin(b)*cos(e) + cos(b)*sin(e)*sin(l)));
end
