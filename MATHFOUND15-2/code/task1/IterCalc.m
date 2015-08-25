function [N] = IterCalc(eps,s,p)
 
    N=ceil(log(1-p) / log(1-(1-eps)^s));

end