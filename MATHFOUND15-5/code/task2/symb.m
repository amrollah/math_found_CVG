function d = symb(x)
x1 = sym('x1','real');
x2 = sym('x2','real');
x3 = sym('x3','real');
f = x1^2*sin(x2) + x3/x1;
dx1 = diff(f,'x1');
dx2 = diff(f,'x2');
dx3 = diff(f,'x3');
fx1 = matlabFunction(dx1);
fx2 = matlabFunction(dx2);
fx3 = matlabFunction(dx3);

dx1 = fx1(x(1),x(2),x(3));
dx2 = fx2(x(1),x(2));
dx3 = fx3(x(1));

d = [dx1, dx2, dx3];
end