clear
clc

% load in the diffusion weighted data, with b0s and bXs
dwi_nifti=load_nii(sprintf('dti_32dir.nii'));
dwi_nifti=dwi_nifti.img;
b0_data = dwi_nifti(:,:,1,1);
bX_data = dwi_nifti(:,:,1,2);

% create masks of the sample ROI and the noise ROI
% will only work if ROIs are same size...?
imshow(b0_data);
title('Draw ROI for tissue')
h = imrect(); 
hold
title('Draw ROI for noise')
h2 = imrect(); 
hold
title('Draw ROI for PBS')
h3=imrect()
% press enter to continue
sample_b0_mask = createMask(h);
sample_b0 = nonzeros(int32(sample_b0_mask).*int32(b0_data));
sample_bX = nonzeros(int32(sample_b0_mask).*int32(bX_data));
noise_b0_mask = createMask(h2);
noise_b0 = nonzeros(int32(noise_b0_mask).*int32(b0_data));
noise_bX = nonzeros(int32(noise_b0_mask).*int32(bX_data));
PBS_b0_mask = createMask(h3);
PBS_b0 = nonzeros(int32(PBS_b0_mask).*int32(b0_data));
PBS_bX = nonzeros(int32(PBS_b0_mask).*int32(bX_data));
%%
mean_b0_tissue_signal = mean(sample_b0);
mean_bX_tissue_signal = mean(sample_bX);
mean_b0_PBS_signal = mean(PBS_b0);
mean_bX_PBS_signal = mean(PBS_bX);
std_b0_PBS = std(double(PBS_b0));
std_bX_PBS = std(double(PBS_bX));
std_b0_noise = std(double(noise_b0));
std_bX_noise = std(double(noise_bX));
b0_SNR = mean_b0_tissue_signal/std_b0_noise;
bX_SNR = mean_bX_tissue_signal/std_bX_noise;

b0_bX_SNR = b0_SNR/bX_SNR;
CNR_b0 =(mean_b0_tissue_signal-mean_b0_PBS_signal)/std_b0_PBS;
CNR_bX =(mean_bX_tissue_signal-mean_bX_PBS_signal)/std_bX_PBS;

T = table([b0_SNR; bX_SNR; b0_bX_SNR; CNR_b0; CNR_bX], 'VariableNames',...
    {'SNR'},'RowNames', {'b0', 'bX','DWI','b0 CNR', 'bX CNR'})
