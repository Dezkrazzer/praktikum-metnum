function [x, iter, riwayat, nfev] = biseksi(f, a, b, tol, maxit)
  % BISEKSI  Metode bagi dua. Berhenti saat lebar interval <= 2*tol.
  % riwayat = vektor titik tengah tiap iterasi; nfev = jumlah evaluasi f.
  if nargin < 5, maxit = 200; end
  fa = f(a); fb = f(b); nfev = 2;
  if fa*fb > 0, error('biseksi: f(a) dan f(b) bertanda sama'); end
  riwayat = []; iter = 0;
  while (b - a) > 2*tol && iter < maxit
    x = (a + b)/2; fx = f(x); nfev = nfev + 1; iter = iter + 1;
    riwayat(end+1) = x;
    if fa*fx <= 0
      b = x; fb = fx;
    else
      a = x; fa = fx;
    end
  end
  x = (a + b)/2;
end
