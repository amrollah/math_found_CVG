function c = conv(z,t, ObjLowerBound, ObjUpperBound, ThetaLowerBound, ThetaUpperbound)
c = max(ObjUpperBound*t+ThetaLowerBound*z-ObjUpperBound*ThetaLowerBound, ObjLowerBound*t+ThetaUpperbound*z-ObjLowerBound*ThetaUpperbound);
end