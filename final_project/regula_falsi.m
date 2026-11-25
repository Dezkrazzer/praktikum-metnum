function [x, iter, riwayat, nfev] = regula_falsi(f, a, b, tol, maxit)
  % REGULA_FALSI  Metode posisi palsu. Berhenti saat |x_baru - x_lama| <= tol.
  if nargin < 5, maxit = 200; end
  fa = f(a); fb = f(b); nfev = 2;
  if fa*fb > 0, error('regula_falsi: f(a) dan f(b) bertanda sama'); end
  riwayat = []; iter = 0; x_lama = a;
  while iter < maxit
    x = b - fb*(b - a)/(fb - fa); fx = f(x); nfev = nfev + 1; iter = iter + 1;
    riwayat(end+1) = x;
    if abs(x - x_lama) <= tol || fx == 0, break; end
    if fa*fx < 0
      b = x; fb = fx;
    else
      a = x; fa = fx;
    end
    x_lama = x;
  end
end
