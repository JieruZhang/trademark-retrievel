function extractCNN(path_imgDB,net_path,feature_target_path, net_type)
% version: matconvnet-1.0-beta17
% run D:/finalWork/code/matconvnet-1.0-beta17/matlab/vl_compilenn
run D:/trademark_retrieval/CODE_feature_extraction/matconvnet-1.0-beta17/matlab/vl_setupnn

addpath(path_imgDB);
imgFiles = dir(path_imgDB);
imgNamList = {imgFiles(~[imgFiles.isdir]).name};
clear imgFiles;
imgNamList = imgNamList';
numImg = length(imgNamList);
fprintf(num2str(numImg));
feat = [];
rgbImgList = {};
    if strcmp('simplenn',net_type)
        net = load(net_path) ;
        for i = 1:numImg-1
            fprintf(imgNamList{i, 1});
            fprintf(' ');
            oriImg = imread(imgNamList{i, 1}); 
            if size(oriImg, 3) == 3
                im_ = single(oriImg) ; % note: 255 range
                im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
                im_ = im_ - net.meta.normalization.averageImage ;
                res = vl_simplenn(net, im_) ;
                featVec = res(20).x;      
                featVec = featVec(:);
                feat = [feat; featVec'];
                fprintf('extract %d image\n\n', i);
            else
                im_ = single(repmat(oriImg,[1 1 3])) ; % note: 255 range
                im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
                im_ = im_ - net.meta.normalization.averageImage ;
                res = vl_simplenn(net, im_) ;
                featVec = res(20).x;    
                featVec = featVec(:);
                feat = [feat; featVec'];
                fprintf('extract %d image\n\n', i);
            end
        end
    %case 'dagnn'
    else
        net = dagnn.DagNN.loadobj(load(net_path)) ;
        for i = 1:numImg-1
            fprintf(imgNamList{i, 1});
            oriImg = imread(imgNamList{i, 1}); 
            fprintf(' ');
            if size(oriImg, 3) == 3
                im_ = single(oriImg) ; % note: 255 range
                im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
                im_ = im_ - net.meta.normalization.averageImage ;
                net.conserveMemory = 0;
                net.eval({'input', im_}) ;
                featVec = net.vars(20).value;        
                featVec = featVec(:);
                feat = [feat; featVec'];
                fprintf('extract %d image\n\n', i);
            else
                im_ = single(repmat(oriImg,[1 1 3])) ; % note: 255 range
                im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
                im_ = im_ - net.meta.normalization.averageImage ;
                net.conserveMemory = 0;
                net.eval({'input', im_}) ;      
                featVec = net.vars(20).value;        
                featVec = featVec(:);
                feat = [feat; featVec'];
                fprintf('extract %d image\n\n', i);
            end
        end
    end


feat_norm = normalize1(feat);
save(feature_target_path,'feat_norm', 'imgNamList', '-v7.3');
