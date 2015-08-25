clc;clear;close all

outRatios=[0, 0.1, 0.5];
out_thresh = 0.1; % threshold for RANSAC outliers
a = 2; % for line formula y=a*x + b
b = 3;
N=100; %total number of data points
K=length(outRatios);

for i=1:K
    %generate data
    data=generateData(a, b, outRatios(i), N, out_thresh);
    w = ones(N,1);
    A = [data(1,:)', ones(N,1)];
    y = data(2,:)';
    
    lp_l1 = linprog_l1(A, y, w);
    lp_l_inf = linprog_l_inf(A, y, w);
    irls_l1 = IRLS_l1(A, y, w);
    
    % plot result of linear programing L1
    % plot the synethic line
    subplot(3,K,i);
    plot([-10,10], [-10*a+b, 10*a+b], '-g');
    hold on;
    title(['linear programing L1', ', outlier=', num2str(outRatios(i)*100), '%']);
    plot([-10,10], [-10*lp_l1(1)+lp_l1(2), 10*lp_l1(1)+lp_l1(2)], '-k');
    
    plot(data(1,:),data(2,:),'ob');
    axis([-10 10 -10 10]); 
    
    % plot result of linear programing L_inf
    subplot(3,K,i+K);
    plot([-10,10], [-10*a+b, 10*a+b], '-g');
    hold on;
    title(['linear programing Linf', ', outlier=', num2str(outRatios(i)*100), '%']);
    plot([-10,10], [-10*lp_l_inf(1)+lp_l_inf(2), 10*lp_l_inf(1)+lp_l_inf(2)], '-k');
    
    plot(data(1,:),data(2,:),'ob');
    axis([-10 10 -10 10]); 
    
    % plot result of IRLS L1
    subplot(3,K,i+2*K);
    plot([-10,10], [-10*a+b, 10*a+b], '-g');
    hold on;
    title(['IRLS L1', ', outlier=', num2str(outRatios(i)*100), '%']);
    plot([-10,10], [-10*irls_l1(1)+irls_l1(2), 10*irls_l1(1)+irls_l1(2)], '-k');
    
    plot(data(1,:),data(2,:),'ob');
    axis([-10 10 -10 10]); 

end
