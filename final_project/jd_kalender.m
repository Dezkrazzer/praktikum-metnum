function JD = jd_kalender(thn, bln, tgl, jam)
  % JD_KALENDER  Mengubah tanggal kalender Gregorius (UT) menjadi Julian Day.
  % Rumus Meeus (1998) Bab 7. jam boleh desimal, misalnya 12.5 = 12:30.
  if nargin < 4, jam = 0; end
  if bln <= 2
    thn = thn - 1;
    bln = bln + 12;
  end
  A = floor(thn / 100);
  B = 2 - A + floor(A / 4);
  JD = floor(365.25 * (thn + 4716)) + floor(30.6001 * (bln + 1)) + tgl + jam / 24 + B - 1524.5;
end
