function plot_circle(x,y,r, mode)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp, mode);
end