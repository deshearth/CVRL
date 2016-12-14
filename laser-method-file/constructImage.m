function constrIm = constructImage( vid, path, opt )
%compose laser lines into one image using laser position
% output would be a binary image

test = vid(74).movingFrames;
%test(test>1) = test(test>1) - min(min(test(test>1))); 
[rows, cols] = size(test);
constrIm = zeros(1088, 1920, 5);

col = 1;
im = 1;
while(1)
    if (col > cols)
        break;
    end
    
    for imcol=1:15
        if (col > cols)
        break;
        end
        tempIm = zeros(1088,1920);
        pos = test(:, col);
        pos(pos>1) = pos(pos>1) - 100 * imcol;
        linearIdx = sub2ind(size(constrIm), 1:1088, pos');
        tempIm(linearIdx) = 1;
        constrIm(:,:, im) = constrIm(:,:, im) + tempIm;
        col = col + 1;
    end
    im = im + 1;
    
  
end


 
    

end

