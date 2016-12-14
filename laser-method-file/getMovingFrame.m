function vidInfo = getMovingFrame(vidInfo,path,opt,varargin)
%this function is to determine the start frame and end frame of a video
% the algorithm is get the first derivative of the vector position in each
% frame and sum up the absolute value of the first derivative. Then set a threshold 
% to determine whether the cart starts or stops moving
% feel free to change the threshold

display('Running getMovingFrame...')
target = 'posMat';
if ~strcmp(opt.fillingMethod,'None')
    target = [target,'Filled']
end   
switch opt.getMovingFrameMethod
    case 'Derivative'
        method = 'sumDer';
    case 'Average'
        method = 'ave';
    
end
for i=1:vidInfo.vidNum
    for k=1:size(vidInfo.vid(i).(target),2)
    	switch method
        	case 'sumDer'
                nonvac = find(vidInfo.vid(i).(target)(:,k)>1);
            	vidInfo.vid(i).(method)(k) = sum(abs((diff(vidInfo.vid(i).(target)(nonvac,k))))); 
            case 'Average'
            	nonvac = find(vidInfo.vid(i).(target)(:,k)>1);
            	vidInfo.vid(i).(method)(k) = mean(vidInfo.vid(i).(target)(nonvac,k));
        end
   end
   name = ['video',num2str(i)];
   %getMovingFramePlot(path.processed, name, method, vidInfo.vid(i).(method))
end    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%spring 2016
% get moving frame
% startUpThresh = 1000;
% startDownThresh = 1000;
% 
% startMethod = 'ave';
% for i=1:vidInfo.vidNum
% 	for k=1:size(vidInfo.vid(i).(target),2)-1
% 		if vidInfo.vid(i).(startMethod)(k)<startDownThresh ...
% 			&& vidInfo.vid(i).(startMethod)(k+1)>startUpThresh 
%             cur = vidInfo.vid(i).(startMethod)(k);
%             vidInfo.vid(i).startFrame = k+2;
%             break;
% 		end
% 	end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%
% fall 2016
startMethod = 'ave';
startThresh = 0.43;
for i = 1:vidInfo.vidNum
    vector = vidInfo.vid(i).(startMethod);
    vector = vector - min(vector);
    vector = vector / max(vector);
    vidInfo.vid(i).startFrame = min(find(vector < startThresh)) + 2;
end


endMethod = 'sumDer';
    
% 
 endUpThresh = 300;
 endDownThresh = 200;
 endMethod = 'sumDer';
for i=1:vidInfo.vidNum

	vector = vidInfo.vid(i).(endMethod);
    temp = vector;
    temp(1:vidInfo.vid(i).startFrame) = inf;
    downThreshPos = min(find(temp < endDownThresh));
    
    if downThreshPos
        temp(downThreshPos:end) = endDownThresh;
    end
    vidInfo.vid(i).endFrame = max(find(temp > endUpThresh)) - 1;
end
saveInfo(vidInfo,path,opt,'getMovingFrame');
display('getMovingFrame Done!')
end



% -----------------------------------------------
function getMovingFramePlot(path, name, method, vector)
% -----------------------------------------------
set(gcf,'visible','off');

vector = vector - min(vector);
plot(1:length(vector),vector,'bo');
title(name)
xlabel('frames');
ylabel(method);


path = fullfile(path,'FigureForMovingFrames',method);
if ~exist(path,'file')
    mkdir(path)
end

saveas(gcf,fullfile(path,[name,'.png']));

close(gcf);

end

