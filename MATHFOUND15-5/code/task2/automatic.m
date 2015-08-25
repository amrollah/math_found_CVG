function d = automatic(x)
d = [ws(x,[1,0,0]),ws(x,[0,1,0]),ws(x,[0,0,1])];
end

function wd8 = ws(w,wd)
w4 = w(1)^2;
wd4 = 2*wd(1)*w(1);

w5 = sin(w(2));
wd5 = wd(2)*cos(w(2));

w6 = w(3)/w(1);
wd6 = wd(3)/w(1) - (w(3)*wd(1))/(w(1)^2);

w7 = w4*w5;
wd7 = wd4*w5 + w4*wd5;

w8 = w6+w7;
wd8 = wd6+ wd7;
end