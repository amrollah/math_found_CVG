clc;clear;close all

select_points = true;

img1 = im2double(imread('ginger.png'));
alpha = 1;

% get point correspondences
if (select_points)
    [p, q] = get_points(img1);
	save('corres_points.mat', 'p', 'q', '-mat');
else
	load('-mat', 'corres_points.mat', 'p', 'q');
end

% show clicked points
figure(1), imshow(img1, []); hold on, plot(p(1,:), p(2,:), '.b', 'MarkerSize',20);  
figure(2), imshow(img1, []); hold on, plot(q(1,:), q(2,:), '.b', 'MarkerSize',20);
  
subplot(2,2,1)
imshow(img1, []); hold on, plot(p(1,:), p(2,:), '.b', 'MarkerSize',20);  
title('Original')

subplot(2,2,2)
aff_deform_img = deform(img1, p, q, 'affine', alpha); 
imshow(aff_deform_img, []); 
title('Affine deformation')

% 
% subplot(2,2,3)
% sim_deform_img = deform(img1, p, q, 'similarity', alpha); 
% imshow(sim_deform_img, []);  
% title('Similarity deformation')
% 
% subplot(2,2,4)
% rigid_deform_img = deform(img1, p, q, 'rigid', alpha); 
% imshow(rigid_deform_img, []);
% title('Rigid deformation')
% 
