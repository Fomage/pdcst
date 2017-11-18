%This plots the potential from the point of view of a Tracker. 
%There are other Trackers in [2.1,2.1],[3.3,3.9].
%There are other Yakuzas in [5.1,7.7],[8.1,2.9].


[X,Y] = meshgrid(0:0.2:10);
Z = zeros(size(X));
for i = 1:size(X)
    for j=1:size(X)
        Z(i,j) = 2/sqrt((X(i,j)-2.1)^2+(Y(i,j)-2.1)^2);
        Z(i,j) = Z(i,j) + 2/sqrt((X(i,j)-3.3)^2+(Y(i,j)-3.9)^2);
        Z(i,j) = Z(i,j) - 1/((X(i,j)-5.1)^2+(Y(i,j)-7.7)^2);
        Z(i,j) = Z(i,j) - 3/sqrt((X(i,j)-5.1)^2+(Y(i,j)-7.7)^2);
        Z(i,j) = Z(i,j) - 1/((X(i,j)-8.1)^2+(Y(i,j)-2.9)^2);
        Z(i,j) = Z(i,j) - 3/sqrt((X(i,j)-8.1)^2+(Y(i,j)-2.9)^2);
        Z(i,j) = Z(i,j) + 1/X(i,j)^2 + 1/(X(i,j)-10)^2;
        Z(i,j) = Z(i,j) + 1/Y(i,j)^2 + 1/(Y(i,j)-10)^2; 
    end
end
surf(X,Y,Z)
set(gca,'color',[1 1 1])