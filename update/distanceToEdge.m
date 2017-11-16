function distance = distanceToEdge(position,envSize)
%distanceToEdge returns the signed euclidian distance of position to the closest
%wall of the environment. If it is negative then the point is outside of
%the environment.
dim=length(position);
dInf=min(position-envSize(1,1:dim));
dSup=min(envSize(2,1:dim)-position);
distance=min(dInf,dSup);
end

