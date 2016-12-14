function vidInfo = labelData( vidInfo, path, opt )
%label the data
%   

%get the name of the video
vidFile = dir(fullfile(path.video, '*.MOV'));
vidName = [vidFile.name];
vidName = strsplit(vidName, '_');
vidName = vidName(2:2:end);
vidInfo.vidName = vidName;

%get the labels
labels = importdata(fullfile(path.video, 'labels.xlsx'));
numSamples = numel(labels.textdata);
for i=1:numSamples
    
end



end

