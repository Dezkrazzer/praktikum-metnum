# L0125105_Lazuardi Akbar Imani

fprintf('L0125105_Lazuardi Akbar Imani\n\n');
fprintf('======== [ Bantuan Layanan IndiGO ]========\n');
fprintf('1. Info Tagihan\n');
fprintf('2. Lapor Gangguan Jaringan\n');
fprintf('3. Hubungi Customer Service\n');

pilihan = input('Masukkan pilihan (1/2/3): ');

switch (pilihan)
    case 1
        id_pelanggan = input('Masukkan ID Pelanggan: ');
        fprintf('\nSisa tagihan untuk ID %g adalah Rp250.000\n', id_pelanggan);
        disp('Segera lakukan pembayaran untuk menghindari denda.');
    case 2
        fprintf('\nSistem kami mendeteksi adanya perbaikan di area Anda.\n');
        disp('Estimasi perbaikan selesai dalam 2 jam. Mohon maaf atas ketidaknyamanannya.');
    case 3
        fprintf('\nMohon tunggu sebentar, kamu akan segera dihubungkan dengan agen kami...');
    otherwise
        fprintf('\nPilihan tidak valid.\n');
end