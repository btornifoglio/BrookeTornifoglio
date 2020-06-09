
clc;
clear;
close all 

% *Change this input* based on what you've named the base nifti.
pe_dir = '2611';
metric=load_nii(sprintf('%s_dti.nii',pe_dir));metric=metric.img;

metric_mean = zeros(1,96);
slices = size(metric);
format long 
for i = 1:96;    
    answer = mean(nonzeros(metric(:,:,i)));
    metric_mean(i) = answer;
end 
metric_mean=metric_mean';

for j = 1:96;    
    answer = std(nonzeros(metric(:,:,j)));
    metric_std(j) = answer;
end 
metric_std=metric_std';
snr = metric_mean ./ metric_std;
values = [metric_mean, metric_std, snr];

%% this doesnt work
b_zeroes = metric(:,:,:,1);

percentile_tf = zeros(1,96);
format long
for j = 1:96;    
    ans1 = prctile(b_zeroes(:,:,j),25);
    percentile_tf(j) = ans1;
end 

%% find the 25th / 75th percentile for 19 slices ; IQR (75th - 25th)
% use to determine the 25th percentile of gibbs corrected data in order to
% make mask 1 for exploredti analysis 

b_zeroes = metric(:,:,:,1);
b_zeroes = metric;
rand0 = b_zeroes(:,:,1); rand0_1 = rand0(:);
rand1 = b_zeroes(:,:,10); rand1_1 = rand1(:);
rand15 = b_zeroes(:,:,15); rand15_1 = rand15(:);
rand2 = b_zeroes(:,:,20); rand2_1 = rand2(:);
rand25 = b_zeroes(:,:,25); rand25_1 = rand25(:);
rand3 = b_zeroes(:,:,30); rand3_1 = rand3(:);
rand35 = b_zeroes(:,:,35); rand35_1 = rand35(:);
rand4 = b_zeroes(:,:,40); rand4_1 = rand4(:);
rand45 = b_zeroes(:,:,45); rand45_1 = rand45(:);
rand5 = b_zeroes(:,:,50); rand5_1 = rand5(:);
rand55 = b_zeroes(:,:,55); rand55_1 = rand55(:);
rand6 = b_zeroes(:,:,60); rand6_1 = rand6(:);
rand65 = b_zeroes(:,:,65); rand65_1 = rand65(:);
rand7 = b_zeroes(:,:,70); rand7_1 = rand7(:);
rand75 = b_zeroes(:,:,75); rand75_1 = rand75(:);
rand8 = b_zeroes(:,:,80); rand8_1 = rand8(:);
rand85 = b_zeroes(:,:,85); rand85_1 = rand85(:);
rand9 = b_zeroes(:,:,90); rand9_1 = rand9(:);
rand96 = b_zeroes(:,:,96); rand96_1 = rand96(:);

rand_slices = [ rand0_1 rand1_1 rand15_1 rand2_1 rand25_1 rand3_1 rand35_1 rand4_1 ...
    rand45_1 rand5_1 rand55_1 rand6_1 rand65_1 rand7_1 rand75_1 ...
    rand8_1 rand85_1 rand9_1 rand96_1];

rand_tf_percent = prctile(rand_slices,25); rand_tf_percent = rand_tf_percent';
rand_sf_percent = prctile(rand_slices,75); rand_sf_percent = rand_sf_percent';
rand_iqr = iqr(rand_slices); rand_iqr = rand_iqr';
test = rand_sf_percent - rand_tf_percent;

figure()
subplot(1,3,1)
bar(rand_tf_percent)
hold on
plot(xlim,[mean(rand_tf_percent) mean(rand_tf_percent)],'r')
title('25th percentile')
xlabel(' Slice number (*10)')
txt = ['Mean: ' num2str(mean(rand_tf_percent)) ];
text(8,10000,txt)
ylim([0 25000])

subplot(1,3,2)
bar(rand_sf_percent)
hold on
plot(xlim,[mean(rand_sf_percent) mean(rand_sf_percent)],'r')
title('75th percentile')
txt = ['Mean: ' num2str(mean(rand_sf_percent)) ];
text(5,10000,txt)
xlabel(' Slice number (*10)')
ylim([0 25000])

subplot(1,3,3)
bar(rand_iqr)
hold on
plot(xlim,[mean(rand_iqr) mean(rand_iqr)],'r')
title('Interquartile range')
txt = ['Mean: ' num2str(mean(rand_iqr)) ];
text(8,10000,txt)
xlabel(' Slice number (*10)')
ylim([0 25000])

%%
x = (0:95');
scatter(x, fa_mean)
grid on
ylabel('FA');xlabel('slice')
ylim([0 .6]); title('N1');


