function [p_star, q_star] = pq_star(p,q,v,alpha)    
w =calc_weights(p, v, alpha);    
W=repmat(w,2,1);
p_star=sum(W.*p,2)./ sum(w);  
q_star=sum(W.*q,2)./sum(w);
end