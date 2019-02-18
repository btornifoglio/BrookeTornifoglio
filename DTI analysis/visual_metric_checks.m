%% Investigate location specific parameters to inform masking and analysis

clc
clear

% Load in the .nii and ExploreDTI datasets
load('dwi_pa_gibbs.mat');
dwi_nifti=load_nii(sprintf('dwi_pa_gibbs.nii'));
dwi_nifti=dwi_nifti.img;
% Input nomenclature from the outputted ExploreDTI data
pe_dir = 'dwi_pa_gibbs';
fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;
cl=load_nii(sprintf('%s_CL.nii',pe_dir));cl=cl.img;
cp=load_nii(sprintf('%s_CP.nii',pe_dir));cp=cp.img;
cs=load_nii(sprintf('%s_CS.nii',pe_dir));cs=cs.img;
%dt=load_nii(sprintf('%s_DT.nii',pe_dir));dt=dt.img;
%adc=load_nii(sprintf('%s_ADCs.nii',pe_dir));adc=adc.img;

%% Threshold components
cs_new= cs.*(cs>0.4);
cp_new= cp.*(cp>0.4);
cl_new= cl.*(cl>0.4);
fa_new= fa.*(fa>0.2);
%fa_new=fa_new.*(fa_new<0.35);
md_new= md.*(md>0.001);
%% 
% Overlay parameter maps on the original data. Careful of slice selection. 

%original = dt(:,:,18);
% fractional_anisotropy=fa_new(:,:,18);
% mean_diffusivity=md_new(:,:,18);
% planar_region2=cp_new(:,:,18);
% linear_region2=cl_new(:,:,18);
% spherical_region2=cs_new(:,:,18);

% C = imfuse(original, fractional_anisotropy, 'falsecolor', 'Colorchannels', [1 2 2]);
% D = imfuse(original, mean_diffusivity, 'falsecolor', 'Colorchannels', [1 2 2]);
% E = imfuse(original, planar_region2, 'falsecolor', 'Colorchannels', [1 2 2]);
% F = imfuse(original, linear_region2, 'falsecolor', 'Colorchannels', [1 2 2]);
% G = imfuse(original, spherical_region2, 'falsecolor', 'Colorchannels', [1 2 2]);

subplot(2,5,1)
imshow(fa(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('FA')

subplot(2,5,2)
imshow(md(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('MD')

subplot(2,5,3)
imshow(cs(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('Spherical')

subplot(2,5,4)
imshow(cl(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('Linear')

subplot(2,5,5)
imshow(cp(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('Planar')

subplot(2,5,6)
imshow(fa_new(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('FA > 0.2')

subplot(2,5,7);
imshow(md_new(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('MD > 0.003')

subplot(2,5,8);
imshow(cs_new(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('Spherical > 0.4')

subplot(2,5,9)
imshow(cl_new(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('Linear > 0.4')

subplot(2,5,10)
imshow(cp_new(:,:,53));
set(gca,'xdir','reverse'); camroll(-90); title('Planar > 0.4')

%%
%overlay FA maps to see degree of anistropy
fa_new= fa.*(fa>0.3);
FA_map=fa(:,:,2);
FA_thresholded=fa_new(:,:,2);
C = imfuse(dwi_nifti(:,:,2), FA_map, 'falsecolor', 'Colorchannels', [1 2 2]);
D = imfuse(dwi_nifti(:,:,2), FA_thresholded, 'falsecolor', 'Colorchannels', [1 2 2]);
subplot(2,1,1)
imshow(C)
subplot(2,1,2)
imshow(D)

slice1_voxels = nnz(fa(:,:,1));
slice2_voxels = nnz(fa(:,:,2));
slice3_voxels = nnz(fa(:,:,3));
slice4_voxels = nnz(fa(:,:,4));
slice5_voxels = nnz(fa(:,:,5));
slice6_voxels = nnz(fa(:,:,6));
slice7_voxels = nnz(fa(:,:,7));
slice8_voxels = nnz(fa(:,:,8));

grab= fa~=0; %obtain all voxel values 
output = fa(grab);

%%
adc_map=adc(:,:,3);
C = imfuse(dwi_nifti(:,:,3), adc_map, 'falsecolor', 'Colorchannels', [1 2 2]);

imshow(C)
