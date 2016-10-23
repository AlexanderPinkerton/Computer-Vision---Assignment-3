function predict_label = your_kNN(feat)
% Output should be a fixed length vector [num of img, 1].
% Please do NOT change the interface.

load('model180.mat');

K = 8;

distances = zeros(1000, 2);

predict_label = zeros(size(feat,1),1);

%TODO: Process all validation/test set and store labels into single vector.
%of 600x1
for testImgFeat=1:size(feat,1)
    %Find distances to every example feature in the model
    for featureIdx=1:size(feat_train,1)
        diff = feat(testImgFeat,:) - feat_train(featureIdx,:);
        distance = sqrt(diff * diff');
        
        %Store the distance to each feature and its class
        distances(featureIdx, 1) = distance;
        distances(featureIdx, 2) = label_train(featureIdx);   
    end
    
    sortedDistances = sortrows(distances,1);
    disp('--Closest K--');
    disp(sortedDistances(1:K,2));
    predict_label(testImgFeat) = mode(sortedDistances(1:K,2),1);
    disp(predict_label(testImgFeat));
    
end

    

end