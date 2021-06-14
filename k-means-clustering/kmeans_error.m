function [avg_sse avg_rmse] = kmeans_error(img, k)
% Calculate errors for k-means clustering
% Errors calculated are sum square error (SSE) & norm | Euclidean distance | RMSE

[k_labels,k_centers] = imsegkmeans(img,k);
%%
% % determine size of dimensions (if mulitple contrasts used for clustering)
[rows cols dim3] = size(img);
%%
if dim3 == 1
    % one contrast used for clustering
    for kID = 1:k
        roi(:,:,kID) = k_labels == kID;
        sse(kID) = sum((img(roi(:,:,kID)) - k_centers(kID)).^2);
        rmse(kID) = norm(img(roi(:,:,kID)) - k_centers(kID)); 
    end
elseif dim3 > 1
    % > one contrast used for clustering
    for kID = 1:k
        roi(:,:,kID) = k_labels == kID;
        ROI = repmat(roi(:,:,kID),[1 1 dim3]);
        roi_size = sum(sum(roi(:,:,kID)));
        k_centers_v = [ones(roi_size,1) .* k_centers(kID,1); ...
                       ones(roi_size,1) .* k_centers(kID,2)]; 
                       %ones(roi_size,1) .* k_centers(kID,3)]; %if using 3
                       % contrasts
        sse(kID) = sum((img(ROI) - k_centers_v).^2);
        rmse(kID) = norm(img(ROI) - k_centers_v);
    end
end

avg_sse = mean(sse);
avg_rmse = mean(rmse);