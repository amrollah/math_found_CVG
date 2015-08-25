function d = analytic_diff(x)
%f = x1^2*sin(x2) + x3/x1;
dx1 = 2*x(1)*sin(x(2)) - x(3)/(x(1)^2);
dx2 = x(1)^2*cos(x(2));
dx3 = 1/x(1);
d = [dx1, dx2, dx3];
end