% clear; clc; close all;
% 
% img_path = './train/';
% class_num = 30;
% img_per_class = 60;
% img_num = class_num .* img_per_class;
% %Set the feature dim to be the number of SIFT/SURF features returned.
% feat_dim = 128;
% 
% 
% folder_dir = dir(img_path);
% feat_train = zeros(img_num,feat_dim);
% label_train = zeros(img_num,1);
% 
% allFeatures = zeros(1,feat_dim);
% 
% %For each label
% for i = 1:length(folder_dir)-2
%     
%     img_dir = dir([img_path,folder_dir(i+2).name,'/*.JPG']);
%     if isempty(img_dir)
%         img_dir = dir([img_path,folder_dir(i+2).name,'/*.BMP']);
%     end
%     
%     label_train((i-1)*img_per_class+1:i*img_per_class) = i;
%     
%     %For each image of the same label.
%     for j = 1:length(img_dir)       
%         img = imread([img_path,folder_dir(i+2).name,'/',img_dir(j).name]);
%         
%         gray = rgb2gray(img);
%         points = detectSURFFeatures(gray);
%     	[features, valid_points] = extractFeatures(gray, points,'SURFsize',128);
%         allFeatures = [allFeatures;features];
%         disp(j);
%         
%     end
%     
% end
% 
% allFeatures = allFeatures(2:end,:);
% 
% save('featurespace128.mat','allFeatures');



% -------------------For Clustering Feature Space-------------------

load('featurespace128.mat', 'allFeatures');


wordCount = 180;

[idicies, Centers] = kmeans(allFeatures, wordCount);

save('clusterCenters180-128','Centers');








