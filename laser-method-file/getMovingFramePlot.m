function getMovingFramePlot(vidInfo,path,opt)
%plot start point and end point of useful frames
%   plot start point at 'ave' method
%   plot end point at 'sumDer' method
% make sure that the sumDer and ave method are both implemented
display('Plotting...')
startMethod = 'ave';
endMethod = 'sumDer';
set(gcf, 'visible','off');
usefulFrame = zeros(vidInfo.vidNum,1);
for i = 1:vidInfo.vidNum
    name = ['video', num2str(i)];
    subplot(1,2,1)
    vector = vidInfo.vid(i).(startMethod);
    plot(1:length(vector), vector, 'bo');
    hold on;
    x = vidInfo.vid(i).startFrame;
    y = vector(vidInfo.vid(i).startFrame);
    plot(x, y,'r*');
    text(x,y,[num2str(x),'th frame','\rightarrow'],'HorizontalAlignment','right');
    hold off;
    ylabel('Average')
    xlabel('frame')
    title(name)
   
    
    subplot(1,2,2)
    vector = vidInfo.vid(i).(endMethod);
    plot(1:length(vector), vector, 'gs');
    hold on;
    x = vidInfo.vid(i).endFrame;
    y = vector(vidInfo.vid(i).endFrame);
    plot(x, y,'m*');
    text(x,y,[num2str(x),'th frame','\rightarrow'],'HorizontalAlignment','right');
    hold off;
    xlabel('frame')
    ylabel('Sum of First Derivative')
    title(name)
    %save the image
    p = fullfile(path.processed, 'getMvFramePlot');
  
    if ~exist(p,'file')
        mkdir(p)
    end
    saveas(gcf, fullfile(p,name),'png');
    usefulFrame(i) = vidInfo.vid(i).endFrame - vidInfo.vid(i).startFrame;
end
close(gcf)
plot(1:vidInfo.vidNum, usefulFrame,'b.');
saveas(gcf, fullfile(p,'usefulFrameDistrib'),'png');


display('Plotting Done!');
end

