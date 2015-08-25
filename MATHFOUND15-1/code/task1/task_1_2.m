clear all;
close all;
clc;

sigma = 0.2;
load('curve_data1.mat');
Xi = [xi;yi]';
Ni = [nix;niy]';

[Xg,Yg] = meshgrid(-2:.1:2, -2:.1:2);
f_values = zeros(size(Xg,1), size(Xg,2));
for i=1:size(Xg,1)
    for j=1:size(Xg,2)
        f_values(i,j) = f_calc([Xg(i,j), Yg(i,j)], Xi, Ni, sigma);
    end
end
figure(1);
hold on;
imagesc(-2:2, -2:2, f_values)
plot(xi,yi);
hold off;



