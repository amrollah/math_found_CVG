function [ x ] = linprog_l1(A, b, w)
% minimize ||w.*(A*x - b)||_1

[m, n] = size(A);
I = eye(m);
Z = zeros(m, n);
G = [A, I; -A, I; Z, I];
h = [b; -b; zeros(m,1)];
c = [zeros(n, 1); -w];
xt = linprog(c, G, h);
x = xt(1:n);
end
