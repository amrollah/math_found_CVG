function [ x ] = linprog_l_inf(A, b, w)
% minimize ||w.*(A*x - b)||_inf

[m, n] = size(A);
W = diag(w);
G = [W*A, ones(m,1); -W*A, ones(m,1); zeros(1,n), 1];
h = [W*b; -W*b; 0];
c = [zeros(n, 1); -1];
xt = linprog(c, G, h);
x = xt(1:n);
end