close all; clear; clc;
load('data/ListInputPoints.mat', 'ListInputPoints');
imgL = im2double(imread('data/InputLeftImage.png'));
imgR = im2double(imread('data/InputRightImage.png'));
thresh = 3;
N = size(ListInputPoints,1);
scl = 1;

%% Initiliazation
ThetaLowerBound = [floor(-size(imgL,2)/scl),floor(-size(imgL,1)/scl)];
ThetaUpperbound = [floor(size(imgL,2)/scl),floor(size(imgL,1)/scl)];
ObjLowerBound = -N;
ObjUpperBound = 0;
oZ=zeros(1,N);
T=(ThetaLowerBound+ThetaUpperbound)/2;
d = [];
iter=1;

%% LP init
[ObjLowerBound, ObjUpperBound, ThetaOpt, nZ] = LP_lower_bound_clac(ThetaLowerBound, ThetaUpperbound, ObjLowerBound, ObjUpperBound, ListInputPoints, thresh, oZ, T);
d = [ThetaLowerBound, ThetaUpperbound, ObjLowerBound, ObjUpperBound, ThetaOpt, nZ';d];
BestObjUpper = ObjUpperBound;
BestObjLower = ObjLowerBound;
bestTheta = ThetaOpt;
iter_rec = [1,BestObjLower,BestObjUpper];

%% iteration loop
while (BestObjUpper - BestObjLower)>1 && size(d,1)>0
iter = iter+1;
inds = find(d(:,1) == min(d(:,1)));
ind = inds(1);
temp = d(ind,:);
d(ind,:) = [];
x_len = temp(3)- temp(1);
y_len = temp(4)- temp(2);
if x_len > y_len
    new_ThetaLowerBound=[ceil((temp(3)+temp(1))/2),temp(2)];
    new_ThetaUpperBound=[floor((temp(3)+temp(1))/2),temp(4)];
else
    new_ThetaLowerBound=[temp(1),ceil((temp(2)+temp(4))/2)];
    new_ThetaUpperBound=[temp(3),floor((temp(2)+temp(4))/2)];
end

[ObjLowerBound1, ObjUpperBound1, ThetaOpt1, nZ] = LP_lower_bound_clac(temp(1:2), new_ThetaUpperBound, temp(5), temp(6), ListInputPoints, thresh, temp(9:end), temp(7:8));
if new_ThetaUpperBound(1)>temp(1) || new_ThetaUpperBound(2)>temp(2)
    d = [temp(1:2), new_ThetaUpperBound, ObjLowerBound1, ObjUpperBound1, ThetaOpt1, nZ'; d];
end

if ObjUpperBound1 < BestObjUpper && ObjUpperBound1>BestObjLower
    BestObjUpper = ObjUpperBound1;
    bestTheta = ThetaOpt1;
end 
if ObjLowerBound1 > BestObjLower && ObjLowerBound1<BestObjUpper
    BestObjLower = ObjLowerBound1;
    bestTheta = ThetaOpt1;
end

[ObjLowerBound2, ObjUpperBound2, ThetaOpt2, nZ] = LP_lower_bound_clac(new_ThetaLowerBound, temp(3:4), temp(5), temp(6), ListInputPoints, thresh, temp(9:end), temp(7:8));
if temp(3)>new_ThetaLowerBound(1) || temp(4)>new_ThetaLowerBound(2)
    d = [new_ThetaLowerBound, temp(3:4), ObjLowerBound2, ObjUpperBound2, ThetaOpt2, nZ'; d];
end

if ObjUpperBound2 < BestObjUpper && ObjUpperBound2>BestObjLower
    BestObjUpper = ObjUpperBound2;
    bestTheta = ThetaOpt2;
end 
if ObjLowerBound2 > BestObjLower && ObjLowerBound2<BestObjUpper
    BestObjLower = ObjLowerBound2;
    bestTheta = ThetaOpt2;
end

iter_rec = [iter_rec;iter,BestObjLower,BestObjUpper];
%refine list and remove branches which cannot contain optimal solution
d(d(:,6) < BestObjLower,:) = [];
d(d(:,5) > BestObjUpper,:) = [];

disp(size(d,1));
end

%% Binarisation
new_zx = abs(ListInputPoints(:,1)+bestTheta(1)-ListInputPoints(:,3))<=thresh;
new_zy = abs(ListInputPoints(:,2)+bestTheta(2)-ListInputPoints(:,4))<=thresh;
new_z = new_zx .* new_zy;


%% Display
% subplot(1,2,1);
figure(1);
inliers = find(new_z>0);
outliers = find(new_z<1);
inliers_p = ListInputPoints(inliers,:);
outliers_p = ListInputPoints(outliers,:);
showMatchedFeatures(imgL,imgR,inliers_p(:,1:2),inliers_p(:,3:4),'montage','PlotOptions',{'g.','g.','g-'});
title('Point matches');
hold on;
showMatchedFeatures2(imgL,imgR,outliers_p(:,1:2),outliers_p(:,3:4),'montage','PlotOptions',{'r.','r.','r-'});
hold off;
figure(2);
plot(iter_rec(:,1),iter_rec(:,2));
hold on;
plot(iter_rec(:,1),iter_rec(:,3),'Color','red');