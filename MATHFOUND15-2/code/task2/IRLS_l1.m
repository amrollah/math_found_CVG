function [ lp_l1 ] = IRLS_l1(A, b, w)
% minimize ||w.*(A*x - b)||_1
h=5;
eps = 0.01;
last_a = Inf;
last_b = Inf;
lp_l1 = linprog_l1(A, b, w);
while (abs(lp_l1(1)-last_a)>eps || abs(lp_l1(2)-last_b)>eps)
    dist = abs(b - (A(:,1)*lp_l1(1) + lp_l1(2)));
    w = exp(-(dist(:)./h).^2);
    last_a = lp_l1(1);
    last_b = lp_l1(2);
    lp_l1 = linprog_l1(A, b, w);
end
end
