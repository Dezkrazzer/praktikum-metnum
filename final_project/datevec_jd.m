function [thn, bln, tgl] = datevec_jd(JD)
  % Mengubah Julian Day menjadi tanggal kalender Gregorius (Meeus Bab 7).
  Z = floor(JD + 0.5); F = JD + 0.5 - Z;
  alpha = floor((Z - 1867216.25)/36524.25);
  A = Z + 1 + alpha - floor(alpha/4);
  B = A + 1524; C = floor((B - 122.1)/365.25);
  D = floor(365.25*C); E = floor((B - D)/30.6001);
  tgl = floor(B - D - floor(30.6001*E) + F);
  if E < 14, bln = E - 1; else, bln = E - 13; end
  if bln > 2, thn = C - 4716; else, thn = C - 4715; end
end
