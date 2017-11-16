function pot = basicPot(p,x,y)
%y is fixed
len = length(p);
degree = floor((len+1)/2);
pot = 0;
if x~=y
    for i = 1:len
       pot=pot + p(i)*(norm(x-y)^(i-degree));
    end
end
end