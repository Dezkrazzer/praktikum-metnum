function s = jd_ke_jam(JD, zona)
  % JD_KE_JAM  Mengubah JD (UT) menjadi teks jam "hh:mm:ss.ss" pada zona waktu
  % tertentu (zona = 0 untuk UT, 7 untuk WIB, 8 WITA, 9 WIT).
  if nargin < 2, zona = 0; end
  fr = mod(JD + 0.5 + zona / 24, 1) * 24;   % jam desimal dalam satu hari
  h = floor(fr);
  m = floor((fr - h) * 60);
  d = ((fr - h) * 60 - m) * 60;
  s = sprintf('%02d:%02d:%05.2f', h, m, d);
end
