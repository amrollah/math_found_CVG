function c = conc(z,t, ObjLowerBound, ObjUpperBound, ThetaLowerBound, ThetaUpperbound)
c = min(ObjUpperBound*t+ThetaLowerBound*z-ObjUpperBound*ThetaLowerBound, ObjLowerBound*t+ThetaUpperbound*z-ObjLowerBound*ThetaUpperbound);
end