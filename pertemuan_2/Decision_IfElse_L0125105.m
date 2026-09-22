# L0125105_Lazuardi Akbar Imani

fprintf('L0125105_Lazuardi Akbar Imani\n\n');
fprintf('======== [ INFO IMT SIMPEL ] ========\n');

imt = input('Masukkan nilai Indeks Massa Tubuh (IMT) kamu: ');
fprintf('Nilai IMT yang kamu masukkan: %.2f\n\n', imt);

if (imt >= 27.0)
    fprintf('Status: Obesitas Tingkat II\n');
elseif (imt >= 25.0 && imt < 27.0)
    fprintf('Status: Obesitas Tingkat I\n');
elseif (imt >= 23.0 && imt < 25.0)
    fprintf('Status: Kelebihan Berat Badan (Overweight)\n');
elseif (imt >= 18.5 && imt < 23.0)
    fprintf('Status: Berat Badan Normal\n');
elseif (imt >= 17.0 && imt < 18.5)
    fprintf('Status: Kekurangan Berat Badan Tingkat Ringan\n');
else
    fprintf('Status: Kekurangan Berat Badan Tingkat Berat\n');
end