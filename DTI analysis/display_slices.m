% print out all slices of nifti
dwi_nifti=load_nii(sprintf('dwi_pa_noise_gibbs_corrected.nii'));
dwi_nifti=dwi_nifti.img;
b0_data = (dwi_nifti(:,:,:,1)); %b0

imshow(b0_data(:,:,1), 'DisplayRange',[0 1]);
figure
imagesc(b0_data(:,:,1))


%%
subplot(1,8,1)
imshow(b0_data(:,:,1), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,2)
imshow(b0_data(:,:,2), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,3)
imshow(b0_data(:,:,3), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,4)
imshow(b0_data(:,:,4), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,5)
imshow(b0_data(:,:,5), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,6)
imshow(b0_data(:,:,6), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,7)
imshow(b0_data(:,:,7), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
subplot(1,8,8)
imshow(b0_data(:,:,8), 'DisplayRange',[]);
set(gca,'xdir','reverse')
camroll(-90)
