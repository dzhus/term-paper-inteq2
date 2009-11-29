function Cheb = Cheb(a, b, n, x)
  Cheb = cos((n - 1) * acos((2 * x - (b + a)) / (b - a)));
endfunction
