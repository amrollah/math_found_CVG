function [r] = f_calc(X, Xi, Ni, sigma)
r = 0;
w = 0;
for i=1:size(Xi,1)
    r = r + (guassian(norm(X-Xi(i,:)), sigma) * (Ni(i,:) * (X - Xi(i,:))'));
    w = w + guassian(norm(X-Xi(i,:)), sigma);
end
r= r/w;
end