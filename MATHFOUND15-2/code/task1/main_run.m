clc;clear;close all

outRatios=[0.05 0.2 0.3 0.7];
out_thresh = 0.1; % threshold for RANSAC outliers
r = 5; % radius of circle
c = [0,0]; %center of circle
N=100; %total number of data points
s=3; % number of sample points for ransac algorithm (3 for circle)
p = .99; % guarantee probability

K=length(outRatios);
iter = 1000; %number of iteration for whole ransac program (1000)
numIn = zeros(1,iter);

for i=1:K
    %generate data
    data=generateData(r, c, outRatios(i), N, out_thresh);
    RanIter=IterCalc(outRatios(i),s,p);
    %run ransac
    [r_est,c_est, inliers, outliers]=ransac(data, RanIter, out_thresh);
    %[r_est,c_est, inliers, outliers]=exhaustive(data, out_thresh);
    
    % plot the results
    subplot(2,K,K+i) 
    plot_circle(c_est(1),c_est(2),r_est,'b');
    hold on
    plot_circle(c(1),c(2),r,'-k');
    
    plot(inliers(1,:),inliers(2,:),'.g');
    plot(outliers(1,:),outliers(2,:),'.r');
    axis([-10 10 -10 10]);
    title(['r = ', num2str(outRatios(i)*100),'%, Inliers found= ', num2str(size(inliers,2))]);
  

    %calc and plot the histograms
    for k=1:iter
       data=generateData(r, c, outRatios(i), N, out_thresh);
       [~,~, inliers, ~]=ransac(data, RanIter, out_thresh);
       numIn(1,k) = size(inliers,2);      
    end
    
    subplot(2,K,i) 
    hist(numIn,1:99);
    xlabel('No of detected inliers');
    ylabel('No of experiments');

end
