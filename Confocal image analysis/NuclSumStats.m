function [numNucl,avgAng,angStd,angCounts,avgRatio,ratStd,avgArea,areaStd] = NuclSumStats(data,binSize)
%[num,avgAng,angStd,avgRatio,ratStd,avgArea,areaStd] = NuclSumStats(data)
%Input:
%data- an n x 4 matrix of n nuclear measurements
%data(:,1)- nuclear area
%data(:,2)- major axis of fitted elipse
%data(:,3)- minor axis of fitted elipse
%data(:,4)- angle of alignment 0 degrees to 180 degrees
%binsize - size of histogram bins in degrees
%
%Outputs:
% numNucl - number of nuclei in the image
% avgAng - circular average of nuclear angle
% angCounts - counts of angles in bins of binsize
% angStd - circular standard deviation of nuclear angle
% avgRatio - average value of minor/major axis ratio
% ratStd - standard deviation of minor/major axis ratio
% avgArea - average nuclear area
% areaStd - standard deviation of nuclear area

%calculate number of Nuclei
[numNucl,~] = size(data);

%calculate average and standard deviation of nuclear area
avgArea = mean(data(:,1));
areaStd = std(data(:,1));

%calculate ratios
ratios = data(:,3)./data(:,2);

%average and standard deviation of ratios
avgRatio = mean(ratios);
ratStd = std(ratios);

%average and standard deviation of angles
angles = zeros(1,numNucl);

for i=1:numNucl
    if data(i,4)>90
        angles(i)=data(i,4)-180;
    else
        angles(i)=data(i,4);
    end
end

%counts for histogram
edges = -90:binSize:90;
angCounts = histcounts(angles,edges);

angles = deg2rad(angles);
%axial data has a correction factor of 2
[~,meanAng] = circ_axialmean(angles,2,2);
sd=circ_std(angles, [],[],2);
avgAng = rad2deg(meanAng);
angStd=rad2deg(sd);
