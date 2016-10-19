function feat = feature_extraction(img)
% Output should be a fixed length vector [1*dimension] for a single image.
% Please do NOT change the interface.

load('clusterCenters1000.mat', 'Centers');

feat = zeros(1,size(Centers,1));

% disp(size(feat));

gray = rgb2gray(img);
points = detectSURFFeatures(gray);
[features, valid_points] = extractFeatures(gray, points);

min = Inf;
closestCenterIdx = 0;

%For each feature, find which cluster it belongs to and accumulate
for i=1:size(features,1)
    for j=1:size(Centers,1)
        
        %Find distance from feature to word
        diff = features(i) - Centers(j);
        dist = sqrt(diff * diff');
        
        if dist < min
            min = dist;
            closestCenterIdx = j;
        end
        
    end
    
    %TODO: If closest center is 0, dont add.
    feat(closestCenterIdx) = feat(closestCenterIdx) + 1;
    min = Inf;
    
end

% disp(feat);

% error('done with the first example');
end