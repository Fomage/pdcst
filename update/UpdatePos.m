function [trackers,targets,objectives] = UpdatePos(trackers,targets,objectives,speed,radius,envSize)
trackers=updateTrackers(trackers,targets,speed,envSize);
targets=updateTargets(trackers,targets,objectives,speed,envSize);
objectives=updateObjectives(objectives);
[trackers,targets,objectives]=checkCollisions(trackers,targets,objectives,radius,envSize);
end
