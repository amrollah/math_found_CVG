function [ObjLowerBound, ObjUpperBound, ThetaOpt, Z] = LP_lower_bound_clac(ThetaLowerBound, ThetaUpperbound, ObjLowerBound, ObjUpperBound, Points, thresh, Z, T)
N = size(Points,1);
c = [zeros(1,2), -ones(1,N), zeros(1,2*N)]';
A = [zeros(1,2),(Points(:,1)-Points(:,3)-thresh)',ones(1,N),zeros(1,N);
     zeros(1,2),(-Points(:,1)+Points(:,3)-thresh)',-ones(1,N),zeros(1,N);
     zeros(1,2),(Points(:,2)-Points(:,4)-thresh)',zeros(1,N),ones(1,N);
     zeros(1,2),(-Points(:,2)+Points(:,4)-thresh)',zeros(1,N),-ones(1,N)];
b = zeros(4,1);
lb = [ThetaLowerBound, zeros(1,N), conc(Z, T(1), ObjLowerBound, ObjUpperBound,ThetaLowerBound(1), ThetaUpperbound(1)), conc(Z, T(2), ObjLowerBound, ObjUpperBound,ThetaLowerBound(2), ThetaUpperbound(2))];
ub = [ThetaUpperbound, ones(1,N), conv(Z, T(1), ObjLowerBound, ObjUpperBound,ThetaLowerBound(1), ThetaUpperbound(1)), conv(Z, T(2), ObjLowerBound, ObjUpperBound,ThetaLowerBound(2), ThetaUpperbound(2))];

options=optimset('Display', 'off');
[x,fval,exit_flag,output] = linprog(c,A,b,[],[],lb,ub,[],options);
ThetaOpt = x(1:2)';
Z = x(3:N+2);
if exit_flag>=0
ObjLowerBound = fval;

Test_T = floor(ThetaLowerBound+ThetaUpperbound)/2;
new_zx = abs(Points(:,1)+Test_T(1)-Points(:,3))<=thresh;
new_zy = abs(Points(:,2)+Test_T(2)-Points(:,4))<=thresh;
new_z = new_zx .* new_zy;
ObjUpperBound = sum(new_z);
else
    ObjLowerBound = -Inf;
    ObjUpperBound = -Inf;
end
end
