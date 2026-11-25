% L0125105_Lazuardi Akbar Imani
function [itp, tabel] = NDD_L0125105_LazuardiAkbarImani(xy, tampilkan_tabel)
  if nargin < 2
    tampilkan_tabel = true;
  end

  x = xy(:, 1);
  y = xy(:, 2);
  n = length(x);

  tabel = zeros(n, n);
  tabel(:, 1) = y;
  for j = 2:n
    for i = j:n
      tabel(i, j) = (tabel(i, j-1) - tabel(i-1, j-1)) / (x(i) - x(i-(j-1)));
    end
  end

  if tampilkan_tabel
    fprintf('\nTabel Newton Divided-Difference (Orde-%d):\n', n - 1);
    fprintf('%-8s %-14s', 't', 'f[t]');
    for j = 2:n
      fprintf(' %-14s', sprintf('Orde %d', j - 1));
    end
    fprintf('\n%s\n', repmat('-', 1, 8 + 15 * n));

    for i = 1:n
      fprintf('%-8.2f ', x(i));
      for j = 1:n
        if j <= i
          fprintf('%-14.6g ', tabel(i, j));
        else
          fprintf('%-14s ', '-');
        end
      end
      fprintf('\n');
    end
    fprintf('\n');
  end

  itp_str = sprintf('(%.15g)', tabel(1, 1));
  temp = '';
  for i = 1:(n - 1)
    temp = strcat(temp, sprintf('.*(x-(%.15g))', x(i)));
    itp_str = strcat(itp_str, '+', sprintf('(%.15g)', tabel(i+1, i+1)), temp);
  end

  itp = str2func(strcat('@(x)', itp_str));
end