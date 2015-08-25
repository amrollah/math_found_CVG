
close all; clear; clc;

file_names = {'Balzer', 'Dart', 'FPO', 'Matern'};

file_ct = 10;
figure(1);
for fl = 1:size(file_names,2)
periodogramMatrix = zeros(400);

for c=1:file_ct
pt = dlmread(strcat('..\..\Data\', file_names{fl}, '\', num2str(c) ,'.txt'));
n = size(pt,1);
val = 1/n;
imageMatrix = zeros(400);

for i=1:n
    s_pt = floor(400*pt(i,:));
    if s_pt(1) > 0 && s_pt(2) > 0
        imageMatrix(s_pt(1), s_pt(2)) = val;
    end
end
ft_img = fftshift(fft2(imageMatrix));
 periodogramMatrix = periodogramMatrix + abs(ft_img);
end
 subplot(2,2,fl);
 imshow((periodogramMatrix./file_ct) * 8);
 title(file_names(fl));
end