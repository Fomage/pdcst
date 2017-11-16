function s = score(m,p)
%score returns the score of a simulation from its measurements and
%parameters (targets' score, opposite of the trackers' score)
s=m.deliveries + (p.Max_It-m.iterations)/p.Max_It;
end

