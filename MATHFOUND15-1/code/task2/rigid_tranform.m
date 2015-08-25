function [fr] = rigid_tranform(v, p, q, alpha)
    [p_star, q_star]=pq_star(p,q,v,alpha);
    vps= v - p_star;
    fvS = zeros(1,2);
    for i=1:size(p,2)
       wi = calc_weights(p(:,i),v,alpha);
       pi_hat = p(:,i) - p_star;
       qi_hat = q(:,i) - q_star;
       
       Ai=wi*M_operator(pi_hat)*M_operator(vps)';
       fvS = fvS + qi_hat'*Ai;        
    end
    
    fr = norm(vps)*fvS/norm(fvS) + q_star';

end
