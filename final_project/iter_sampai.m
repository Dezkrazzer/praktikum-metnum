function n = iter_sampai(riwayat, akar, tol)
  % Jumlah iterasi pertama yang membuat |x_k - akar| <= tol (NaN jika tidak pernah).
  idx = find(abs(riwayat - akar) <= tol, 1);
  if isempty(idx), n = NaN; else, n = idx; end
end
