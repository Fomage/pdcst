function p = xToP(p,x,side)
if side==1
    p.trackerParameters.tracker=[x(1:2) 0 0 0];
    p.trackerParameters.target=[x(3:4) 0 0 0];
    p.trackerParameters.wall=[x(5:6) 0 0 0];
elseif side==2
    p.targetParameters.tracker=[x(1:2) 0 0 0];
    p.targetParameters.target=[x(3:4) 0 0 0];
    p.targetParameters.objective=[x(5:6) 0 0 0];
    p.targetParameters.wall=[x(7:8) 0 0 0];
end
end

