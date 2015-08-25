function data=generateData(r, c, outRatio, N, thresh)

numOut=N*outRatio;
numIn=N - numOut;

inliers=zeros(2,numIn);
outliers=zeros(2,numOut);
 
% max and min of x
xmax = c(1)+r;
xmin = c(1)-r;
sign = [-1,1];
    
rng('shuffle', 'twister');
sign_list = zeros(1,numIn);
for i=1:numIn
    sign_list(i) = sign(randperm(2,1));
end

%generating inliers (including the uniform noise)
inliers(1,:)=rand(1, numIn)*(xmax-xmin)+xmin -0.1 + (0.2)*rand(1,numIn);
inliers(2,:)=sign_list.*sqrt(r^2 - (inliers(1,:)-c(1)).^2) + c(2) -0.1 + (0.2)*rand(1,numIn);

%generating outliers
while(numOut>0)
ranpt = rand(2,1)*(20) - 10;
dist = abs(sqrt((ranpt(1)-c(1))^2 + (ranpt(2)-c(2))^2) - r);
if (dist < thresh)
    continue;
end
outliers(:,numOut) = ranpt;
numOut = numOut-1;
end

%concatenate the data
data = [inliers, outliers];
end
