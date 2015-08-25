
close all; clear; clc;

file_names = {'Balzer', 'Dart', 'FPO', 'Matern'};

file_ct = 1;
d = 2;
sigma = 0.001;
r_a = sigma * .01;
r_b = sqrt(2);
dt = linspace(r_a,r_b,100);
figure(1);
for fl = 1:size(file_names,2)
pt = dlmread(strcat('..\..\Data\', file_names{fl}, '\1.txt'));
n = size(pt,1);
PCF = zeros(1,100);
pair_ind = nchoosek(1:n, 2);
pair_diff = (pt(pair_ind(:,1),:)-pt(pair_ind(:,2),:));
all_dist = sqrt(sum(pair_diff.^2, 2));
for i=1:100
   r = dt(i);
   PCF(i)=sum(guassian(r-all_dist,sigma))/(2*pi*(r^(d-1))*(n^2));
end
 
 subplot(2,2,fl);
 plot(1:100,PCF);
 title(file_names(fl));
end
