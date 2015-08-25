function g = guassian(x, sigma)
g = exp(-(x.^2)./(sigma^2))./(sqrt(pi)*sigma);
end