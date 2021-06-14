%% k means clustering attempts on dti data (based off tutorial from AS)
clc
clear
% load in FA and MD niftis and specify specific slice for analysis
fa=load_nii('mask3_manual_FA.nii');fa=fa.img;
fa=fa(:,:,17);
md=load_nii('mask3_manual_MD.nii');md=md.img;
md=md(:,:,17);

% pretty colours for plotting
colr = [0 0.4470 0.7410; ...
        0.8500 0.3250 0.0980; ...
        0.9290 0.6940 0.1250; ...
        0.4940 0.1840 0.5560; ...
        0.4660 0.6740 0.1880; ...
        0.3010 0.7450 0.9330; ...
        0.6350 0.0780 0.1840];
%% Clustering

% NOTE: here I've concatenated the three mri contrasts and k-means will use all
% use all three contrasts to create clusters. Alternative options are provided

% to cluster based on 2 contrasts (FA and MD)
img = cat(3,fa,md); 

% to cluster based on 1 constrast
%img = fa; 
%%
k = 10; % number of clusters determined using elbow method.
% (https://www.kdnuggets.com/2019/10/clustering-metrics-better-elbow-method.html)
% perform clustering
[k_labels,k_centers] = imsegkmeans(single(img),k);

% k_labels is the segmented labeled output 
% k_centers are centroid locations in the cluster location
%%
% set-up for color-coded ROIs
ROIimage = fa; % could make this the b0 or mean b800
colr = {'black',...
        'blue', 'cyan', 'green', 'magenta', 'red', 'yellow', ...
        'blue', 'cyan', 'green', 'magenta', 'red', 'yellow', ...
        'blue', 'cyan', 'green', 'magenta', 'red', 'yellow'};
    
    % make regional measurements
for kID = 1:k

    % make ROIs from clusters
    roi(:,:,kID) = k_labels == kID;

    % overlay ROI on image & color-code
    ROIimage = imoverlay(ROIimage, roi(:,:,kID), colr{kID});

    % extract ROI measures
    Fa(kID,1) = mean(fa(roi(:,:,kID)));
    Md(kID,1) = mean(md(roi(:,:,kID)));

    % Segmented Images
    FaSeg(:,:,kID) = Fa(kID,1) .* roi(:,:,kID);
    MdSeg(:,:,kID) = Md(kID,1) .* roi(:,:,kID);
end
    %%
% display color coded cluster
figure, hold on
title(sprintf('Colour coded Clusters, k=%.0f',k))
imshow(ROIimage)

% % display seperate ROIs
% figure('Name','Individual Clusters / ROIs','NumberTitle','off')
% hold on
% rc = ceil(sqrt(k)); % calculate rows and cols for subplot
% for K = 1:k
%     subplot(rc,rc,K), hold on
%     imshow(roi(:,:,K),'displayrange',[])
% end

% display segmented image
FaSeg = sum(FaSeg,3);
MdSeg = sum(MdSeg,3);
figure('Name','Segemented Images','NumberTitle','off')
subplot(1,2,1)
imshow(FaSeg,'displayrange',[]), colorbar, title('Segmented FA')
subplot(1,2,2)
imshow(MdSeg,'displayrange',[]), colorbar, title('Segmented MD')
%% 

%display means per clusters

figure;
subplot(1,2,1)
bar(Fa)
title('Mean FA per cluster');
ylim([0 0.3]);

subplot(1,2,2)
bar(Md)
title('Mean MD per cluster');
ylim([0 0.002]);