clc;    % Clear the command window.
clear all;
close all;
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;

% Define a starting folder.
start_path = fullfile('D:\Everything\Plaque mech testing\Plaque 44\Sections\CC-1_T\Histology\PLM\CC-1-8');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
    return;
end

% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
%%
% Loop true folders
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)

% Process all image files in those folders.
counter = 1;
for k = 1 : numberOfFolders
    
    AA(k)=listOfFolderNames(k);
    
end

i=1;
for j = 1 :numberOfFolders
    
    %%change current directory (1 at a time) to run code in
    cd(AA{j})
    disp RUN_CODE
    pwd
    Q=AA{j};
    
    if exist([pwd filesep 'L.tif'], 'file')==2
        
        %% READ IN POLARISED IMAGES AND COMBINE
        A = imread('cc8-16-p1-6.tif');
        B = imread('cc8-16-p2-6.tif');
        %         figure(1);imshow(A); title('PLM1');
        %         figure(2);imshow(B); title('PLM2');
        
        Z = imadd(A,B);     %Combined PLM
  
        figure(3);imshow(Z); title('Combined PLM'); saveas(gcf,'CC8-16-plm-6.tif');
               
        % READ IN LIGHT IMAGES
        L = imread('cc8-16-bf-6.tif'); %Light Microscopy
        figure(4); imshow(L); title('Light Microscope'); saveas(gcf,'CC8-16-BFM-6.tif');
        
        % PROCESS LIGHT IMAGES
        HSV = rgb2hsv(L);
         figure(5); imshow(HSV); title('HSV - Tissue Content'); saveas(gcf,'HSV.tif');
        S=HSV(:,:,2);
         figure(6); imshow(S); title('Saturation Channel to determine tissue content'); %saveas(gcf,'SaturationChannel.tif');
         
        %
        [level EM] = graythresh(L);
        BW = im2bw(S,0.2); % Select level or hard code threshold value
        invert = ~BW;
        tissue_area = sum(invert(:) == 0); %tissue content - count black pixels
        figure(7); imshow(invert); title('Tissue Content = Black'), %saveas(gcf,'TissueContent.tif');   
        
        %
        %PROCESS PLM IMAGES
        PLM_grey = rgb2gray(Z);
         figure(8); imshow(PLM_grey);%saveas(gcf,'Greyscale.tif');
         
        %
        %Adaptive method
       % BW2 = imbinarize(PLM_grey, 'adaptive','Sensitivity',0.5); adds
       % speckles
        BW2 = imbinarize(PLM_grey, 0.2);
        collagen_area = sum(BW2(:) == 1); %collagen content - count white pixels
        figure(9); imshow(BW2), saveas(gcf,'Collagen.tif');  % collagen content = white    
        
        %
        %Clean up stray blobs in image smaller than 80 pixels
        BW2_clean = bwareaopen(BW2, 80);
        
        clean_collagen_area = sum(BW2_clean(:) == 1);

        % CALCULATE PERCENT COLLAGEN
        content = (collagen_area)/tissue_area;
        content_clean = (clean_collagen_area)/tissue_area
        content_clean = content_clean*100;
        figure(10); imshow(BW2_clean); 
        title(sprintf('Collagen content (clean) = %d ', content_clean)),saveas(gcf,'CC8-16-CollCon-6.tif');
        
        i=i+1;
    end
end
