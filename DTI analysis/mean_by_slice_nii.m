
clc;
clear;
close all 

% *Change this input* based on what you've named the base nifti.
pe_dir = 'N6';
fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;
%%
fa_mean = zeros(1,96);
slices = size(fa);
format long 
for i = 1:96;    
    answer = mean(nonzeros(fa(:,:,i)));
    fa_mean(i) = answer;
end 
fa_mean=fa_mean';

for j = 1:18;    
    answer = std(nonzeros(fa(:,:,j)));
    fa_std(j) = answer;
end 
fa_std=fa_std';
%%
x = (0:95');
scatter(x, fa_mean)
grid on
ylabel('FA');xlabel('slice')
ylim([0 .6]); title('N1');

%%
a = nonzeros(reshape(fa(:,:,1), [16384 1]));
