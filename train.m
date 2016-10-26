% You can change anything you want in this script.
% It is provided just for your convenience.
clear; clc; close all;

img_path = './train/';
class_num = 30;
img_per_class = 60;
img_num = class_num .* img_per_class;
%Set the feature dim to be the number of SIFT/SURF features returned.
feat_dim = size(feature_extraction(imread('./val/Balloon/329060.JPG')),2);


folder_dir = dir(img_path);
feat_train = zeros(img_num,feat_dim);
label_train = zeros(img_num,1);

%Create table for word/document frequency for tf-idf
wordFreqTable = zeros(feat_dim, 1);

useTDIF = false;

%For each label
disp('Generating Training Data');
for i = 1:length(folder_dir)-2
    
    img_dir = dir([img_path,folder_dir(i+2).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+2).name,'/*.BMP']);
    end
    
    label_train((i-1)*img_per_class+1:i*img_per_class) = i;
    
    %For each image of the same label.
    for j = 1:length(img_dir)
        img = imread([img_path,folder_dir(i+2).name,'/',img_dir(j).name]);
        feat_train((i-1)*img_per_class+j,:) = feature_extraction(img);
        
        %Generate the tf-idf table
        for word=1:feat_dim
            %Accumulate word in tf-idf table if it is in image
            if feat_train((i-1)*img_per_class+j,word) ~= 0
                wordFreqTable(word,1) = wordFreqTable(word,1) + 1;
            end
        end
        
    end
    
end

if useTDIF
    %Apply tf-idf weighting
    disp('Applying tf-idf');
    for imgIndex=1:size(feat_train,1)
        tf = feat_train(imgIndex,:) ./ sum(feat_train(imgIndex,:));
        idf = log(wordFreqTable' .^-1 * img_num);
        tfidf = tf .* idf;
        
        %     disp('normal');
        %     disp(feat_train(imgIndex,1:10));
        %     disp('tf');
        %     disp(tf(1,1:10));
        %     disp('word Freq Table');
        %     disp(wordFreqTable(1:10,1)');
        %     disp('idf');
        %     disp(idf(1,1:10));
        %     disp('tf-idf');
        %     disp(tfidf(1,1:10));
        
        feat_train(imgIndex,:) = tfidf;
    end
end


% disp(wordFreqTable);

save('model.mat','feat_train','label_train');

disp('done');