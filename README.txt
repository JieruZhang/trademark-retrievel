CODE_feature_extraction 是提取特征的代码包，这个需要安装matconvnet才可以运行，详见里面的readme。

CODE_image_retrieval 是商标检索代码，详见里面的readme；

DB_features 3个特征文件，每个特征文件使用的网络为（net1，vgg）（net2，image50）（net3，,image50mul14），检索时需要使用；

DB_images 是图片数据库，里面classify文件夹里面是50类图片，2500DB是总图片数（1200多张，因为每一类都有重复的），SourceGroundTruth是每一类的一张代表图片；

net_model 是三个网络，vgg是原网络，后两个是我自己训练的，50mul14效果应该最好；

result 是用来放检索结果的， 默认是把检索出来的20张（默认得到20张）相似图片排列在一个jpg里，然后把他们的名字放在txt里；现在里面是我试的时候的结果，不用删除，会自动覆盖。

注意：主要检索的代码就是CODE_image_retrieval 里面的代码，主要的数据库就是DB_images 里面的2500DB