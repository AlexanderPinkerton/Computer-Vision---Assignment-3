function predict_label = your_kNN(feat)
% Output should be a fixed length vector [num of img, 1]. 
% Please do NOT change the interface.

load('model1000.mat');

K = 5;

distances = zeros(1000, 2);

for featureIdx=1:size(feat_train,1)
    %Find distances to every example feature in the model
    diff = feat - feat_train(featureIdx,:);
    distance = sqrt(diff * diff');
   
    %Store the distance to each feature and its class
    distances(featureIdx, 1) = distance;
    distances(featureIdx, 2) = label_train(featureIdx);
    
end

sortedDistances = sortrows(distances,1);
predict_label = mode(sortedDistances(K,:),2);


end