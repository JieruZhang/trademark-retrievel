
img_name = '4624319.jpg';
imgdb_path = 'D:/trademark_retrieval/DB_images/2500DB/';
feature_path = 'D:\trademark_retrieval\DB_features\net3_features.mat';
save_path = 'D:\trademark_retrieval\result\';
numRetrieval = 20;
similarity = 'gaussian'
imageRetrieval(img_name, imgdb_path, feature_path, numRetrieval, save_path, similarity);