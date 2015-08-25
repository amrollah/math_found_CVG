function fs=similarity_tranform(v, p, q, alpha)
    fs=zeros(1,size(p,1));
    [p_star, q_star]=pq_star(p,q,v,alpha);
    vps=v - p_star;
    mu=0;
    for i=1:size(p,2)
       wi = calc_weights(p(:,i),v,alpha);
       pi_hat=p(:,i)-p_star;
       mu = mu + wi * (pi_hat'*pi_hat);
    end
    
    for i=1:size(p,2)
       wi = calc_weights(p(:,i),v,alpha);
       pi_hat=p(:,i) - p_star;
       qi_hat=q(:,i) - q_star;
       Ai=wi*M_operator(pi_hat)*M_operator(vps)';
       fs=fs+qi_hat'*(1/mu)*Ai;
    end
    fs=fs + q_star';
end