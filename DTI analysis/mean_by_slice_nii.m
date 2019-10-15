
clc;
clear;
close all 

% *Change this input* based on what you've named the base nifti.
pe_dir = '4';

fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;
%%
fa_mean = zeros(1,60);
slices = size(fa);

for i = 1:60;    
    answer = mean(nonzeros(fa(:,:,i)));
    fa_mean(i) = answer;
end 
fa_mean=fa_mean';
