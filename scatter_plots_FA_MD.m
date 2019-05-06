%% code to make scatter plots of fa and md of the tissue models
% run tissue_models code to get values in correct format.
clc 
clear
% first data set
pe_dir = 'masked';
fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;fa=reshape(fa,1,[]);
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;md=reshape(md,1,[]);
%% 
% second data set
pe_dir = 'slice57';
fa_2=load_nii(sprintf('%s_FA.nii',pe_dir));fa_2=fa_2.img;fa_2=reshape(fa_2,1,[]);
md_2=load_nii(sprintf('%s_MD.nii',pe_dir));md_2=md_2.img;md_2=reshape(md_2,1,[]);
%%
% third data set
pe_dir = 'slice58';
fa_3=load_nii(sprintf('%s_FA.nii',pe_dir));fa_3=fa_3.img;fa_3=reshape(fa_3,1,[]);
md_3=load_nii(sprintf('%s_MD.nii',pe_dir));md_3=md_3.img;md_3=reshape(md_3,1,[]);
%%
% fourth data set
pe_dir = 'slice59';
fa_4=load_nii(sprintf('%s_FA.nii',pe_dir));fa_4=fa_4.img;fa_4=reshape(fa_4,1,[]);
md_4=load_nii(sprintf('%s_MD.nii',pe_dir));md_4=md_4.img;md_4=reshape(md_4,1,[]);

%%
% fifth data set
pe_dir = 'slice60';
fa_5=load_nii(sprintf('%s_FA.nii',pe_dir));fa_5=fa_5.img;fa_5=reshape(fa_5,1,[]);
md_5=load_nii(sprintf('%s_MD.nii',pe_dir));md_5=md_5.img;md_5=reshape(md_5,1,[]);

%%
fa = nonzeros(fa);%fa_2 = nonzeros(fa_2);fa_3 = nonzeros(fa_3);fa_4 = nonzeros(fa_4);fa_5 = nonzeros(fa_5);
md = nonzeros(md);%md_2 = nonzeros(md_2);md_3 = nonzeros(md_3);md_4 = nonzeros(md_4);md_5 = nonzeros(md_5);
%%


figure()
scatter(md, fa, 10,'x')
% hold on
% scatter(md_2, fa_2,10,'x', 'b')
grid on
xticks([0.0004 0.0008]);yticks([.15 .3 .5]);
ylabel('FA');xlabel('MD')
xlim([0.0002 0.0018]); ylim([0 1])
set(gca,'FontSize',10)
legend('Surrounding patch')

figure()
scatter(md_2, fa_2,10,'x')
grid on
xticks([0.0004 0.0008]);yticks([.15 .3 .5]);
ylabel('FA');xlabel('MD')
xlim([0.0002 0.0018]); ylim([0 1])
set(gca,'FontSize',10)
legend( 'Slice 57')

figure()
scatter(md_3, fa_3, 10,'x')
grid on
xticks([0.0004 0.0008]);yticks([.15 .3 .5]);
ylabel('FA');xlabel('MD')
xlim([0.0002 0.0018]); ylim([0 1])
set(gca,'FontSize',10)
legend( 'Slice 58')

figure() 
scatter(md_4, fa_4, 10, 'x')
grid on
xticks([0.0004 0.0008]);yticks([.15 .3 .5]);
ylabel('FA');xlabel('MD')
xlim([0.0002 0.0018]); ylim([0 1])
set(gca,'FontSize',10)
legend( 'Slice 59')


figure() 
scatter(md_5, fa_5, 10, 'x')
grid on
xticks([0.0004 0.0008]);yticks([.15 .3 .5]);
ylabel('FA');xlabel('MD')
xlim([0.0002 0.0018]); ylim([0 1])
set(gca,'FontSize',10)
legend( 'Slice 60')
