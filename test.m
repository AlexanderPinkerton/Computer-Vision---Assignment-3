% Please do NOT change any thing in this script.
% I will use my own script for grading. 
% It will be exactly the same as this one but with different testing image.
clear; clc; close all;

img_path = './val/';
class_num = 30;
img_per_class = 20;
img_num = class_num .* img_per_class;
feat_dim = size(feature_extraction(imread('./val/Balloon/329060.JPG')),2);

folder_dir = dir(img_path);
feat = zeros(img_num,feat_dim);
label = zeros(img_num,1);

disp('Generating validation set');

%Create table for word/document frequency for tf-idf
wordFreqTable = zeros(feat_dim, 1);


for i = 1:length(folder_dir)-2
    
    img_dir = dir([img_path,folder_dir(i+2).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+2).name,'/*.BMP']);
    end
    
    label((i-1)*img_per_class+1:i*img_per_class) = i;
    
    for j = 1:length(img_dir)     
        img = imread([img_path,folder_dir(i+2).name,'/',img_dir(j).name]);
        feat((i-1)*img_per_class+j,:) = feature_extraction(img);
        
        %Generate the tf-idf table
        for word=1:feat_dim
            %Accumulate word in tf-idf table
            if feat((i-1)*img_per_class+j,word) ~= 0
                wordFreqTable(word,1) = wordFreqTable(word,1) + 1;
            end
        end
        
    end
    
end

%Apply tf-idf weighting
disp('Applying tf-idf');
for imgIndex=1:size(feat,1)
    tf = feat(imgIndex,:) ./ sum(feat(imgIndex,:));
    idf = log(wordFreqTable' .^-1 * img_num);
    tfidf = tf .* idf;
    feat(imgIndex,:) = tfidf;
end


predict_label = your_kNN(feat);

accuracy = sum(predict_label==label) ./ img_num;
display(accuracy);