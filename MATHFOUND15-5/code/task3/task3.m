clc; clear; close all;

% a = -100;
% b = 100;
% x_g = [(b-a).*rand(5,1)+ a,(b-a).*rand(5,1)+ a,(b-a).*rand(5,1)+ a]; 
% save('x_g.mat', 'x_g');
load('x_g.mat');

orig_l = .2;
thresh = 10^-8;
iter_limit = 1000;

for i=1:size(x_g,1)
    l = orig_l;
    x = x_g(i,:);
    t = cputime;
    for j=1:iter_limit
        analytic.energy(i,j) = f_func(x);
        analytic.step(i,j) = l;
        xt = x - (l*(hessian(analytic_diff(x)))\analytic_diff(x)')';
        if norm(f_func(xt) - f_func(x))< thresh
            break;
        end
        if f_func(xt) > f_func(x)
            l = .5*l;
        elseif f_func(xt) < f_func(x)
            l = 2*l;
        end
        x = xt;
    end
    e = cputime - t;
    analytic.time(i) = e;
    analytic.iter(i) = j;
    
    figure(i);
    subplot(2,2,1);
    plot(1:analytic.iter(i),analytic.energy(i,1:analytic.iter(i)));
    title('Energy, alanytic');
    xlabel('iteration');
    figure(5+i);
%     title(strcat('point ', num2str(i)));
    subplot(2,2,1);
    plot(1:analytic.iter(i),analytic.step(i,1:analytic.iter(i)));
    title('Step, analytic');
    
    l = orig_l;
    x = x_g(i,:);
    t = cputime;
    for j=1:iter_limit
        symbolic.energy(i,j) = f_func(x);
        symbolic.step(i,j) = l;
        xt = x - (l*(hessian(symb(x)))\symb(x)')';
        if norm(f_func(xt) - f_func(x))< thresh
            break;
        end
        if f_func(xt) > f_func(x)
            l = .5*l;
        elseif f_func(xt) < f_func(x)
            l = 2*l;
        end
        x = xt;
    end
    e = cputime - t;
    symbolic.time(i) = e;
    symbolic.iter(i) = j;
    
    figure(i);
    subplot(2,2,2);
    plot(1:symbolic.iter(i),symbolic.energy(i,1:symbolic.iter(i)));
    title('Energy, symbolic');
    figure(5+i);
    subplot(2,2,2);
    plot(1:symbolic.iter(i),symbolic.step(i,1:symbolic.iter(i)));
    title('Step, symbolic');
    
    
    ct = 0;
    for p=0:-2:-10
        ct = ct+1;
        h = 10^p;
        numeric.h(ct) = h;
        l = orig_l;
        x = x_g(i,:);
        t = cputime;
        for j=1:iter_limit
            numeric.energy(i,ct,j) = f_func(x);
            numeric.step(i,ct,j) = l;
            xt = x - (l*(hessian(numerical(x,h)))\numerical(x,h)')';
            if norm(f_func(xt) - f_func(x))< thresh
                break;
            end
            if f_func(xt) > f_func(x)
                l = .5*l;
            elseif f_func(xt) < f_func(x)
                l = 2*l;
            end
            x = xt;
        end
        e = cputime - t;
        numeric.time(i,ct) = e;
        numeric.iter(i,ct) = j;
    end
    
    ct=5;
    figure(i);
    subplot(2,2,3);
    plot(1:numeric.iter(i,ct),squeeze(numeric.energy(i,ct,1:numeric.iter(i,ct))));
    title('Energy, numeric');
    figure(5+i);
    subplot(2,2,3);
    plot(1:numeric.iter(i,ct),squeeze(numeric.step(i,ct,1:numeric.iter(i,ct))));
    title('Step, numeric');
    
    
    l = orig_l;
    x = x_g(i,:);
    t = cputime;
    for j=1:iter_limit
        automat.energy(i,j) = f_func(x);
        automat.step(i,j) = l;
        xt = x - (l*(hessian(automatic(x)))\automatic(x)')';
        if norm(f_func(xt) - f_func(x))< thresh
            break;
        end
        if f_func(xt) > f_func(x)
            l = .5*l;
        elseif f_func(xt) < f_func(x)
            l = 2*l;
        end
        x = xt;
    end
    e = cputime - t;
    automat.time(i) = e;
    automat.iter(i) = j;
    
    figure(i);
    subplot(2,2,4);
    plot(1:automat.iter(i),automat.energy(i,1:automat.iter(i)));
    title('Energy, automatic');
    figure(5+i);
    subplot(2,2,4);
    plot(1:automat.iter(i),automat.step(i,1:automat.iter(i)));
    title('Step, automatic');
    
end