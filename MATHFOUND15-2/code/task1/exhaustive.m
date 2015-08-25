function [r,c,inliers, outliers] = exhaustive(data, thresh)

bestErr = Inf;
maxNumIn = 0; %maximum number of inliers

idx = 1:size(data, 2);
all_combs = nchoosek(idx,3);

for i =1:size(all_combs,1)

    s_ind = all_combs(i,:);    
    %estimate r and c
    [c, r] = calc_circle(data(:,s_ind(1)), data(:,s_ind(2)), data(:,s_ind(3)));
    
    dist = abs(sqrt((data(1,:)-c(1)).^2 + (data(2,:)-c(2)).^2) - r);
    % Indices of inliers
    inInd = find(dist < thresh);
    %number of inliers
    NumIn = length(inInd);
    
    if NumIn > 0
        err = sum( dist(inInd)) / NumIn;
    else
        err = Inf;
    end  
    
    if ((NumIn > maxNumIn) || (NumIn == maxNumIn && err < bestErr))
        maxNumIn = NumIn;
        bestErr = err;
        bestCircle = {r, c};
    end
     
end

r=bestCircle{1};
c=bestCircle{2};

dist = abs(sqrt((data(1,:)-c(1)).^2 + (data(2,:)-c(2)).^2) - r);
inInd = find(dist < thresh);

inliers = data(:, inInd);
outliers = data(:, setdiff((1:size(data,2)), inInd));

end


