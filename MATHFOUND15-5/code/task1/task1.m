clc; clear; close all;
%f = x1^2*sin(x2) + x3/x1

% a = -10;
% b = 10;
% x_n = [(b-a).*rand(100,1)+ a,(b-a).*rand(100,1)+ a,(b-a).*rand(100,1)+ a]; 
% save('x_n');
load('x_n.mat');

%% derivetives
for i=1:size(x_n,1)
    x = x_n(i,:);
    % analyticaly
    d_analytic(i,:) = analytic_diff(x);

    % symbolic
    d_symbolic(i,:) = symb(x);

    % numerical
    ct = 0;
    for p=0:-1:-10
        ct = ct+1;
        h = 10^p;
        d_numeric{i,ct} = numerical(x,h);
        numeric_error{i,ct} = norm(numerical(x,h)-d_analytic(i,:));
    end

    % automatic differentiation
    d_automatic(i,:) = automatic(x);
end