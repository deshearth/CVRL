function formalizeVideoName( videoDir )
videoType = subfolder(videoDir);  
num = 0;
for i = 1:length(videoType)
    bucket = subfolder(fullfile(videoDir, videoType(i).name))
    for j = 1:length(bucket)
        currFolder = fullfile(videoDir,videoType(i).name,bucket(j).name);
        video = dir(fullfile(currFolder,'*.MOV')); 
        for k = 1:length(video)
            num = num + 1;
            newName = ['video',num2str(num),'_',...
                videoType(i).name,'-',bucket(j).name,'_',num2str(k),'.MOV'];
            movefile(fullfile(currFolder,video(k).name),fullfile(videoDir,newName));
        end
    end
    
end
end



%--------------------------------------
function children = subfolder(parentPath)
% ---------------------------------------
     children = dir(parentPath);
    children = children(...
        arrayfun(@(foler) foler.name(1), children)~='.');
    
end