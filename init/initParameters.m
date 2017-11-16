function p = initParameters(p)
%initParameters sets the initial values for the potentials' parameters
% trackers parameters
p.trackerParameters.tracker=[0 2 0 0 0];
p.trackerParameters.target=[-1 -3 0 0 0];
p.trackerParameters.wall=[1 0 0 0 0];
% targets parameters
p.targetParameters.tracker=[3 0 0 0 0];
p.targetParameters.target=[0 1 0 0 0];
p.targetParameters.objective=[0 -3 0 0 0];
p.targetParameters.wall=[2 0 0 0 0];
end

