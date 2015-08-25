function data=generateData(a, b, outRatio, N, thresh)

numOut=N*outRatio;
numIn=N - numOut;

inliers=zeros(2,numIn);
outliers=zeros(2,numOut);
 
% max and min of x
xmax = (10-b)/a;
xmin = (-10-b)/a;
if(xmax > xmin)
    temp=xmax;
    xmax=xmin;
    xmin=temp;
end
    
rng('shuffle', 'twister');

%generating inliers (including the uniform noise)
inliers(1,:)=rand(1, numIn)*(xmax-xmin)+xmin + -0.1 + (0.2)*rand(1,numIn);
inliers(2,:)=a*inliers(1,:)+b + -0.1 + (0.2)*rand(1,numIn);

%generating outliers
while(numOut>0)
ranpt = rand(2,1)*(20) - 10;
dist = abs(ranpt(2) - (ranpt(1)*a + b));
if (dist < thresh)
    continue;
end
outliers(:,numOut) = ranpt;
numOut = numOut-1;
end

%concatenate the data
data = [inliers, outliers];
end
