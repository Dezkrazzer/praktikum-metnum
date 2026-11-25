function R = refraksi(h)
  % Refraksi atmosfer (derajat) untuk tinggi sejati h, rumus Saemundsson
  % (Meeus Bab 16). Dipakai untuk h > -1 derajat; di bawahnya dibuat 0.
  if h > -1
    R = 1.02 / tand(h + 10.3/(h + 5.11)) / 60;
  else
    R = 0;
  end
end
