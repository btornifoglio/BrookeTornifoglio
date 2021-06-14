% Example regional comparison of ex vivo MRI and histology using kmeans clustering
% Alan Stone 5th Feb 2021
% + annotations by me lol

% pretty colours for plotting
colr = [0 0.4470 0.7410; ...
        0.8500 0.3250 0.0980; ...
        0.9290 0.6940 0.1250; ...
        0.4940 0.1840 0.5560; ...
        0.4660 0.6740 0.1880; ...
        0.3010 0.7450 0.9330; ...
        0.6350 0.0780 0.1840];

% load images
% this just contains the brightfield, mag, qsm, r2s and saf for a single
% slice
load('hist_mri_data.mat')

% normalise SAF image
saf_norm = single(mat2gray(saf));

% display images
figure('Name','Initial MRI and Histology Images','NumberTitle','off')
subplot(2,3,1), imshow(mag,'displayrange',[]), title('MRI - Mag')
subplot(2,3,2), imshow(r2s,'displayrange',[]), title('MRI - R_2*')
subplot(2,3,3), imshow(qsm,'displayrange',[]), title('MRI - QSM')
subplot(2,3,4), imshow(bf,'displayrange',[]), title('Histology - BrightField Elastin')
subplot(2,3,5), imshow(saf,'displayrange',[]), title('Histology - SAF Elastin')
subplot(2,3,6), imshow(saf_norm,'displayrange',[]), title('Histology - SAF Elastin_{norm}')

% Clustering
% NOTE: here I've concatenated the three mri contrasts and k-means will use all
% use all three contrasts to create clusters. Alternative options are provided
img = cat(3,qsm,r2s,mag);
% img = qsm; % perform clustering only on QSM
% img = cat(2,qsm,r2s); % perform clustering only on combined QSM R2*

k = 10; % number of clusters determined using elbow method.
%  Have code for this if useful?
% (https://www.kdnuggets.com/2019/10/clustering-metrics-better-elbow-method.html)

% perform clustering
[k_labels,k_centers] = imsegkmeans(single(img),k);

% set-up for color-coded ROIs
ROIimage = mag;
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
    Mag(kID,1) = mean(mag(roi(:,:,kID)));
    R2s(kID,1) = mean(r2s(roi(:,:,kID)));
    QSM(kID,1) = mean(qsm(roi(:,:,kID)));
    BField(kID,1) = mean(bf(roi(:,:,kID)));
    SAF_n(kID,1) = mean(saf_norm(roi(:,:,kID)));

    % Segmented Images
    MagSeg(:,:,kID) = Mag(kID,1) .* roi(:,:,kID);
    R2sSeg(:,:,kID) = R2s(kID,1) .* roi(:,:,kID);
    QSMSeg(:,:,kID) = QSM(kID,1) .* roi(:,:,kID);
    BFieldSeg(:,:,kID) = BField(kID,1) .* roi(:,:,kID);
    SAF_nSeg(:,:,kID) = SAF_n(kID,1) .* roi(:,:,kID);

end

% display color coded cluster
figure, hold on
title(sprintf('Colour coded Clusters, k=%.0f',k))
imshow(ROIimage)

% display seperate ROIs
figure('Name','Individual Clusters / ROIs','NumberTitle','off')
hold on
rc = ceil(sqrt(k)); % calculate rows and cols for subplot
for K = 1:k
    subplot(rc,rc,K), hold on
    imshow(roi(:,:,K),'displayrange',[])
end

% display segmented image
MagSeg = sum(MagSeg,3);
R2sSeg = sum(R2sSeg,3);
QSMSeg = sum(QSMSeg,3);
BFieldSeg = sum(BFieldSeg,3);
SAF_nSeg = sum(SAF_nSeg,3);

figure('Name','Segemented Images','NumberTitle','off')

subplot(2,2,1), imshow(QSMSeg,'displayrange',[]), colorbar, title('Segmented QSM')
subplot(2,2,2), imshow(R2sSeg,'displayrange',[]), colorbar, title('Segmented R2*')
subplot(2,2,3), imshow(MagSeg,'displayrange',[]), colorbar, title('Segmented Mag')
subplot(2,2,4), imshow(SAF_nSeg,'displayrange',[]), colorbar, title('Segmented SAF_{norm}')

% NOTE: Need to include a check here to find the background. Check is currently
% done visually and assumes background is the first cluster!
% See the "Individual Clusters // ROIs" plot

Mag = Mag(2:end,1);
R2s = R2s(2:end,1);
QSM = QSM(2:end,1);
BField = BField(2:end,1);
SAF_n = SAF_n(2:end,1);
DataTable = table(Mag, R2s, QSM, BField, SAF_n);

% display correlation plots
figure ('Name','Correlations','NumberTitle','off')
corrplot(DataTable)
