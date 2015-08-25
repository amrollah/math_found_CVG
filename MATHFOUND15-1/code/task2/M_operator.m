function S = M_operator(M)
    S = [M';M(2,1),-M(1,1)];
end