function vidInfo = fillingMissingPoints(vidInfo,path,opt,varargin)
% this function is to fill the missing points
%   the method I use here is using the mean value of the occupied position
%   to fill the missing points
display('Running fillingMissingPoints...')
if ~strcmp(opt.fillingMethod, 'None')
    
    for i=1:vidInfo.vidNum
        vidInfo.vid(i).posMatFilled = vidInfo.vid(i).posMat;
        for k=1:size(vidInfo.vid(i).posMat,2)
            vac = find(vidInfo.vid(i).posMat(:,k)==1);
            nonvac = find(vidInfo.vid(i).posMat(:,k)>1);
            switch(opt.fillingMethod)
                case 'Mean'
                    vidInfo.vid(i).posMatFilled(vac,k) = mean(vidInfo.vid(i).posMatFilled(nonvac,k));
                case 'None'
                    vidInfo.vid(i).posMatFilled(vac,k) = 1
            end
        
        end
    end
end
saveInfo(vidInfo,path,opt,'fillingMissingPoints');
display('fillingMissingPoints Done!')
end