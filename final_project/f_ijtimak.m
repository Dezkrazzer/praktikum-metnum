function y = f_ijtimak(JD_UT)
  % F_IJTIMAK  Fungsi yang akarnya adalah waktu ijtimak (persamaan 1):
  % f(t) = wrap(lambda_bulan - lambda_matahari), dalam derajat, rentang (-180,180].
  lb = posisi_bulan(JD_UT);
  lm = posisi_matahari(JD_UT);
  y  = mod(lb - lm + 180, 360) - 180;
end
