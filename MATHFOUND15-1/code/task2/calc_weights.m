function w = calc_weights(p, v, alpha)
    w = 1./(sqrt(sum((p-repmat(v,1,size(p,2))).^2,1)).^(2*alpha));
end
