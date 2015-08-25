function fa=affine_tranform(v, p, q, alpha)  
    [p_star, q_star]=pq_star(p,q,v,alpha);
    fs_t = zeros(2,2);
    for i=1:size(p,2)
            pi_hat = p(:,i) - p_star;
            wi= calc_weights(p(:,i),v,alpha);
            fs_t = fs_t + wi*(pi_hat)'*(pi_hat);
    end
    sec_t = zeros(2,2);
    for j=1:size(p,2)
        pj_hat = p(:, j) - p_star;
        qj_hat=q(:,j)-q_star;
        wj = calc_weights(p(:,j),v,alpha); 
        sec_t= sec_t + wj*pj_hat'*qj_hat;
    end
    fa = ((v-p_star)'/fs_t)*sec_t + q_star';
end