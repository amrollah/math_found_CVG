function h = hessian(d)
h = [d(1)*d(1), d(1)*d(2), d(1)*d(3);
     d(2)*d(1), d(2)*d(2), d(2)*d(3);
     d(3)*d(1), d(3)*d(2), d(3)*d(3)];
end