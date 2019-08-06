clear;clc;close all;

dwi_nifti=load_nii(sprintf('dti.nii'));
dwi_nifti=dwi_nifti.img;
b0_data = dwi_nifti(:,:,35,1);
bX_data = dwi_nifti(:,:,35,2);


imshow(b0_data)
title('Move ROI to tissue')
h = imrect(gca, [2 4 2 4]);
setResizable(h,0)
position = wait(h);
tissue_b0 = imcrop(b0_data,position);
tissue_b800 = imcrop(bX_data,position);

imshow(b0_data)
title('Move ROI to PBS')
h2 = imrect(gca, [2 4 2 4]);
setResizable(h2,0)
position2 = wait(h2);
pbs_b0 = imcrop(b0_data,position2);
pbs_b800 = imcrop(bX_data,position2);

imshow(b0_data)
title('Move ROI to noise')
h3 = imrect(gca, [2 4 2 4]);
setResizable(h3,0)
position3 = wait(h3);
noise_b0 = imcrop(b0_data,position3);
noise_b800 = imcrop(bX_data,position3);

mean_tissue_sb0 = mean(tissue_b0);
std_tissue_sb0 = std(double(tissue_b0));
mean_tissue_sb800 = mean(tissue_b800);
std_tissue_sb800 = std(double(tissue_b800));

mean_pbs_sb0 = mean(pbs_b0);
std_pbs_sb0 = std(double(pbs_b0));
mean_pbs_sb800 = mean(pbs_b800);
std_pbs_sb800 = std(double(pbs_b800));

mean_noise_sb0 = mean(noise_b0);    
std_noise_sb0 = std(double(noise_b0));
mean_noise_sb800 = mean(noise_b800);
std_noise_sb800 = std(double(noise_b800));

b0_SNR = mean_tissue_sb0/mean_noise_sb0;
b800_SNR = mean_tissue_sb800/std_noise_sb800;
DWI_SNR = b0_SNR/b800_SNR;

T = table([b0_SNR; b800_SNR; DWI_SNR], 'VariableNames',...
    {'SNR'},'RowNames', {'b0', 'bX','DWI'})
