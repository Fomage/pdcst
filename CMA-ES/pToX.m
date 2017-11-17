function x = pToX(p,side)
if side==1
    x=[p.trackerParameters.tracker(1:2) p.trackerParameters.target(1:2) p.trackerParameters.wall(1:2)];
elseif side==2
    x=[p.targetParameters.tracker(1:2) p.targetParameters.target(1:2) p.targetParameters.objective(1:2) p.targetParameters.wall(1:2)];
end
end

