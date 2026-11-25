function h = tinggi_benda(phi, dec, H)
  % Tinggi benda langit (derajat) dari lintang pengamat, deklinasi, sudut jam.
  h = asind(sind(phi)*sind(dec) + cosd(phi)*cosd(dec)*cosd(H));
end
