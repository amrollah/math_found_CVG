function img_deform = deform(img, p, q, type, alpha)
img_deform = zeros(size(img));   
for x=1:size(img,1)
    for y =1:size(img,2)
        v=[x y]';
        if strcmp(type, 'affine')
            dv = affine_tranform(v, p, q, alpha);
        elseif strcmp(type,'similarity')
            dv = similarity_tranform(v, p, q, alpha);
        elseif strcmp(type, 'rigid')
            dv = rigid_tranform(v, p, q, alpha);
        end
        dv=round(dv);
        
        if(dv(1) >= 1 && dv(2) >= 1 && dv(1) <= size(img,1) && dv(2) <= size(img,2) )
            img_deform(dv(1),dv(2),:)=img(v(1),v(2),:);
        end
    end
end    
end