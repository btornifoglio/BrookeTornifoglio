%% Code to generate the ADC vs. SNR relation based off of a non-diffusion 
% weighted image (b0) and one diffusion weighted image (bX)

clear
clc
% 
prompt = 'What is the b value? ';
X=input(prompt);

% load in the nifti files of the b0 and bX data
% you need to unzip the .nii file!!
dwi_nifti=load_nii(sprintf('dwi_pa_4.nii'));
dwi_nifti=dwi_nifti.img;
b0_data = dwi_nifti(:,:,1,1);
bX_data = dwi_nifti(:,:,1,2);

% create masks of the sample ROI and the noise ROI
imshow(b0_data);
title('Draw ROI for sample')
h = imrect(); % press enter to continue
sample_b0_mask = createMask(h);
sample_b0_mask = int32(sample_b0_mask).*int32(b0_data);
sample_bX_mask = int32(sample_b0_mask).*int32(bX_data);

imshow(b0_data);
title('Draw ROI for noise')
h2 = imrect();
noise_b0_mask = createMask(h2);
noise_b0_mask = int32(noise_b0_mask).*int32(b0_data);
noise_bX_mask = int32(noise_b0_mask).*int32(bX_data);

%% Calculate the SNR and ADC
% Collect non-zeroes, find mean, standard deviation
sample_b0_values = sample_b0_mask(sample_b0_mask~=0);
sample_bX_values = sample_bX_mask(sample_bX_mask~=0);
noise_b0_values = noise_b0_mask(noise_b0_mask~=0);
noise_bX_values = noise_bX_mask(noise_bX_mask~=0);

b0_signal_ave = mean(sample_b0_values);
bX_signal_ave = mean(sample_bX_values);
% calculate the standard ADC values
ADC_standard = 1/X * log(b0_signal_ave/bX_signal_ave);

% calculate the SNR of b0 and bX images
b0_noise_std = std(double(noise_b0_values));
bX_noise_std = std(double(noise_bX_values));

b0_SNR = b0_signal_ave/b0_noise_std;
bX_SNR = bX_signal_ave/bX_noise_std;

% recalculate the ADC with respect to the signal value to noise ratio
SVNR_b0 = b0_SNR;
SVNR_bX = bX_SNR;

ADC_SVNR = 1/X * log(SVNR_b0/SVNR_bX); % seems off; wrong sign 

b0_bX_ratio = b0_SNR / bX_SNR;
%% Sanity check
% subplot (2,3,1)
% imshow(b0_data)
% title('b0 data')
% subplot(2,3,2)
% imshow(sample_b0_mask)
% title('b0 sample')
% subplot(2,3,3)
% imshow(sample_bX_mask)
% title('bX sample')
% subplot(2,3,4)
% imshow(bX_data)
% title('bX data')
% subplot(2,3,5)
% imshow(noise_b0_mask)
% title('b0 noise')
% subplot(2,3,6)
% imshow(noise_bX_mask)
% title('bX noise')