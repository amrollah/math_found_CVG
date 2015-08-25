clear all;
close all;
clc;
addpath('./mesh_io');
addpath('./normals');

sigma = 5;
iteration_num = 4;

% [V,F,UV,C,~] = readOFF( 'bun.off' );
% N = per_vertex_normals(V,F);
    
[V,F,UV,C,N] = readOFF('cat.off');
NewV = V;

for iter=1:iteration_num
    for i=1:size(V,1)
        NewV(i,:) = NewV(i,:) - f_calc(V(i,:), NewV, N, sigma)*f_diff(V(i,:), NewV, N, sigma);
    end
end

writeOFF('cat_out6.off',NewV,F,UV,C,N);