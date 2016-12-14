 for i=1:vidInfo.vidNum
%    for i=7
      %vid(6) does not satisfy the requirement, consider useing window to
      %filter the index
    %data = vidInfo.vid(i).sumDer;
    data = [vidInfo.vid(i).sumDer];
    %data = data - min(data);
    %data = data - mean(data);
    data = [0.2:0.2:0.2*length(data);data]';
    %idx = kmeans(data,2,'Distance','cityBlock');
%     index = kmeans(data,2);
%     window = [1/3 1/3 1/3];
%     idx = conv(window,index);
%     idx = round(idx(4:end));
%     
    idx = kmeans(data, 2);
    plot(data(idx==1,1),data(idx==1,2),'ro');
    hold on
    plot(data(idx==2,1),data(idx==2,2),'bo');
    %plot(data(idx==3,1),data(idx==3,2),'go');
    title(['video',num2str(i)])
    hold off
    pause(1)
end
% for i=1:vidInfo.vidNum
% %for i=1:6
%     data = vidInfo.vid(i).sumDer;
%     data = [1:length(data);data]';
%     idx = kmeans(data(:,2),2);
%     plot(data(idx==1,1),data(idx==1,2),'r.');
%     hold on
%     plot(data(idx==2,1),data(idx==2,2),'b.');
%     %plot(data(idx==3,1),data(idx==3,2),'g.');
%     hold off
%     title(['video',num2str(i)])
%     pause(2)
% end