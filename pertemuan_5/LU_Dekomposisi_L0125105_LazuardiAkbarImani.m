% L0125105_Lazuardi Akbar Imani
function [L,U,b] = LU_Dekomposisi_L0125105_LazuardiAkbarImani(A,b)
  [n,l] = size(A);                    % Mengambil jumlah baris pada matriks A.
  L=zeros(n);
  for i = 1 : n-1,
    [pivot,k] = max(abs(A(i:n, i)));  % Mengambil nilai tertinggi pada suatu baris.
    % Menukar baris jika nilai tertinggi tidak berada dalam posisi diagonal.
    if A(k ~= 1)
        temp1 = A(i, :);
        temp2 = b(i, :);
        temp3 = L(i, :);
        A(i,:) = A(i+k-1,:);
        b(i,:) = b(i+k-1,:);
        L(i,:) = L(i+k-1,:);
        A(i+k-1,:) = temp1;
        b(i+k-1,:) = temp2;
        L(i+k-1,:) = temp3;
    end
    % Melakukan dekomposisi LU.
    for (h = i+1 : n),
        m = A(h,i)/A(i,i);
        L(h,i) = m;
        A(h,:) = A(h,:) - m*A(i,:);
    end
   end
  L=L+eye(n);     % Menambahkan matriks L dengan matriks identitas.
  U=A;
end