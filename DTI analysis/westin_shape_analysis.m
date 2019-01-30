%% investigate where the spherical, planar, and linear westin shapes are in the vessel
clc
clear
%%
% load exploredti .mat and original .nii
load('dwi_middle_slices.mat');
dwi_nifti=load_nii(sprintf('dwi_middle_slices.nii'));
dwi_nifti=dwi_nifti.img;
% load exploredti outputs
pe_dir = 'dwi_middle_slices';
fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;
cl=load_nii(sprintf('%s_CL.nii',pe_dir));cl=cl.img;
cp=load_nii(sprintf('%s_CP.nii',pe_dir));cp=cp.img;
cs=load_nii(sprintf('%s_CS.nii',pe_dir));cs=cs.img;
%adc=load_nii(sprintf('%s_ADCs.nii',pe_dir));adc=adc.img;

%% pull out spherical componenets that are over a threshold
cs_new= cs.*(cs>0.35);
cp_new= cp.*(cp<0.2);
cl_new= cl.*(cl>0.4);
%% 
% overlay masks and filtered westin measure masks
original = dwi_nifti(:,:,3);
linear_region=cl(:,:,3);
spherical_region=cs(:,:,3);
planar_region=cp(:,:,3);
linear_region2=cl_new(:,:,3);
spherical_region2=cs_new(:,:,3);
planar_region2=cp_new(:,:,3);
C = imfuse(original, linear_region, 'falsecolor', 'Colorchannels', [1 2 2]);
D = imfuse(original, spherical_region, 'falsecolor', 'Colorchannels', [1 2 2]);
E = imfuse(original, planar_region, 'falsecolor', 'Colorchannels', [1 2 2]);
F = imfuse(original, linear_region2, 'falsecolor', 'Colorchannels', [1 2 2]);
G = imfuse(original, spherical_region2, 'falsecolor', 'Colorchannels', [1 2 2]);
H = imfuse(original, planar_region2, 'falsecolor', 'Colorchannels', [1 2 2]);
subplot(2,3,1)
imshow(C);
set(gca,'xdir','reverse')
camroll(-90)
title('Linear')
subplot(2,3,2)
imshow(D);
set(gca,'xdir','reverse')
camroll(-90)
title('Spherical')
subplot(2,3,3);
imshow(E);
set(gca,'xdir','reverse')
camroll(-90)
title('Planar')
subplot(2,3,4)
imshow(F);
set(gca,'xdir','reverse')
camroll(-90)
title('Linear > 0.4')
subplot(2,3,5)
imshow(G);
set(gca,'xdir','reverse')
camroll(-90)
title('Spherical > 0.35')
subplot(2,3,6);
imshow(H);
set(gca,'xdir','reverse')
camroll(-90)
title('Planar > 0.2')
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
