function m = simulate(p)
%simulate runs the simulation with parameters p and returns the
%measurements m

% initialisation
if p.Dimension==2
    Dim='2';
else
    Dim='3';
end
[trackers,targets,objectives,neutrals]=initMat(p); % Make 1st position of agents
% first plot
if p.display
    sMat=makeSMat(trackers,targets,objectives,neutrals);
    switch Dim
       case '2'
         scatter(sMat(:,1),sMat(:,2),p.AgentSize,sMat(:,3),'filled')
       case '3'
         scatter3(sMat(:,1),sMat(:,2),sMat(:,3),p.AgentSize,sMat(:,4),'filled') 
       otherwise
            error('myApp:argChk', 'Wrong number of input Dim')
    end
    if p.saveGif
        h=figure;
        filename='test.gif';
        drawnow;
        frame=getframe(h);
        im=frame2im(frame);
        [imind,cm]=rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime',.04);
    end
end
% This codes update the position of agents and using the sample changing
% position like 'UpdatePos' function .
m.deliveries=0;
for it=1:p.Max_It
    [trackers,targets,objectives,m]=UpdatePos(trackers,targets,objectives,p,m);
    if isempty(targets)
        if p.display
            disp(['No more targets to catch. End at iteration ' num2str(it)]);
        end
        break
    end
    if p.display && mod(it,p.refreshRate)==0
        sMat=makeSMat(trackers,targets,objectives,neutrals);
        switch Dim
            case '2'
                scatter(sMat(:,1),sMat(:,2),p.AgentSize,sMat(:,3),'filled')
            case '3'
                scatter3(sMat(:,1),sMat(:,2),sMat(:,3),p.AgentSize,sMat(:,4),'filled')
        end
        disp(['Iteration :' num2str(it) ' , deliveries made:' num2str(m.deliveries)]);
        pause(0.05);
        if p.saveGif
            drawnow;
            frame=getframe(h);
            im=frame2im(frame);
            [imind,cm]=rgb2ind(im,256);
            imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',.04);
        end
    end
end
m.iterations=it;
end

