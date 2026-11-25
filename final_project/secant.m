function [x, iter, riwayat, nfev] = secant(f, x0, x1, tol, maxit)
  % SECANT  Metode secant (terbuka). Berhenti saat |x_(k+1) - x_k| <= tol.
  if nargin < 5, maxit = 200; end
  f0 = f(x0); f1 = f(x1); nfev = 2;
  riwayat = []; iter = 0; x = x1;
  while iter < maxit
    if f1 == f0, break; end
    x = x1 - f1*(x1 - x0)/(f1 - f0); iter = iter + 1;
    riwayat(end+1) = x;
    if abs(x - x1) <= tol, break; end
    x0 = x1; f0 = f1; x1 = x; f1 = f(x1); nfev = nfev + 1;
  end
end
