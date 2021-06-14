% Loop over a range of clusters, 1 to X in this case

clear
clc
close all
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
%img = cat(3,fa,md); %clustering on FA and MD

% to cluster based on 1 constrast
img = cat(3,fa,md); % perform clustering only on FA
k_range=2:50;
for k = k_range
    [sse(k) rmse(k)] = kmeans_error(single(img), k);
end
%%
% Display elbow plot
if true
    F1 = figure; hold on
    title('SSE')
    xlabel('k (# clusters)'), ylabel('Sum-square error')
    F2 = figure; hold on
    title('RMSE')
    xlabel('k (# clusters)'), ylabel('Euclidean Distance (RMSE)')
    figure(F1), hold on, plot(k_range,sse(k_range(1):end),'-o')
    figure(F2), hold on, plot(k_range,rmse(k_range(1):end),'-o')
end