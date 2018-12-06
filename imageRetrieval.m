function imageRetrieval(img_name, imgdb_path, feature_path, numRetrieval, save_path, similarity)

% load features(".mat" style)
addpath(imgdb_path);
load (feature_path);
numImg = length(imgNamList);
temp = cell(1,1);
temp{[1]} = img_name;
for j = 1:numImg
    if isequal(temp,imgNamList(j))
       queryID = j;
       QueryVec = feat_norm(queryID, :);
       [n,d] = size(feat_norm);
       % the score of euclidean metric
       score_eu = zeros(n, 1);
       for loop = 1:n
            VecTemp = feat_norm(loop, :);
            score_eu(loop) = norm(QueryVec-VecTemp);
       end
       % the score of gaussian RBF
       score_ga = zeros(n,1);
       for loop = 1:n
            VecTemp = feat_norm(loop, :);
            sigma = 2;
            score_ga(loop) = exp(-QueryVec*VecTemp'/2*sigma^2);
       end
       %different similarity(euclidean metric or gaussian)
       switch similarity
           case 'euclidean'
                [~, index] = sort(score_eu);
           case 'gaussian'
                [~, index] = sort(score_ga);
       end
       rank_image_ID = index;
       I2 = uint8(zeros(100, 100, 3, numRetrieval));
       %save the name of result images into a txt
       strpath = strcat(save_path,'result_name.txt');
       fp=fopen(strpath,'w');
       for i=1:numRetrieval
            imName = imgNamList{rank_image_ID(i, 1), 1};
            fprintf(fp,'%s\r\n',imName);
            im = imread(imName);
            im = imresize(im, [100 100]);
            if (ndims(im)~=3)
                I2(:, :, 1, i) = im;
                I2(:, :, 2, i) = im;
                I2(:, :, 3, i) = im;
            else
            I2(:, :, :, i) = im;
            end
       end
       fclose(fp);
       set(0,'DefaultFigureVisible', 'off');%don't show the figure
       img = figure('color',[1,1,1]);
       montage(I2(:, :, :, (1:numRetrieval)));
       title('search result');
       
       %save the result of retrieval as a jpg
       namestr = 'result.jpg'
       savePath = strcat(save_path, namestr);
       saveas(img, savePath);
       
    end
end
end