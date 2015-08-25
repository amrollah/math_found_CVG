function [diff] = f_diff(X, Xi, Ni, sigma)
r = 0;
h = 0;
w = 0;
pd = 0;
for i=1:size(Xi,1)
    phi_r = norm(X - Xi(i,:));
    r = r + (guassian(phi_r, sigma) * (Ni(i,:) * (X - Xi(i,:))'));
    h = h + (guassian(phi_r, sigma) * Ni(i,:) + guassian_diff(phi_r, sigma) * (Ni(i,:) * (X - Xi(i,:))'));
    w = w + guassian(phi_r, sigma);
    pd = pd + guassian_diff(phi_r, sigma);
end
diff= (w*h - r*pd)/(w^2);
% diff = h/w;
end