%% This code aims to analyze the metrics outputted from the DTI pipeline. 
% Specifically: FA, MD, Cl, Cs, Cp, and westin shapes are visualised. 
% SNR for DWI images is also calculated for the tissue, media, and
% background.

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

clc;
clear;

% *Change this input* based on what you've named the base nifti after all
% corrections.
pe_dir = 'dwi_pa_gibbs';
% This loads in each nifti metric, converts from character to 3D double
% (y pixel by x pixel by number of slices) then reshapes into a single
% vector of all values.
fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;fa=reshape(fa,1,[]);
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;md=reshape(md,1,[]);
cl=load_nii(sprintf('%s_CL.nii',pe_dir));cl=cl.img;cl=reshape(cl,1,[]);
cp=load_nii(sprintf('%s_CP.nii',pe_dir));cp=cp.img;cp=reshape(cp,1,[]);
cs=load_nii(sprintf('%s_CS.nii',pe_dir));cs=cs.img;cs=reshape(cs,1,[]);

% ^ can add in ADC, RA, TA, etc. in same manner if other metrics to be
% analysed.

%% This section resizes and sorts the metrics.

% Takes the metrics and based on the FA (which is assumed to
% be masked for the desired regions) finds the non-zero terms, and
% transposes a vector of the FA values in the masked region.
i=find (fa>0 & fa <1);
fa=fa(i);fa=fa';
cl=cl(i);cl=cl';
cp=cp(i);cp=cp';
cs=cs(i);cs=cs';

% The MD is thresholded 
md=md(i);md=md';
md(md>=3e-3)=3e-3;


%% This section created histrograms of the distributions of each metric. 

figure
subplot(2,3,1)
histogram(cl,50,'Normalization','probability');ylabel('VF');xlabel('C_L')
xlim([0 1]); ylim([0 .15])
subplot(2,3,2)
histogram(cs,50,'Normalization','probability');ylabel('VF');xlabel('C_S')
xlim([0 1]); ylim([0 .15])
subplot(2,3,3)
histogram(cp,50,'Normalization','probability');ylabel('VF');xlabel('C_P')
xlim([0 1]); ylim([0 .15])
subplot(2,3,4)
histogram(md,50,'Normalization','probability');ylabel('VF');xlabel('MD')
xlim([0 3e-3])
subplot(2,3,5); ylim([0 .2])
histogram(fa,50,'Normalization','probability');ylabel('VF');xlabel('FA')
xlim([0 1]); ylim([0 .1])


%% Generate westin shape diagram.

% Uses an open source function for generating 3 seperate ternary plots.

% A surface plot
figure
d = linspace(0,1,length(cl)); 
[hg,htick,hcb]=tersurf(cl,cp,cs,d);

% A contour plot
figure;
[h,hg,htick]=terplot;
[h,c,hcb]=tercontour(cl,cp,cs,d);

% A scatter plot (use this)
figure;
[h,hg,htick]=terplot;
[hd,hcb]=ternaryc(cl,cp,cs,d,'.');
hlabels=terlabel('Linear','Planar','Spherical');
p(1).MarkerSize = 100;

%% Calculate diffusion weighted signal to noise ratio

prompt = 'What is the b value? ';
X=input(prompt);

% Load in the corrected nifti file and separate out the B0 and B800 data
% for one slice. Make sure you chose an appropriate slice. 
dwi_nifti=load_nii(sprintf('dwi_pa_11.nii')); dwi_nifti=dwi_nifti.img;
b0_data = dwi_nifti(:,:,18,1);
b800_data = dwi_nifti(:,:,18,2);

% Display the B0 slice and draw a ROI on the tissue sample. This ROI is
% then masked for both the B0 and B800 data.

% *this section needs work - currently no control (besides visual check) on
% ROI being the same for each region*
figure
imshow(b0_data);
title('Draw ROI on tissue')
h = imrect(); % press enter to continue
tissue_b0_mask = createMask(h);
tissue_b0_mask = int32(tissue_b0_mask).*int32(b0_data);
tissue_b800_mask = int32(tissue_b0_mask).*int32(b800_data);
tissue_b0_values = tissue_b0_mask(tissue_b0_mask~=0);
tissue_b800_values = tissue_b800_mask(tissue_b800_mask~=0);

imshow(b0_data);
title('Draw ROI in solution')
h2 = imrect();
solution_mask = createMask(h2);
solution_b0_mask = int32(solution_mask).*int32(b0_data);
solution_b800_mask = int32(solution_mask).*int32(b800_data);
solution_b0_values = solution_b0_mask(solution_b0_mask~=0);
solution_b800_values = solution_b800_mask(solution_b800_mask~=0);

imshow(b0_data);
title('Draw ROI in background')
h3 = imrect();
background_mask = createMask(h3);
background_b0_mask = int32(background_mask).*int32(b0_data);
background_b800_mask = int32(background_mask).*int32(b800_data);
background_b0_values = background_b0_mask(background_b0_mask~=0);
background_b800_values = background_b800_mask(background_b800_mask~=0);

% Calculate the average (within the ROI) and standard deviation of the 
% signal in the b0 and b800 tissue, solution and background regions.
b0_tissue_signal_ave = mean(tissue_b0_values);
b0_tissue_signal_std = std(double(tissue_b0_values));
b0_tissue_SNR = b0_tissue_signal_ave/b0_tissue_signal_std;

b800_tissue_signal_ave = mean(tissue_b800_values);
b800_tissue_signal_std = std(double(tissue_b800_values));
b800_tissue_SNR = b800_tissue_signal_ave/b800_tissue_signal_std;

b0_solution_signal_ave = mean(solution_b0_values);
b0_solution_signal_std = std(double(solution_b0_values));
b0_solution_SNR = b0_solution_signal_ave/b0_solution_signal_std;

b800_solution_signal_ave = mean(solution_b800_values);
b800_solution_signal_std = std(double(solution_b800_values));
b800_solution_SNR = b800_solution_signal_ave/b800_solution_signal_std;

b0_background_signal_ave = mean(background_b0_values);
b0_background_signal_std = std(double(background_b0_values));
b0_background_SNR = b0_background_signal_ave/b0_background_signal_std;

b800_background_signal_ave = mean(background_b800_values);
b800_background_signal_std = std(double(background_b800_values));
b800_background_SNR = b800_background_signal_ave/b800_background_signal_std;

% Calculate the standard ADC values for the tissue
ADC_standard = 1/X * log(b0_tissue_signal_ave/b800_tissue_signal_ave);

% Calculate the SNR with respect to the solution and with respect to the
% background region
b0_SNR_tissue_solution = b0_tissue_signal_ave/b0_solution_signal_std;
b800_SNR_tissue_solution = b800_tissue_signal_ave/b800_solution_signal_std;

b0_SNR_tissue_background = b0_tissue_signal_ave/b0_background_signal_std;
b800_SNR_tissue_background = b800_tissue_signal_ave/b800_background_signal_std;

% Display results of SNR calculations
b0_data = [b0_tissue_SNR; b0_solution_SNR; b0_background_SNR];
b800_data = [b800_tissue_SNR; b800_solution_SNR; b800_background_SNR];
SNR_titles = {'Tissue'; 'Solution' ; 'Background'};
T = table(SNR_titles, b0_data, b800_data)


% % recalculate the ADC with respect to the signal value to noise ratio
% SVNR_b0 = b0_SNR;
% SVNR_bX = bX_SNR;
% 
% ADC_SVNR = 1/X * log(SVNR_b0/SVNR_bX); % seems off; wrong sign 
% 
% b0_bX_ratio = b0_SNR / bX_SNR;

