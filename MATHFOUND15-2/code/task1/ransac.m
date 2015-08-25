function [r,c,inliers, outliers] = ransac(data, N,  thresh)

bestErr = Inf;
maxNumIn = 0; % initialize maximum number of inliers
    
rng('shuffle', 'twister');
for i =1:N

    % Select 3 random points
    randInd = randperm(size(data,2),3);   
    %estimate r and c
    [c, r] = calc_circle(data(:,randInd(1)), data(:,randInd(2)), data(:,randInd(3)));
    
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


