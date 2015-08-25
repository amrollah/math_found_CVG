function d = numerical(x,h)
x1_h = x+[h,0,0];
x2_h = x+[0,h,0];
x3_h = x+[0,0,h];

dx1 = (f_func(x1_h) - f_func(x))/h;
dx2 = (f_func(x2_h) - f_func(x))/h;
dx3 = (f_func(x3_h) - f_func(x))/h;

d = [dx1,dx2,dx3];
end