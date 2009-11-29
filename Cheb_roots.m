%% Roots of Chebyshev polynomial of $n$-th degree over $[a;b]$.
function pts = Cheb_roots(a, b, n)
  m = 1:n;
  pts = (a + b) / 2 + (b - a) / 2 * cos(pi * (2 * m - 1) / (2 * n));
endfunction
