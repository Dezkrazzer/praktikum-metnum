function [x, iter, riwayat, nfev] = itp(f, a, b, tol, k1, k2, n0)
  % ITP  Metode Interpolate-Truncate-Project (Oliveira & Takahashi, 2021).
  % Berhenti saat lebar interval <= 2*tol (dijamin paling banyak n_max iterasi).
  % Parameter bawaan: k1 = 0.2/(b-a), k2 = 2, n0 = 1.
  if nargin < 5 || isempty(k1), k1 = 0.2/(b - a); end
  if nargin < 6 || isempty(k2), k2 = 2; end
  if nargin < 7 || isempty(n0), n0 = 1; end
  ya = f(a); yb = f(b); nfev = 2;
  if ya*yb > 0, error('itp: f(a) dan f(b) bertanda sama'); end
  s = 1;
  if ya > 0          % samakan arah: buat ya < 0 < yb
    s = -1; ya = -ya; yb = -yb;
  end
  n_half = ceil(log2((b - a)/(2*tol)));
  n_max  = n_half + n0;
  riwayat = []; iter = 0;
  while (b - a) > 2*tol
    x_half = (a + b)/2;
    r      = tol*2^(n_max - iter) - (b - a)/2;      % jari-jari proyeksi
    delta  = k1*(b - a)^k2;                          % besar pemotongan
    % 1) Interpolate: titik regula falsi
    x_f = (yb*a - ya*b)/(yb - ya);
    % 2) Truncate: geser x_f ke arah titik tengah sejauh delta
    sigma = sign(x_half - x_f);
    if sigma == 0, sigma = 1; end
    if delta <= abs(x_half - x_f)
      x_t = x_f + sigma*delta;
    else
      x_t = x_half;
    end
    % 3) Project: batasi jaraknya dari titik tengah maksimal r
    if abs(x_t - x_half) <= r
      x_itp = x_t;
    else
      x_itp = x_half - sigma*r;
    end
    % perbarui interval
    y = s*f(x_itp); nfev = nfev + 1; iter = iter + 1;
    riwayat(end+1) = x_itp;
    if y > 0
      b = x_itp; yb = y;
    elseif y < 0
      a = x_itp; ya = y;
    else
      a = x_itp; b = x_itp;
    end
  end
  x = (a + b)/2;
end
