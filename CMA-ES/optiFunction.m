function s = optiFunction(p,trackerParameters,targetParameters)
p.display=false;

p=xToP(p,trackerParameters,1);
p=xToP(p,targetParameters,2);

s=score(simulate(p),p);
end

