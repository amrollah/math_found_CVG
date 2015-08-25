function phi_d = guassian_diff(r, sigma)
phi_d = (-2*r*exp(-(r^2)/(sigma^2)))/(sigma^2);
end